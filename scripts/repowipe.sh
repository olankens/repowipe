#!/usr/bin/env bash

# Exit on any error
set -e && clear

# Change heading
printf "\033]0;%s\007" "REPOWIPE"

# Output welcome
welcome=$(
	cat <<-'EOD'
		╔════════════════════════════════════════════════════════════════════════════════╗
		║                                                                                ║
		║                    ▗▄▄▖ ▗▄▄▄▖▗▄▄▖  ▗▄▖ ▄   ▄ ▄▄▄ ▗▄▄▖ ▗▄▄▄▖                    ║
		║                    ▐▛▀▜▌▐▛▀▀▘▐▛▀▜▖ █▀█ █   █ ▀█▀ ▐▛▀▜▖▐▛▀▀▘                    ║
		║                    ▐▌ ▐▌▐▌   ▐▌ ▐▌▐▌ ▐▌▜▖█▗▛  █  ▐▌ ▐▌▐▌                       ║
		║                    ▐███ ▐███ ▐██▛ ▐▌ ▐▌▐▌█▐▌  █  ▐██▛ ▐███                     ║
		║                    ▐▌▝█▖▐▌   ▐▌   ▐▌ ▐▌▐█▀█▌  █  ▐▌   ▐▌                       ║
		║                    ▐▌ ▐▌▐▙▄▄▖▐▌    █▄█ ▐█ █▌ ▄█▄ ▐▌   ▐▙▄▄▖                    ║
		║                    ▝▘ ▝▀▝▀▀▀▘▝▘    ▝▀▘ ▝▀ ▀▘ ▀▀▀ ▝▘   ▝▀▀▀▘                    ║
		║                                                                                ║
		╚════════════════════════════════════════════════════════════════════════════════╝
	EOD
)
printf "\033[38;5;208m%s\033[00m\n\n" "$welcome"

# Handle parameters
message="${1:-chore: bootstrap initial project structure and configuration}"

# Gather current folder name as repo name
repo_name=$(basename "$(pwd)")

# Gather authenticated username
user=$(gh api user --jq '.login')

# Gather repo description
repo_description=$(gh repo view "$user/$repo_name" --json description -q ".description")

# Gather repo visibility
repo_visibility=$(gh repo view "$user/$repo_name" --json visibility -q ".visibility")
[[ "$repo_visibility" = "PUBLIC" ]] && repo_visibility="--public" || repo_visibility="--private"

# Delete existing remote repo
gh repo delete "$user/$repo_name" --yes

# Remove any existing local git history
rm -rf .git && git init && sleep 2

# Create new repository
gh repo create "$repo_name" \
	"$repo_visibility" \
	--description "$repo_description" \
	--disable-issues \
	--disable-wiki \
	--remote=origin \
	--source=.

# Ensure to star the repository
sleep 2 && gh api -X PUT "user/starred/$user/$repo_name"

# Create initial commit
git add .
git commit -m "$message"
git push -u origin main
