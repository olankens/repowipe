#!/usr/bin/env bash

# shellcheck disable=SC2016,SC2059,SC2155
# shellcheck shell=bash

# region UTILITIES

enable_can_approve_pull_request_reviews() {

	# Handle parameters
	local enabled="${1:-true}"

	# Launch command
	gh api \
		--method PUT \
		-H "Accept: application/vnd.github+json" \
		"/repos/$(gh repo view --json nameWithOwner --jq .nameWithOwner)/actions/permissions/workflow" \
		-f default_workflow_permissions=write \
		-F can_approve_pull_request_reviews="$enabled"

}

enable_pull_requests() {

	# Handle parameters
	local enabled="${1:-true}"

	# Launch command
	gh api \
		--method PATCH \
		-H "Accept: application/vnd.github+json" \
		"/repos/$(gh repo view --json nameWithOwner --jq .nameWithOwner)" \
		-F has_pull_requests="$enabled"

}

enable_starred() {

	# Handle parameters
	local enabled="${1:-true}"

	# Launch command
	gh api \
		--method "$([[ "$enabled" == "true" ]] && echo PUT || echo DELETE)" \
		"/user/starred/$(gh repo view --json nameWithOwner --jq .nameWithOwner)"

}

gather_can_approve_pull_request_reviews() {

	# Launch command
	gh api \
		--method GET \
		-H "Accept: application/vnd.github+json" \
		"/repos/$(gh repo view --json nameWithOwner --jq .nameWithOwner)/actions/permissions/workflow" \
		--jq ".can_approve_pull_request_reviews"

}

gather_issues() {

	# Launch command
	gh repo view --json hasIssuesEnabled --jq .hasIssuesEnabled

}

gather_projects() {

	# Launch command
	gh repo view --json hasProjectsEnabled --jq .hasProjectsEnabled

}

gather_pull_requests() {

	# Launch command
	gh api graphql \
		-f query='
		  query($owner: String!, $name: String!) {
		    repository(owner: $owner, name: $name) {
		      hasPullRequestsEnabled
		    }
		  }
		' \
		-F owner="$(gh repo view --json nameWithOwner --jq '.nameWithOwner' | cut -d/ -f1)" \
		-F name="$(gh repo view --json nameWithOwner --jq '.nameWithOwner' | cut -d/ -f2)" \
		--jq '.data.repository.hasPullRequestsEnabled'

}

gather_starred() {

	# Launch command
	gh repo view --json viewerHasStarred --jq .viewerHasStarred

}

gather_wiki() {

	# Launch command
	gh repo view --json hasWikiEnabled --jq .hasWikiEnabled

}

invoke_wrapper() {

	# Handle parameters
	local heading="$1"
	local version="${2:-0.0.0}"
	local maximum="${3:-82}"
	local members=("${@:4}")

	# Change headline
	printf "\033[22;0t" && clear && printf "\033]0;%s\007" "$heading"

	# Output welcome
	local rw=$((${#version} + 5))
	local lw=$((maximum - rw - 3))
	local t=$(printf '%*s' "$lw" '' | tr ' ' '═')
	local r=$(printf '%*s' "$rw" '' | tr ' ' '═')
	local b=$(printf '%*s' "$lw" '')
	local e=$(printf '%*s' "$rw" '')
	local welcome="╔${t}╦${r}╗"$'\n'
	welcome+="║${b}║${e}║"$'\n'
	welcome+=$(printf '║  %-*s  ║  v%s  ║' "$((lw - 4))" "$heading" "$version")$'\n'
	welcome+="║${b}║${e}║"$'\n'
	welcome+="╚${t}╩${r}╝"
	printf "%s\n\n" "$welcome"

	# Output progress
	local bigness=$((${#welcome} / $(echo "$welcome" | wc -l)))
	local heading="\r%-"$((bigness - 19))"s   %-5s   %-8s\n\n"
	local loading="\033[93m\r%-"$((bigness - 19))"s   %02d/%02d   %-8s\b\033[0m"
	local failure="\033[91m\r%-"$((bigness - 19))"s   %02d/%02d   %-8s\n\033[0m"
	local success="\033[92m\r%-"$((bigness - 19))"s   %02d/%02d   %-8s\n\033[0m"
	printf "$heading" "FUNCTION" "ITEMS" "DURATION"
	local minimum=1 && local maximum=${#members[@]}
	for element in "${members[@]}"; do
		local written=$(basename "$(echo "$element" | cut -d "'" -f 1)" | tr "[:lower:]" "[:upper:]")
		if ((${#written} > bigness - 19)); then written="${written:0:$((bigness - 20))}…"; fi
		local started=$(date +"%s") && printf "$loading" "$written" "$minimum" "$maximum" "--:--:--"
		eval "$element" >/dev/null 2>&1 && local current="$success" || local current="$failure"
		local extinct=$(date +"%s") && local elapsed=$((extinct - started))
		local elapsed=$(printf "%02d:%02d:%02d\n" $((elapsed / 3600)) $(((elapsed % 3600) / 60)) $((elapsed % 60)))
		printf "$current" "$written" "$minimum" "$maximum" "$elapsed" && ((minimum++))
	done

	# Revert headline
	trap 'printf "\033[23;0t"' EXIT

	# Output newline
	printf "\n"

}

# endregion

# region FUNCTIONS

remake_remote() {

	# Handle parameters
	local message="${1:-feat: bootstrap initial feature implementations and configurations}"

	# Handle variables
	local deposit=$(basename "$(pwd)")
	local account=$(gh api user --jq '.login')

	# Backup settings
	local description=$(gh repo view "$account/$deposit" --json description -q ".description")
	local visibility=$(gh repo view "$account/$deposit" --json visibility -q ".visibility")
	local had_can_approve_pr_reviews=$(gather_can_approve_pull_request_reviews)
	local had_issues=$(gather_issues)
	local had_projects=$(gather_projects)
	local had_pull_requests=$(gather_pull_requests)
	local had_starred=$(gather_starred)
	local had_wiki=$(gather_wiki)

	# Delete remote
	gh repo delete "$account/$deposit" --yes

	# Remove remnants
	rm -f "CHANGELOG.md" && sleep 2

	# Remake locals
	rm -rf .git && git init && sleep 2
	if [[ -f "package.json" ]]; then pnpm run prepare || npm run prepare; fi

	# Remake remote
	[[ "$visibility" = "PUBLIC" ]] && visibility="--public" || visibility="--private"
	gh repo create "$deposit" "$visibility" --remote=origin --source=.

	# Restore settings
	for _ in {1..3}; do enable_can_approve_pull_request_reviews "$had_can_approve_pr_reviews"; done
	for _ in {1..3}; do enable_pull_requests "$had_pull_requests"; done
	for _ in {1..3}; do enable_starred "$had_starred"; done
	for _ in {1..3}; do gh repo edit --description "$description"; done
	for _ in {1..3}; do gh repo edit --enable-issues="$had_issues"; done
	for _ in {1..3}; do gh repo edit --enable-projects="$had_projects"; done
	for _ in {1..3}; do gh repo edit --enable-wiki="$had_wiki"; done

	# Create commit
	git add .
	git commit -m "$message"

}

# endregion

main() {

	# Enable strictness
	set -euo pipefail

	# Handle globals
	local heading="REPOWIPE"
	local version="0.0.0" # x-release-please-version

	# Handle parameters
	local message="${1:-}"

	# Handle functions
	local members=("remake_remote \"$message\"")

	# Invoke wrapper
	invoke_wrapper "$heading" "$version" "82" "${members[@]}"

}

if [[ -z "${BASH_SOURCE[0]:-}" || "${BASH_SOURCE[0]}" == "$0" ]]; then main "$@"; fi
