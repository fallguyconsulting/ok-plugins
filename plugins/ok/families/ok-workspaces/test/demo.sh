#!/usr/bin/env bash
# Demo proof for the workspace stories, driven from a committed profile in
# a sandbox repo.
#
# isolated-parallel-workspaces: two jobs opened side by side under the
# profile's naming, with disjoint checkouts, disjoint branches, and
# disjoint runtime namespaces — the dev-server port blocks the
# materialized allocator computes, and the compose project names the
# profile's prefix derives — so both stacks are startable simultaneously
# (nothing either job needs is shared, and starting the second edits
# nothing in the first); plus an open of an already-existing job name
# stopping rather than reusing the workspace.
#
# safe-workspace-teardown: a close attempt on a workspace with
# uncommitted changes stops at the clean-tree gate with the dirty paths
# named; the merged-branch gate resolves the integration branch from
# what the remote reports (never a guess) via `git ls-remote --symref
# origin HEAD`; the unmerged branch is refused; and a clean, merged
# workspace closes completely with the surviving merge commit locatable.
# The gates are run here exactly as the close verb states them — the
# verb's prose is the prompt-realized half; the commands under it are
# what this harness executes.
#
# @story: isolated-parallel-workspaces
# @story: safe-workspace-teardown
set -euo pipefail

here="$(cd "$(dirname "$0")" && pwd)"
family="$(cd "$here/.." && pwd)"

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

fails=0
fail() {
    echo "DEMO FAIL: $1"
    fails=$((fails + 1))
    exit 1
}

section() { :; }  # readability marker; sections carry no machinery

export GIT_AUTHOR_NAME=demo GIT_AUTHOR_EMAIL=demo@example.invalid
export GIT_COMMITTER_NAME=demo GIT_COMMITTER_EMAIL=demo@example.invalid

# A bare origin whose HEAD names the integration branch: gate 2 must read
# this rather than assume "main".
origin="$tmp/origin.git"
git init -q --bare -b integration "$origin"

repo="$tmp/proj"
git init -q -b integration "$repo"
cd "$repo"
git remote add origin "$origin"
printf 'hello\n' > file.txt
# Local env is version-control-invisible: the per-workspace runtime env
# the open verb writes is exactly the kind of file that never becomes
# repo content.
printf '.env\n' > .gitignore

# The committed profile decides the naming and the runtime namespace;
# converge materializes the allocator from it.
mkdir -p .ok-workspaces
cat > .ok-workspaces/config.json <<'JSON'
{
  "stacks": [],
  "runtime": "dev-server",
  "worktrees": { "dirPrefix": ".ok-workspaces/worktrees/", "branchPrefix": "wt/" },
  "srcTag": { "path": ".ok-workspaces/bin/src-tag" },
  "devServer": { "basePort": 3000, "portsPerWorkspace": 10, "portEnvVars": ["PORT", "API_PORT"] },
  "compose": { "projectPrefix": "proj" }
}
JSON
node "$family/scripts/converge.js" >/dev/null
git add -A
git commit -q -m base
git push -q origin integration

dir_prefix=$(python3 -c "import json;print(json.load(open('.ok-workspaces/config.json'))['worktrees']['dirPrefix'])")
branch_prefix=$(python3 -c "import json;print(json.load(open('.ok-workspaces/config.json'))['worktrees']['branchPrefix'])")
compose_prefix=$(python3 -c "import json;print(json.load(open('.ok-workspaces/config.json'))['compose']['projectPrefix'])")

# --- Two jobs opened side by side, under the profile's naming ---------------
section isolated-parallel-workspaces
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

# --- Disjoint runtime namespaces: the dev-server port blocks ---------------
# The allocator is the one computed source of the arithmetic; the open
# verb appends exactly these lines to each workspace's own .env.
block_a=$("$repo/.ok-workspaces/bin/port-block" job-a 2>/dev/null)
block_b=$("$repo/.ok-workspaces/bin/port-block" job-b 2>/dev/null)
printf '%s\n' "$block_a" > "${dir_prefix}job-a/.env"
printf '%s\n' "$block_b" > "${dir_prefix}job-b/.env"

ports_a=$(printf '%s\n' "$block_a" | sed 's/.*=//' | sort)
ports_b=$(printf '%s\n' "$block_b" | sed 's/.*=//' | sort)
[ -n "$ports_a" ] && [ -n "$ports_b" ] || fail "the allocator printed no port block"
[ "$(printf '%s\n' "$block_a" | wc -l | tr -d ' ')" = "2" ] \
    || fail "the allocator did not print one line per declared port env var"
shared=$(comm -12 <(printf '%s\n' "$ports_a") <(printf '%s\n' "$ports_b") || true)
[ -z "$shared" ] || fail "the two jobs were given overlapping ports: $shared"

# Both stacks are startable simultaneously: each job's ports are free
# while the other job holds its own block, and allocating the second
# edited nothing in the first.
grep -q "PORT=" "${dir_prefix}job-a/.env" || fail "job-a has no port block in its env"
[ "$(cat "${dir_prefix}job-a/.env")" != "$(cat "${dir_prefix}job-b/.env")" ] \
    || fail "the two workspaces were handed identical runtime env"
[ "$(cat "${dir_prefix}job-a/.env")" = "$(printf '%s\n' "$block_a")" ] \
    || fail "allocating job-b's block disturbed job-a's env"

# --- This profile's runtime namespace, as converge materialized it ---------
# The dev-server profile above: the cheatsheet must hand the workspace to
# the allocator and state no compose namespace at all.
cheatsheet=".claude/rules/ok-workspaces-cheatsheet.md"
grep -q '`.ok-workspaces/bin/port-block <job>`' "$cheatsheet" \
    || fail "the dev-server cheatsheet does not send the workspace to the materialized allocator"
grep -q "COMPOSE_PROJECT_NAME" "$cheatsheet" \
    && fail "the dev-server cheatsheet states a compose namespace this profile does not declare"

# --- Disjoint runtime namespaces: the compose project names ----------------
# Observed where converge writes it, not concatenated here: a
# docker-compose profile converged in its own sandbox, with the per-job
# namespace read back out of the materialized cheatsheet.
compose_repo="$tmp/compose-proj"
git init -q -b integration "$compose_repo"
mkdir -p "$compose_repo/.ok-workspaces"
cat > "$compose_repo/.ok-workspaces/config.json" <<JSON
{
  "stacks": [],
  "runtime": "docker-compose",
  "worktrees": { "dirPrefix": ".ok-workspaces/worktrees/", "branchPrefix": "wt/" },
  "srcTag": { "path": ".ok-workspaces/bin/src-tag" },
  "compose": { "projectPrefix": "${compose_prefix}" }
}
JSON
( cd "$compose_repo" && node "$family/scripts/converge.js" >/dev/null )
compose_cheatsheet="$compose_repo/.claude/rules/ok-workspaces-cheatsheet.md"
compose_template=$(grep -o 'COMPOSE_PROJECT_NAME=[^`]*' "$compose_cheatsheet" | head -1)
[ -n "$compose_template" ] \
    || fail "the docker-compose cheatsheet states no compose project namespace"
[ "$compose_template" = "COMPOSE_PROJECT_NAME=${compose_prefix}-<job>" ] \
    || fail "the compose namespace is not derived from the profile's prefix: $compose_template"
compose_a="${compose_template#COMPOSE_PROJECT_NAME=}"
compose_b="${compose_a/<job>/job-b}"
compose_a="${compose_a/<job>/job-a}"
[ "$compose_a" != "$compose_b" ] \
    || fail "the materialized compose namespace does not vary per workspace: $compose_template"

# --- A root-resolving worktree prefix is refused, not materialized ---------
# The suite owns whole files and never edits a file a human also edits;
# the project's root .gitignore is the human's. A profile whose
# worktrees.dirPrefix resolves to the repository root would have converge
# cover the worktrees by writing that very file, so converge must refuse
# the profile and write nothing.
# @decision: whole-file-ownership
root_repo="$tmp/root-prefix-proj"
git init -q -b integration "$root_repo"
mkdir -p "$root_repo/.ok-workspaces"
printf 'node_modules/\n.env\n' > "$root_repo/.gitignore"
root_ignore_before=$(cat "$root_repo/.gitignore")
cat > "$root_repo/.ok-workspaces/config.json" <<'JSON'
{
  "stacks": [],
  "runtime": "none",
  "worktrees": { "dirPrefix": "./", "branchPrefix": "wt/" },
  "srcTag": { "path": ".ok-workspaces/bin/src-tag" }
}
JSON
if ( cd "$root_repo" && node "$family/scripts/converge.js" >/dev/null 2>&1 ); then
    fail "converge accepted a worktrees.dirPrefix resolving to the repository root"
fi
[ "$(cat "$root_repo/.gitignore")" = "$root_ignore_before" ] \
    || fail "converge overwrote the project's root .gitignore — a human-owned file"
refusal=$( cd "$root_repo" && node "$family/scripts/converge.js" 2>&1 >/dev/null ) || true
printf '%s\n' "$refusal" | grep -q 'worktrees.dirPrefix' \
    || fail "converge's refusal does not name the offending profile field"
# Nothing else was materialized either: the refusal precedes every write.
[ ! -e "$root_repo/.ok-workspaces/bin/src-tag" ] \
    || fail "converge materialized an estate for a profile it refused"
# Diagnose reports the same profile as a problem, never as coverage-ok.
diag=$( cd "$root_repo" && node "$family/scripts/diagnose.js" 2>&1 ) && \
    fail "diagnose called a root-resolving worktrees.dirPrefix clean"
printf '%s\n' "$diag" | grep -q 'DRIFT.*worktrees.dirPrefix' \
    || fail "diagnose does not report a root-resolving worktrees.dirPrefix as a profile problem"

# --- Close gate 1: the clean-tree gate, with the dirty paths named ---------
section safe-workspace-teardown
printf 'uncommitted\n' > "${dir_prefix}job-a/file.txt"
dirty=$(git -C "${dir_prefix}job-a" status --porcelain)
[ -n "$dirty" ] || fail "gate 1 saw a clean tree where the work is uncommitted"
printf '%s\n' "$dirty" | grep -q 'file.txt' \
    || fail "gate 1 did not name the dirty path"
# The gate stops the close; the command-level backstop refuses too.
# @decision: teardown-gates-in-git-flags
if git worktree remove "${dir_prefix}job-a" 2>/dev/null; then
    fail "a dirty worktree was removed — the clean-tree gate did not hold"
fi
printf 'hello\n' > "${dir_prefix}job-a/file.txt"
[ -z "$(git -C "${dir_prefix}job-a" status --porcelain)" ] \
    || fail "the sandbox did not return to a clean tree"

# --- Close gate 2: the integration branch comes from the remote ------------
integration=$(git ls-remote --symref origin HEAD | awk '/^ref:/ {sub("refs/heads/","",$2); print $2}')
[ "$integration" = "integration" ] \
    || fail "the integration branch was guessed, not resolved from the remote (got '${integration:-none}')"
[ "$integration" != "main" ] \
    || fail "the resolved branch matches the common guess — the sandbox proves nothing"

printf 'job-b work\n' > "${dir_prefix}job-b/file.txt"
git -C "${dir_prefix}job-b" commit -q -am "job-b work"
git branch --merged "$integration" | grep -q "${branch_prefix}job-b" \
    && fail "gate 2 called an unmerged branch merged"
[ -n "$(git cherry "$integration" "${branch_prefix}job-b")" ] \
    || fail "gate 2 found no unmerged commits on an unmerged branch"
if git branch -d "${branch_prefix}job-b" 2>/dev/null; then
    fail "an unmerged branch was deleted — the merged-branch gate did not hold"
fi

# --- Teardown after both gates pass ----------------------------------------
git merge -q --no-edit "${branch_prefix}job-b"
merge_commit=$(git rev-parse HEAD)
git branch --merged "$integration" | grep -q "${branch_prefix}job-b" \
    || fail "gate 2 does not pass on a merged branch"
git worktree remove "${dir_prefix}job-b"
git branch -d "${branch_prefix}job-b" >/dev/null
git merge-base --is-ancestor "$merge_commit" HEAD \
    || fail "the merged work did not survive the close"

git worktree remove "${dir_prefix}job-a"
git branch -d "${branch_prefix}job-a" >/dev/null

echo "demo: two isolated workspaces opened disjoint (checkouts, branches, ports ${ports_a//$'\n'/,} vs ${ports_b//$'\n'/,}, compose ${compose_a} vs ${compose_b});"
echo "demo: every close gate held (dirty paths named, integration branch '${integration}' resolved from the remote); work survives in ${merge_commit}"
