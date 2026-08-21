#!/usr/bin/env bash

# @story: fresh-artifacts-per-run
# @decision: per-run-artifact-tag
set -uo pipefail

here="$(cd "$(dirname "$0")" && pwd)"
family="$(cd "$here/.." && pwd)"

fail=0
fails=0
ok()  { echo "ok: $1"; }
bad() { echo "FAIL: $1"; fail=1; fails=$((fails + 1)); }

section() { :; }

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

section fresh-artifacts-per-run

export GIT_AUTHOR_NAME=proof GIT_AUTHOR_EMAIL=proof@example.invalid
export GIT_COMMITTER_NAME=proof GIT_COMMITTER_EMAIL=proof@example.invalid

proj="$tmp/proj"
git init -q "$proj"
mkdir -p "$proj/.ok-workspaces"
cat > "$proj/.ok-workspaces/config.json" <<'JSON'
{
  "stacks": [],
  "runtime": "none",
  "worktrees": { "dirPrefix": ".ok-workspaces/worktrees/", "branchPrefix": "wt/" },
  "runTag": { "path": ".ok-workspaces/bin/run-tag" }
}
JSON
( cd "$proj" && node "$family/scripts/converge.js" >/dev/null )

script="$proj/.ok-workspaces/bin/run-tag"
if [ -x "$script" ]; then
  ok "converge materialized an executable run-tag at the path the profile declares"
else
  bad "converge materialized no executable run-tag at .ok-workspaces/bin/run-tag"
fi

tag=$("$script")
if [[ $tag =~ ^run-[0-9a-f]{12}$ ]]; then
  ok "the tag is run- plus 12 lowercase hex: $tag"
else
  bad "the tag is not run- plus 12 lowercase hex: $tag"
fi

second=$("$script")
if [ "$second" != "$tag" ]; then
  ok "two invocations mint different tags ($tag then $second)"
else
  bad "two invocations minted the same tag ($tag) — the script is not per-run"
fi

minted=$(for _ in $(seq 1 64); do "$script"; done)
distinct=$(printf '%s\n' "$minted" | sort -u | wc -l | tr -d ' ')
if [ "$distinct" = "64" ]; then
  ok "64 invocations minted 64 distinct tags"
else
  bad "64 invocations minted only $distinct distinct tags"
fi

minimal="$tmp/posix-bin"
mkdir -p "$minimal"
missing=""
for util in od tr; do
  path=$(command -v "$util") || missing="$missing $util"
  [ -n "$path" ] && ln -s "$path" "$minimal/$util"
done
if [ -n "$missing" ]; then
  bad "the POSIX case cannot run — the machine has no$missing"
elif env -i PATH="$minimal" /bin/sh -c 'command -v git' >/dev/null 2>&1; then
  bad "git is still reachable on the stripped PATH — the no-dependency case cannot discriminate"
else
  ok "the stripped PATH holds od and tr and reaches neither git nor node"
  posix_tag=$(env -i PATH="$minimal" /bin/sh "$script")
  if [[ $posix_tag =~ ^run-[0-9a-f]{12}$ ]]; then
    ok "the script mints a tag under /bin/sh with only od and tr on PATH ($posix_tag)"
  else
    bad "the script did not mint a tag under /bin/sh with only od and tr on PATH: $posix_tag"
  fi
fi

mkdir -p "$proj/artifacts"
cat > "$proj/harness" <<'SH'
#!/bin/sh
set -eu
if [ -z "${RUN_TAG:-}" ]; then
    echo "harness: RUN_TAG is unset — the run mints one tag and hands it to its tests" >&2
    exit 3
fi
artifact="artifacts/app-${RUN_TAG}.tar"
if [ ! -f "$artifact" ]; then
    echo "harness: no artifact for ${RUN_TAG} — build it; refusing to fall back to artifacts/app-latest.tar" >&2
    exit 4
fi
echo "harness: verified ${artifact}"
SH
chmod +x "$proj/harness"
: > "$proj/artifacts/app-latest.tar"

out=$( cd "$proj" && ./harness 2>&1 ); rc=$?
if [ "$rc" -eq 3 ] && printf '%s' "$out" | grep -q 'RUN_TAG is unset'; then
  ok "the harness fails loudly when no run handed it a tag"
else
  bad "the harness did not fail loudly on an unset tag (exit $rc): $out"
fi

run_one=$("$script")
out=$( cd "$proj" && RUN_TAG="$run_one" ./harness 2>&1 ); rc=$?
if [ "$rc" -eq 4 ] && printf '%s' "$out" | grep -q 'refusing to fall back'; then
  ok "the harness fails loudly when no artifact carries the run's tag, and refuses the :latest artifact beside it"
else
  bad "the missing-artifact lookup did not fail loudly (exit $rc): $out"
fi

: > "$proj/artifacts/app-${run_one}.tar"
if ( cd "$proj" && RUN_TAG="$run_one" ./harness >/dev/null 2>&1 ); then
  ok "the same harness resolves the artifact the run built under the run's own tag"
else
  bad "the harness failed on the artifact its own run built"
fi

run_two=$("$script")
out=$( cd "$proj" && RUN_TAG="$run_two" ./harness 2>&1 ); rc=$?
if [ "$rc" -eq 4 ]; then
  ok "a later run cannot resolve the earlier run's artifact — staleness is unrepresentable"
else
  bad "a later run resolved an artifact built by an earlier run (exit $rc): $out"
fi

: > "$proj/artifacts/app-${run_two}.tar"
if ( cd "$proj" && RUN_TAG="$run_two" ./harness >/dev/null 2>&1 ) \
  && ( cd "$proj" && RUN_TAG="$run_one" ./harness >/dev/null 2>&1 ); then
  ok "two runs' artifacts coexist under their own tags — concurrent runs cannot collide"
else
  bad "two runs' artifacts do not coexist under their own tags"
fi

if grep -q 'fail loudly when the variable is' "$proj/.claude/rules/ok-workspaces-cheatsheet.md"; then
  ok "the materialized cheatsheet states the fail-loudly rule the harness follows"
else
  bad "the materialized cheatsheet does not state the fail-loudly rule"
fi

exit $fail
