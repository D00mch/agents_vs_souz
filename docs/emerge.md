# Emerge Calculation Tool

This repository uses [glato/emerge](https://github.com/glato/emerge) as the source analysis tool for every checked-in report. Emerge scans a source tree, extracts code structure, calculates code and graph metrics, and exports both machine-readable files and an interactive HTML visualization.

The local run commands use the Docker image recommended by the upstream project:

```text
achtelik/emerge:2.0.0
```

The image is run with each target repository mounted read-only at `/work/source`, a project-specific output folder mounted at `/work/export`, and one YAML config mounted at `/work/config.yml`.

## How This Repo Uses Emerge

Each project has a matching config in `configs/`:

| Project | Config | Language | Output |
| --- | --- | --- | --- |
| Ouroboros | `configs/python.yml` | Python | `output/python/` |
| Hermes Agent | `configs/hermes.yml` | Python | `output/hermes/` |
| Souz | `configs/kotlin.yml` | Kotlin | `output/kotlin/` |
| PicoClaw | `configs/picoclaw.yml` | Go | `output/picoclaw/` |

All configs use a file-level scan. Entity-level scans are not enabled, which keeps the comparison consistent across Python, Kotlin, and Go.

The standard mount layout is:

```text
/work/source      target project source code, mounted read-only
/work/export      generated report output
/work/config.yml  Emerge YAML config for the current project
```

Because Emerge runs inside Docker, `source_directory` and `export.directory` in every YAML config use container paths, not host paths.

## Metrics Enabled

The configs enable the same metrics for all projects:

| Metric | Emerge config key | What it contributes |
| --- | --- | --- |
| Number of methods | `number_of_methods` | Counts functions or methods per scanned file and reports project averages. |
| Source lines of code | `source_lines_of_code` | Counts source lines per file and total source lines for the project. |
| Dependency graph | `dependency_graph` | Builds a graph of file-level dependencies. |
| Louvain modularity | `louvain_modularity` | Detects communities in the dependency graph and assigns files to clusters. |
| Fan-in / fan-out | `fan_in_out` | Counts incoming and outgoing dependency edges per file. |

These metrics drive the HTML graph visualization, the JSON output, GraphML files, and the text summary.

## Generated Files

Each `output/<project>/` folder contains:

| File or folder | Purpose |
| --- | --- |
| `html/emerge.html` | Interactive browser report for graph exploration. |
| `emerge-statistics-and-metrics.json` | Complete statistics, overall metrics, and per-file local metrics. |
| `emerge-statistics-metrics.txt` | Human-readable text version of statistics and metrics. |
| `emerge-file_result_dependency_graph.graphml` | Dependency graph with file-level metric attributes. |
| `emerge-filesystem_graph.graphml` | Filesystem hierarchy graph. |

The README links directly to the generated HTML reports for quick inspection.

## Regenerating Reports

Set the relevant environment variable to the source checkout path, then run the matching Docker command from the README:

```bash
export SOUZ_REPO=/path/to/souz
docker run --rm \
  --platform linux/amd64 \
  --user "$(id -u):$(id -g)" \
  -e HOME=/tmp \
  -v "$SOUZ_REPO:/work/source:ro" \
  -v "$PWD/output/kotlin:/work/export" \
  -v "$PWD/configs/kotlin.yml:/work/config.yml:ro" \
  achtelik/emerge:2.0.0 \
  /work/config.yml
```

The same pattern applies to `OUROBOROS_REPO`, `HERMES_AGENT_REPO`, and `PICOCLAW_REPO`.

## Upstream References

- Source repository: [glato/emerge](https://github.com/glato/emerge)
- Upstream Docker usage: [Emerge README](https://github.com/glato/emerge#how-to-use-emerge-as-docker-container)
- Upstream configuration reference: [Emerge README](https://github.com/glato/emerge#analysis-level)
- Upstream metric and export reference: [Emerge README](https://github.com/glato/emerge#file_scan-metrics)
