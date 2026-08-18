# Repowise Analysis Tool

This repository also supports [repowise-dev/repowise](https://github.com/repowise-dev/repowise) for Souz codebase analysis.

Repowise is different from Emerge: it indexes the target Git checkout directly, stores its working database in that checkout's `.repowise/` directory, and exposes analysis through the CLI, MCP tools, and a local dashboard. The generated `.repowise/` directory is a local cache and should not be committed.

## Requirements

- Python 3.11 or newer
- Repowise CLI:

```bash
pip install repowise
repowise --version
```

- A local Souz checkout:

```bash
export SOUZ_REPO=/path/to/souz
```

Repowise supports Kotlin, so the Souz Kotlin codebase can be indexed directly.

## Generate Souz Analysis

Run the helper from this repository:

```bash
export SOUZ_REPO=/path/to/souz
scripts/run-repowise-souz.sh
```

The helper runs a keyless, non-interactive index:

```bash
repowise init --yes --no-prose --no-editor-setup
```

That mode builds the dependency graph, Git history layer, code-health scores, dead-code findings, and a structure-derived wiki without API keys or model spend.

## Output Layout

Repowise stores its full index in the Souz checkout:

```text
$SOUZ_REPO/.repowise/
```

Repowise may also update local target-repo metadata such as `.gitignore` or MCP config files. Run it against a disposable worktree if you want to avoid touching your main Souz checkout.

The helper captures stable CLI snapshots in this repository:

```text
output/souz/repowise/
  version.txt
  init.txt
  doctor.txt
  health.txt
  dead-code.txt
  decisions.txt
  recent-risk.txt
  structurizr.dsl
  structurizr.txt
  target-git-status.txt
```

If a snapshot command is not available in the installed Repowise version, the matching file records the command failure and the script continues.

## Dashboard

After indexing, start the local dashboard from the Souz checkout:

```bash
cd "$SOUZ_REPO"
repowise serve
```

By default, Repowise serves the API on `http://localhost:7337` and the dashboard on `http://localhost:3000`.

## Updating

After Souz changes, refresh the index and snapshots:

```bash
export SOUZ_REPO=/path/to/souz
scripts/run-repowise-souz.sh
```

For a faster index-only refresh inside the Souz checkout:

```bash
cd "$SOUZ_REPO"
repowise update
```

## Upstream References

- Source repository: [repowise-dev/repowise](https://github.com/repowise-dev/repowise)
- Quickstart: [Repowise quickstart](https://github.com/repowise-dev/repowise/blob/main/docs/start/QUICKSTART.md)
- Dashboard: [Repowise dashboard docs](https://github.com/repowise-dev/repowise/blob/main/docs/start/DASHBOARD.md)
- Configuration: [Repowise configuration docs](https://github.com/repowise-dev/repowise/blob/main/docs/reference/CONFIG.md)
