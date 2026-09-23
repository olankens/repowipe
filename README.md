<div align="center">
  <p><img src=".assets/icon.avif" align="center" width="128"></p>
  <h1><code>REPOWIPE</code></h1>
</div>

<table>
<tbody><tr><td align="center" width="99999"><div>
    <a href="https://olankens.com">WEBSITE</a> ·
    <a href="https://ko-fi.com/olankens">FUNDING</a>
  </div></td></tr></tbody>
  <tbody><tr><td align="center" width="99999">&nbsp;<div>
    Bash script using gh CLI to obliterate any GitHub repository together with commits, issues, pull requests, stars, discussions, and quite literally everything else connected to it, permanently and forever.
  </div>&nbsp;</td></tr></tbody>
  <tbody><tr><td align="center" width="99999">
    <a href="https://wikipedia.org/wiki/Bash_(Unix_shell)"><img src=".assets/bash.svg" alt="bash" align="center" width="56"></a>
    <picture><img src=".assets/divider.gif" align="center" height="40" width="1"/></picture>
    <a href="https://github.com"><img src=".assets/github.svg" alt="github" align="center" width="56"></a>
  </td></tr></tbody>
</table>

## PREVIEWS

<table><tbody><tr><td width="99999">
  <img src=".assets/preview-01.avif" align="center" width="49.21875%"><picture><img src=".assets/spacer.gif" align="center" width="1.5625%"></picture><img src=".assets/preview-02.avif" align="center" width="49.21875%">
</td></tr></tbody></table>

## FEATURES

<table>
  <tbody><tr><td width="99999">Snapshot the repository description, visibility, star status, and every feature toggle from issues and wikis to projects, pull requests, and workflow approval rights before the teardown begins.</td><td>✅</td></tr></tbody>
  <tbody><tr><td>Delete the remote repository through gh repo delete, permanently wiping all commits, issues, pull requests, stars, discussions, releases, packages, and every other artifact ever attached to it.</td><td>✅</td></tr></tbody>
  <tbody><tr><td>Remove leftover release artifacts from the working tree, such as a generated changelog file, so that release tooling starts over from a completely clean slate on the very next run.</td><td>✅</td></tr></tbody>
  <tbody><tr><td>Delete the entire .git folder and reinitialize the local Git history completely from scratch, so that no trace of previous commits, branches, tags, or stashes survives the destructive wipe.</td><td>✅</td></tr></tbody>
  <tbody><tr><td>Run the pnpm or npm prepare command automatically whenever a package.json exists, so that generated tooling, hooks, and dependencies are rebuilt right after the local reset completes.</td><td>✅</td></tr></tbody>
  <tbody><tr><td>Recreate the repository under its exact original name with the precise description backed up beforehand and the matching public or private visibility setting restored for it right afterwards.</td><td>✅</td></tr></tbody>
  <tbody><tr><td>Restore every single backed-up setting through the GitHub API, with each restore operation retried three times to survive the eventual consistency quirks on GitHub's side of things.</td><td>✅</td></tr></tbody>
  <tbody><tr><td>Create the initial commit using the provided message argument, or gracefully falls back to the sensible default bootstrap message when no message was passed to the script at runtime.</td><td>✅</td></tr></tbody>
</table>

## LEARNING

### RUN WITH DEFAULT MESSAGE

```shell
curl -fsSL https://raw.githubusercontent.com/olankens/repowipe/HEAD/scripts/repowipe.sh | bash
```

### RUN WITH CUSTOM MESSAGE

```shell
address="https://raw.githubusercontent.com/olankens/repowipe/HEAD/scripts/repowipe.sh"
message="chore: obliterate the repository and recreate the project from scratch"
curl -fsSL "$address" | bash -s -- "$message"
```

### LAUNCH PREPARE COMMAND

```shell
pnpm run prepare || npm run prepare
```
