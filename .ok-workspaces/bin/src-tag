#!/bin/sh
# Materialized by ok-workspaces v18.8.0 — suite-owned; overwritten on converge; do not hand-edit.

set -eu
root=$PWD
while :; do
    for marker in .ok-planner .ok-plumbline .ok-workspaces .plumbline.json .claude/rules/plumbline-cheatsheet.md; do
        if [ -e "$root/$marker" ]; then break 2; fi
    done
    parent=$(dirname "$root")
    if [ "$parent" = "$root" ]; then root=$PWD; break; fi
    root=$parent
done
cd "$root"
index=$(git rev-parse --git-path index)
prefix=$(git rev-parse --show-prefix)
tmp=$(mktemp "${TMPDIR:-/tmp}/ok-workspaces-src-tag.XXXXXX")
trap 'rm -f "$tmp"' EXIT
if [ -f "$index" ]; then cp "$index" "$tmp"; else rm -f "$tmp"; fi
git ls-files -z --cached --others --exclude-per-directory=.gitignore |
    GIT_INDEX_FILE="$tmp" git \
        -c core.excludesFile=/dev/null \
        -c core.attributesFile=/dev/null \
        -c core.autocrlf=false \
        update-index --add --remove -z --stdin
tree=$(GIT_INDEX_FILE="$tmp" git write-tree)
if [ -n "$prefix" ]; then
    tree=$(git rev-parse "$tree:${prefix%/}")
fi
printf 'src-%.12s\n' "$tree"
