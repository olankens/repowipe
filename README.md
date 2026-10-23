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
    <a href="https://wikipedia.org/wiki/Bash_(Unix_shell)"><img src=".assets/logo-bash.svg" alt="bash" align="center" width="56"></a>
    <picture><img src=".assets/splitter.gif" align="center" height="40" width="1"/></picture>
    <a href="https://github.com"><img src=".assets/logo-github.svg" alt="github" align="center" width="56"></a>
  </td></tr></tbody>
</table>

## PREVIEWS

<table><tbody><tr><td width="99999">
  <img src=".assets/preview-01.avif" align="center" width="49.21875%"><picture><img src=".assets/spacer.gif" align="center" width="1.5625%"></picture><img src=".assets/preview-02.avif" align="center" width="49.21875%">
</td></tr></tbody></table>

## FEATURES

<table>
  <tbody><tr><td width="99999">Delete any GitHub repository together with all commits, issues, pull requests, stars, discussions plus every other connected artifact permanently forever without leaving remnants behind.</td><td>✅</td></tr></tbody>
  <tbody><tr><td>Backup repository configuration settings including description text, visibility level, issues toggle, projects flag, wiki switch, pull request review permissions before destroying the remote target.</td><td>✅</td></tr></tbody>
  <tbody><tr><td>Recreate destroyed repository from scratch using original visibility setting and push all current local files back to freshly created destination on GitHub server platform immediately today.</td><td>✅</td></tr></tbody>
  <tbody><tr><td>Restore previously saved repository configuration options like description, visibility, issues, projects, wiki, and pull request review permissions after the remote recreation completes successfully.</td><td>✅</td></tr></tbody>
  <tbody><tr><td>Reinitialize local Git workspace by removing existing history folder and creating fresh repository, then optionally running package preparation scripts when present inside project directory tree.</td><td>✅</td></tr></tbody>
  <tbody><tr><td>Display a polished terminal interface showing function names, item counters, elapsed duration timers, success or failure status indicators, and log file paths for every single operation.</td><td>✅</td></tr></tbody>
  <tbody><tr><td>Accept optional custom text parameter replacing default bootstrap label when creating initial commit after repository recreation finishes completely and correctly without any errors whatsoever.</td><td>✅</td></tr></tbody>
  <tbody><tr><td>Execute the entire wiping pipeline directly from a remote URL using curl piping into bash without requiring local installation, configuration, or manual download steps beforehand at all.</td><td>✅</td></tr></tbody>
</table>

## LEARNING

### ADD GITHUB PRIVILEGES

```shell
gh auth refresh -h github.com -s delete_repo
```

### INVOKE WITHOUT FLAGS

```shell
curl -fsSL https://github.com/olankens/repowipe/releases/latest/download/repowipe.sh | bash
```

### LAUNCH WITH MESSAGE

```shell
address="https://github.com/olankens/repowipe/releases/latest/download/repowipe.sh"
message="chore: obliterate the repository and recreate the project from scratch"
curl -fsSL "$address" | bash -s -- "$message"
```
