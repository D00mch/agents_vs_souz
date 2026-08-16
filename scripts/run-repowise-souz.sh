#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUT="$ROOT/output/souz/repowise"

if ! command -v repowise >/dev/null 2>&1; then
  echo "repowise is not installed. Install it with: pip install repowise" >&2
  exit 127
fi

if [[ -z "${SOUZ_REPO:-}" ]]; then
  echo "SOUZ_REPO is not set. Example: export SOUZ_REPO=/path/to/souz" >&2
  exit 2
fi

if [[ ! -d "$SOUZ_REPO/.git" ]]; then
  echo "SOUZ_REPO must point to a Git checkout: $SOUZ_REPO" >&2
  exit 2
fi

mkdir -p "$OUT"

capture() {
  local file="$1"
  shift

  {
    printf '$'
    printf ' %q' "$@"
    printf '\n\n'
  } >"$OUT/$file"

  if "$@" >>"$OUT/$file" 2>&1; then
    printf 'wrote %s\n' "$OUT/$file"
  else
    local status=$?
    printf '\ncommand exited with status %s\n' "$status" >>"$OUT/$file"
    printf 'captured failed command in %s\n' "$OUT/$file" >&2
  fi
}

run_required() {
  local file="$1"
  shift

  {
    printf '$'
    printf ' %q' "$@"
    printf '\n\n'
  } >"$OUT/$file"

  if "$@" >>"$OUT/$file" 2>&1; then
    printf 'wrote %s\n' "$OUT/$file"
    return
  fi

  local status=$?
  printf '\ncommand exited with status %s\n' "$status" >>"$OUT/$file"
  cat "$OUT/$file" >&2
  exit "$status"
}

capture_structurizr() {
  local log="$OUT/structurizr.txt"

  {
    printf '$ repowise export --format structurizr --output %q --force\n\n' "$OUT/structurizr.dsl"
  } >"$log"

  if repowise export --format structurizr --output "$OUT/structurizr.dsl" --force >>"$log" 2>&1; then
    printf 'wrote %s\n' "$OUT/structurizr.dsl"
    printf 'wrote %s\n' "$log"
  else
    local status=$?
    printf '\ncommand exited with status %s\n' "$status" >>"$log"
    printf 'captured failed command in %s\n' "$log" >&2
  fi
}

cd "$SOUZ_REPO"

capture version.txt repowise --version
run_required init.txt repowise init --yes --no-prose --no-editor-setup

capture doctor.txt repowise doctor
capture health.txt repowise health
capture dead-code.txt repowise dead-code
capture decisions.txt repowise decision list
capture_structurizr

if git rev-parse --verify HEAD~5 >/dev/null 2>&1; then
  capture recent-risk.txt repowise risk HEAD~5..HEAD
else
  {
    printf 'Skipped recent risk report.\n'
    printf 'Reason: this checkout does not have HEAD~5.\n'
  } >"$OUT/recent-risk.txt"
fi

git status --short >"$OUT/target-git-status.txt"

printf '\nRepowise Souz snapshots are in %s\n' "$OUT"
printf 'Repowise index is in %s/.repowise\n' "$SOUZ_REPO"
