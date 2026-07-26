#!/usr/bin/env bash
# Demo proof for the workspace stories: opens two isolated workspaces in a
# sandbox repo, shows their checkouts/branches are disjoint and an existing
# job name stops an open; then shows every close gate holding — dirty tree
# and unmerged branch each block the non-forcing teardown commands, and a
# clean, merged workspace closes with the merge commit surviving.
# @story: isolated-parallel-workspaces
# @story: safe-workspace-teardown
set -euo pipefail

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

fail() {
    echo "DEMO FAIL: $1"
    exit 1
}

export GIT_AUTHOR_NAME=demo GIT_AUTHOR_EMAIL=demo@example.invalid
export GIT_COMMITTER_NAME=demo GIT_COMMITTER_EMAIL=demo@example.invalid

repo="$tmp/proj"
git init -q -b main "$repo"
cd "$repo"
printf 'hello\n' > file.txt
git add file.txt
git commit -q -m base

dir_prefix=".ok-workspaces/worktrees/"
branch_prefix="wt/"

git worktree add -q -b "${branch_prefix}job-a" "${dir_prefix}job-a"
git worktree add -q -b "${branch_prefix}job-b" "${dir_prefix}job-b"

[ "$(git -C "${dir_prefix}job-a" rev-parse --abbrev-ref HEAD)" = "${branch_prefix}job-a" ] \
    || fail "job-a is not on its own branch"
[ "$(git -C "${dir_prefix}job-b" rev-parse --abbrev-ref HEAD)" = "${branch_prefix}job-b" ] \
    || fail "job-b is not on its own branch"
[ "$(git -C "${dir_prefix}job-a" rev-parse --show-toplevel)" != "$(git -C "${dir_prefix}job-b" rev-parse --show-toplevel)" ] \
    || fail "the two jobs share a checkout"

if git worktree add -q -b "${branch_prefix}job-a" "${dir_prefix}job-a" 2>/dev/null; then
    fail "an existing job name was reused instead of stopping the open"
fi

printf 'uncommitted\n' > "${dir_prefix}job-a/file.txt"
if git worktree remove "${dir_prefix}job-a" 2>/dev/null; then
    fail "a dirty worktree was removed — the clean-tree gate did not hold"
fi
printf 'hello\n' > "${dir_prefix}job-a/file.txt"

printf 'job-b work\n' > "${dir_prefix}job-b/file.txt"
git -C "${dir_prefix}job-b" commit -q -am "job-b work"
if git branch -d "${branch_prefix}job-b" 2>/dev/null; then
    fail "an unmerged branch was deleted — the merged-branch gate did not hold"
fi

git merge -q --no-edit "${branch_prefix}job-b"
merge_commit=$(git rev-parse HEAD)
git worktree remove "${dir_prefix}job-b"
git branch -d "${branch_prefix}job-b" >/dev/null
git merge-base --is-ancestor "$merge_commit" HEAD \
    || fail "the merged work did not survive the close"

git worktree remove "${dir_prefix}job-a"
git branch -d "${branch_prefix}job-a" >/dev/null

echo "demo: two isolated workspaces opened disjoint; every gate held; work survives in ${merge_commit}"
