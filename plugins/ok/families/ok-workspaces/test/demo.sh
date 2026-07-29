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
# worktrees-inside-project-root: the suite-owned cover that keeps an
# in-repo checkout out of repo content, asked of git itself rather than
# read out of a file — at the default dot-directory prefix, at a
# declared in-repo prefix outside the dot-directory (its own suite-owned
# gitignore, the project's root gitignore byte-identical throughout),
# and at a prefix resolving outside the repository, where converge
# records the location and writes no cover at all. Diagnose is run on
# each shape: it probes with `git check-ignore`, calls the missing cover
# drift, and reports an out-of-dot-directory prefix as declaration.
#
# declared-stack-profile: detection is run over sandbox repos carrying
# real stack markers and its proposal asserted (docker-compose,
# dev-server, and none runtimes); a declaration that disagrees with
# detection materializes from the declaration and is diagnosed as drift
# naming both sides; and converge refuses to materialize anything at all
# with no committed profile.
#
# converge-project-estate: a converged estate hand-edited in four
# suite-owned artifacts is diagnosed and then repaired to the byte the
# fresh converge wrote, with a third pass a no-op; and the retired
# payloads earlier versions materialized are diagnosed and removed.
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
# @story: converge-project-estate
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

# --- The default worktree location is covered, and only by the suite -------
# A checkout inside the repo must never become content of the repo. The
# two jobs above are real checkouts at the profile's default prefix, so
# the question is put to git itself rather than read out of a file — and
# `check-ignore -v` names which ignore file answered, which is the whole
# claim: the cover is the suite's own file inside its dot-directory, and
# the project's root .gitignore stays the human's.
# @decision: worktrees-inside-project-root
[ -d "${dir_prefix}job-a" ] \
    || fail "there is no real checkout at the default prefix — the coverage case proves nothing"
git check-ignore -q -- "${dir_prefix}job-a" \
    || fail "a checkout at the default prefix is not ignored — it would be offered as repo content"
git check-ignore -q -- "${dir_prefix}job-a/file.txt" \
    || fail "content inside a default-prefix checkout is not ignored"
default_cover=$(git check-ignore -v -- "${dir_prefix}job-a" | cut -f1)
case "$default_cover" in
    .ok-workspaces/.gitignore:*) : ;;
    *) fail "the default-prefix checkout is covered by '$default_cover', not the suite-owned .ok-workspaces/.gitignore" ;;
esac
[ -z "$(git status --porcelain -uall)" ] \
    || fail "git offers the default-prefix checkouts as repo content: $(git status --porcelain -uall)"
[ "$(cat .gitignore)" = ".env" ] \
    || fail "converge edited the project's root .gitignore — a human-owned file"

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

# A fresh sandbox repository the scan and the converge core can be run
# over for real; prints its path.
sandbox() {
    local dir="$tmp/$1"
    git init -q -b integration "$dir"
    printf '%s' "$dir"
}

# --- A declared in-repo prefix outside the dot-directory carries its own ---
# A .gitignore governs only its own directory, so the dot-directory's
# file cannot cover a prefix somewhere else in the repo. Converge writes
# a suite-owned .gitignore at the declared prefix instead — never the
# project's root .gitignore, which must come out of this byte-identical.
# @decision: worktrees-inside-project-root
elsewhere_repo=$(sandbox elsewhere-proj)
printf 'hello\n' > "$elsewhere_repo/file.txt"
printf 'node_modules/\n.env\n' > "$elsewhere_repo/.gitignore"
elsewhere_root_ignore=$(cat "$elsewhere_repo/.gitignore")
mkdir -p "$elsewhere_repo/.ok-workspaces"
cat > "$elsewhere_repo/.ok-workspaces/config.json" <<'JSON'
{
  "stacks": [],
  "runtime": "none",
  "worktrees": { "dirPrefix": "build/worktrees/", "branchPrefix": "wt/" },
  "srcTag": { "path": ".ok-workspaces/bin/src-tag" }
}
JSON
git -C "$elsewhere_repo" add -A
git -C "$elsewhere_repo" commit -q -m base
( cd "$elsewhere_repo" && node "$family/scripts/converge.js" >/dev/null )

[ -f "$elsewhere_repo/build/worktrees/.gitignore" ] \
    || fail "converge wrote no suite-owned .gitignore at the declared in-repo worktree prefix"
git -C "$elsewhere_repo" worktree add -q -b wt/job-x build/worktrees/job-x
git -C "$elsewhere_repo" check-ignore -q -- build/worktrees/job-x \
    || fail "a checkout at the declared in-repo prefix is not ignored — it would be offered as repo content"
elsewhere_cover=$(git -C "$elsewhere_repo" check-ignore -v -- build/worktrees/job-x | cut -f1)
case "$elsewhere_cover" in
    build/worktrees/.gitignore:*) : ;;
    *) fail "the declared-prefix checkout is covered by '$elsewhere_cover', not the suite-owned build/worktrees/.gitignore" ;;
esac
[ "$(cat "$elsewhere_repo/.gitignore")" = "$elsewhere_root_ignore" ] \
    || fail "converge edited the project's root .gitignore to cover an out-of-dot-directory prefix"

# The cover hides checkouts and nothing else: the materialized ignore
# file stays visible so the owner commits it like every other
# suite-owned artifact.
elsewhere_untracked=$(git -C "$elsewhere_repo" status --porcelain -uall)
printf '%s\n' "$elsewhere_untracked" | grep -q 'build/worktrees/job-x' \
    && fail "the checkout under the declared prefix is offered as repo content"
printf '%s\n' "$elsewhere_untracked" | grep -q 'build/worktrees/\.gitignore' \
    || fail "the suite-owned prefix .gitignore hides itself from the owner"

# Diagnose reads the same reality: it probes with git check-ignore, and
# it reports a prefix outside the family dot-directory as the owner's
# declaration rather than drift.
elsewhere_diag=$( cd "$elsewhere_repo" && node "$family/scripts/diagnose.js" ) \
    || fail "diagnose called a correctly covered out-of-dot-directory profile drifted: $elsewhere_diag"
printf '%s\n' "$elsewhere_diag" | grep -q '\[ok\] worktree-ign.*git check-ignore' \
    || fail "diagnose does not confirm the cover by asking git check-ignore"
printf '%s\n' "$elsewhere_diag" | grep -q '\[ok\] worktree-dir.*declaration, not drift' \
    || fail "diagnose does not report an out-of-dot-directory prefix as a declaration"

# Take the cover away and the probe must notice: it is a live git
# question, not a restatement of what converge wrote. Converge puts it
# back.
rm "$elsewhere_repo/build/worktrees/.gitignore"
uncovered=$( cd "$elsewhere_repo" && node "$family/scripts/diagnose.js" 2>&1 ) \
    && fail "diagnose called an uncovered in-repo worktree prefix clean"
printf '%s\n' "$uncovered" | grep -q 'DRIFT.*worktree-ign.*nothing ignores build/worktrees/' \
    || fail "diagnose does not report an uncovered in-repo worktree prefix as drift"
( cd "$elsewhere_repo" && node "$family/scripts/converge.js" >/dev/null )
git -C "$elsewhere_repo" check-ignore -q -- build/worktrees/job-x \
    || fail "converge did not restore the cover diagnose reported missing"

# --- A prefix outside the repository needs no cover, and gets none ---------
# Worktrees declared outside the repository cannot become its content, so
# converge records that in the dot-directory's ignore file, writes no
# ignore file at the prefix, and makes nothing in the repo ignored as a
# side effect.
# @decision: worktrees-inside-project-root
outside_repo=$(sandbox outside-proj)
outside_root=$( cd "$outside_repo" && pwd -P )
outside_prefix="$(dirname "$outside_root")/outside-worktrees/"
printf 'hello\n' > "$outside_repo/file.txt"
mkdir -p "$outside_repo/.ok-workspaces"
cat > "$outside_repo/.ok-workspaces/config.json" <<JSON
{
  "stacks": [],
  "runtime": "none",
  "worktrees": { "dirPrefix": "${outside_prefix}", "branchPrefix": "wt/" },
  "srcTag": { "path": ".ok-workspaces/bin/src-tag" }
}
JSON
( cd "$outside_repo" && node "$family/scripts/converge.js" >/dev/null )
git -C "$outside_repo" add -A
git -C "$outside_repo" commit -q -m base

grep -q 'outside this repository, so nothing here needs ignoring' "$outside_repo/.ok-workspaces/.gitignore" \
    || fail "converge did not record that the declared worktree location is outside the repository"
[ -z "$(grep -v '^#' "$outside_repo/.ok-workspaces/.gitignore" | grep -v '^$' || true)" ] \
    || fail "converge wrote an ignore pattern for worktrees that live outside the repository"
[ ! -e "${outside_prefix}.gitignore" ] \
    || fail "converge wrote a suite-owned .gitignore outside the repository"

git -C "$outside_repo" worktree add -q -b wt/job-x "${outside_prefix}job-x"
[ -f "${outside_prefix}job-x/file.txt" ] \
    || fail "the checkout outside the repository was not created — the case proves nothing"
[ -z "$(git -C "$outside_repo" status --porcelain -uall)" ] \
    || fail "a checkout outside the repository turned up as repo content: $(git -C "$outside_repo" status --porcelain -uall)"
git -C "$outside_repo" check-ignore -q -- file.txt \
    && fail "converge made a project source file ignored"
git -C "$outside_repo" check-ignore -q -- .ok-workspaces/worktrees/job-x \
    && fail "converge ignored the default worktree location for a profile that does not use it"

outside_diag=$( cd "$outside_repo" && node "$family/scripts/diagnose.js" ) \
    || fail "diagnose reported drift for worktrees declared outside the repository: $outside_diag"
printf '%s\n' "$outside_diag" | grep -q '\[ok\] worktree-ign.*outside the repository' \
    || fail "diagnose does not report an outside-the-repository prefix as needing no cover"
printf '%s\n' "$outside_diag" | grep -q '\[ok\] worktree-dir.*declaration, not drift' \
    || fail "diagnose does not report an outside-the-repository prefix as a declaration"

# In-repo is decided on the resolved location, not the spelling: a prefix
# that normalizes out of the root is outside the repository however it is
# written.
cat > "$outside_repo/.ok-workspaces/config.json" <<'JSON'
{
  "stacks": [],
  "runtime": "none",
  "worktrees": { "dirPrefix": "nested/../../escaped-worktrees/", "branchPrefix": "wt/" },
  "srcTag": { "path": ".ok-workspaces/bin/src-tag" }
}
JSON
( cd "$outside_repo" && node "$family/scripts/converge.js" >/dev/null )
grep -q 'outside this repository, so nothing here needs ignoring' "$outside_repo/.ok-workspaces/.gitignore" \
    || fail "a worktree prefix that normalizes out of the repository was treated as in-repo"
[ ! -e "$outside_repo/nested" ] \
    || fail "converge created an in-repo directory for a prefix that resolves outside the repository"

# --- Detection proposes; the committed profile decides ---------------------
# The scan is the only thing that reads repo signals, and it reads them
# from real repositories: each sandbox below carries one shape's real
# marker files and the scan is run over it for its proposal.
# @decision: declared-stack-profile
proposed() { ( cd "$1" && node "$family/scripts/detect.js" ); }
prop() { printf '%s' "$1" | python3 -c "import json,sys;d=json.load(sys.stdin);print($2)"; }

detect_compose=$(sandbox detect-go-compose)
printf 'module example.com/x\n' > "$detect_compose/go.mod"
printf 'services:\n  app:\n    image: busybox\n' > "$detect_compose/docker-compose.yml"
p=$(proposed "$detect_compose")
[ "$(prop "$p" "','.join(sorted(d['stacks']))")" = "docker,go" ] \
    || fail "detection did not propose go+docker from a go.mod beside a compose file: $(prop "$p" "d['stacks']")"
[ "$(prop "$p" "d['runtime']")" = "docker-compose" ] \
    || fail "detection did not propose the docker-compose runtime from a compose file"
[ "$(prop "$p" "d['compose']['projectPrefix']")" = "detect-go-compose" ] \
    || fail "detection did not propose the repository's own name as the compose project prefix"
[ "$(prop "$p" "','.join(d['compose']['files'])")" = "docker-compose.yml" ] \
    || fail "detection did not name the compose file it found"
[ "$(prop "$p" "'devServer' in d")" = "False" ] \
    || fail "detection proposed dev-server settings for a compose project"
[ "$(prop "$p" "d['worktrees']['dirPrefix']")" = ".ok-workspaces/worktrees/" ] \
    || fail "detection does not propose the in-project-root default worktree location"

detect_dev=$(sandbox detect-node-devserver)
printf '{ "name": "x", "scripts": { "dev": "vite" } }\n' > "$detect_dev/package.json"
p=$(proposed "$detect_dev")
[ "$(prop "$p" "','.join(d['stacks'])")" = "node" ] \
    || fail "detection did not propose the node stack from a package.json"
[ "$(prop "$p" "d['runtime']")" = "dev-server" ] \
    || fail "detection did not propose the dev-server runtime from a dev script"
[ "$(prop "$p" "d['devServer']['basePort']")" = "3000" ] \
    || fail "detection proposed an unexpected dev-server base port"
[ "$(prop "$p" "d['devServer']['portsPerWorkspace']")" = "10" ] \
    || fail "detection proposed an unexpected per-workspace port block size"
[ "$(prop "$p" "','.join(d['devServer']['portEnvVars'])")" = "PORT" ] \
    || fail "detection proposed unexpected dev-server port env vars"
[ "$(prop "$p" "'compose' in d")" = "False" ] \
    || fail "detection proposed a compose namespace for a dev-server project"

detect_quiet=$(sandbox detect-no-runtime)
printf '[package]\nname = "x"\n' > "$detect_quiet/Cargo.toml"
printf 'flask\n' > "$detect_quiet/requirements.txt"
p=$(proposed "$detect_quiet")
[ "$(prop "$p" "','.join(sorted(d['stacks']))")" = "python,rust" ] \
    || fail "detection did not propose rust+python from a Cargo.toml beside a python manifest"
[ "$(prop "$p" "d['runtime']")" = "none" ] \
    || fail "detection proposed a shared runtime for a project that declares none"
[ "$(prop "$p" "('compose' in d, 'devServer' in d)")" = "(False, False)" ] \
    || fail "detection proposed runtime settings for a project with no runtime"

# A Dockerfile is a container stack even with no compose file, and it
# outranks a dev script: the runtime is the outermost thing a workspace
# has to namespace.
detect_dockerfile=$(sandbox detect-dockerfile)
printf '{ "name": "x", "scripts": { "start": "node ." } }\n' > "$detect_dockerfile/package.json"
printf 'FROM busybox\n' > "$detect_dockerfile/Dockerfile"
p=$(proposed "$detect_dockerfile")
[ "$(prop "$p" "','.join(sorted(d['stacks']))")" = "docker,node" ] \
    || fail "detection did not propose the docker stack from a bare Dockerfile"
[ "$(prop "$p" "d['runtime']")" = "docker-compose" ] \
    || fail "a Dockerfile did not outrank a dev script in the proposed runtime"
[ "$(prop "$p" "','.join(d['compose']['files'])")" = "" ] \
    || fail "detection named compose files in a project that has none"

# --- A declaration that disagrees with detection is drift, not an override -
# The committed profile decides what gets materialized — converge never
# re-infers — and the disagreement with what the repo actually looks like
# is reported by diagnose, naming both sides, for the owner to reconcile.
# @decision: declared-stack-profile
disagreeing=$(sandbox declaration-vs-detection)
printf 'module example.com/x\n' > "$disagreeing/go.mod"
printf '{ "name": "x", "scripts": { "dev": "vite" } }\n' > "$disagreeing/package.json"
mkdir -p "$disagreeing/.ok-workspaces"
cat > "$disagreeing/.ok-workspaces/config.json" <<'JSON'
{
  "stacks": ["python"],
  "runtime": "none",
  "worktrees": { "dirPrefix": ".ok-workspaces/worktrees/", "branchPrefix": "wt/" },
  "srcTag": { "path": ".ok-workspaces/bin/src-tag" }
}
JSON
( cd "$disagreeing" && node "$family/scripts/converge.js" >/dev/null )
# Materialization followed the declaration: the declared "none" runtime
# gets no port allocator, though detection sees a dev server.
[ ! -e "$disagreeing/.ok-workspaces/bin/port-block" ] \
    || fail "converge materialized the detected runtime instead of the declared one"
grep -q 'runtime: none' "$disagreeing/.claude/rules/ok-workspaces-cheatsheet.md" \
    || fail "the materialized cheatsheet does not state the declared runtime"

disagreement=$( cd "$disagreeing" && node "$family/scripts/diagnose.js" 2>&1 ) \
    && fail "diagnose called a profile that disagrees with the repository clean"
disagreement_rc=0
( cd "$disagreeing" && node "$family/scripts/diagnose.js" >/dev/null 2>&1 ) || disagreement_rc=$?
[ "$disagreement_rc" = "2" ] \
    || fail "diagnose exited $disagreement_rc on a scan/declaration mismatch, not 2"
printf '%s\n' "$disagreement" | grep -q 'DRIFT.*stacks.*declared \[python\] but detected \[go,node\]' \
    || fail "diagnose does not name both sides of the stacks disagreement"
printf '%s\n' "$disagreement" | grep -q 'DRIFT.*runtime.*declared none but detected dev-server' \
    || fail "diagnose does not name both sides of the runtime disagreement"
printf '%s\n' "$disagreement" | grep -q 'Remedy:.*reconciling config.json' \
    || fail "diagnose does not put reconciling the declaration on the owner"

# --- With no declaration, converge refuses and materializes nothing --------
# Detection proposes, a human commits; the converge core never writes a
# profile for the owner, so with none there is nothing to materialize
# from.
# @decision: declared-stack-profile
undeclared=$(sandbox no-profile-proj)
printf 'hello\n' > "$undeclared/file.txt"
undeclared_rc=0
refusal=$( cd "$undeclared" && "$family/admin/converge" converge 2>&1 ) || undeclared_rc=$?
[ "$undeclared_rc" = "2" ] \
    || fail "the converge core exited $undeclared_rc with no committed profile, not 2"
printf '%s\n' "$refusal" | grep -q 'no committed profile at .ok-workspaces/config.json' \
    || fail "the refusal does not name the missing profile: $refusal"
printf '%s\n' "$refusal" | grep -q 'detect.js.*review the proposal, and commit it as config.json' \
    || fail "the refusal does not instruct the owner to declare a profile: $refusal"
[ ! -e "$undeclared/.claude" ] \
    || fail "converge materialized rules or skills with no committed profile"
[ ! -e "$undeclared/.ok-workspaces" ] \
    || fail "converge materialized an estate with no committed profile"

# --- A drifted estate is diagnosed, then repaired to the canonical bytes ---
# Suite-owned materialized files are whole files the family owns: a hand
# edit is drift, diagnose says so, and converge overwrites it back to
# exactly what a fresh converge writes. The manifest below is every
# materialized file's git blob hash, so "repaired" means byte-identical,
# not merely present.
# @story: converge-project-estate
estate_manifest() {
    ( cd "$1" && find .ok-workspaces .claude -type f ! -name config.json | sort | while read -r f; do
        printf '%s %s\n' "$(git hash-object -- "$f")" "$f"
    done )
}
repair_repo=$(sandbox repair-proj)
printf '{ "name": "x", "scripts": { "dev": "vite" } }\n' > "$repair_repo/package.json"
mkdir -p "$repair_repo/.ok-workspaces"
cat > "$repair_repo/.ok-workspaces/config.json" <<'JSON'
{
  "stacks": ["node"],
  "runtime": "dev-server",
  "worktrees": { "dirPrefix": ".ok-workspaces/worktrees/", "branchPrefix": "wt/" },
  "srcTag": { "path": ".ok-workspaces/bin/src-tag" },
  "devServer": { "basePort": 3000, "portsPerWorkspace": 10, "portEnvVars": ["PORT"] }
}
JSON
( cd "$repair_repo" && node "$family/scripts/converge.js" >/dev/null )
( cd "$repair_repo" && node "$family/scripts/diagnose.js" >/dev/null ) \
    || fail "a freshly converged estate does not diagnose clean"
converged_estate=$(estate_manifest "$repair_repo")
[ -n "$converged_estate" ] || fail "converge materialized no estate to drift"

# Four artifacts, four fidelity checks: two byte-compared scripts, the
# version-stamped cheatsheet, and a vendored skill.
printf '# hand edit\n' >> "$repair_repo/.ok-workspaces/bin/src-tag"
printf '# hand edit\n' >> "$repair_repo/.ok-workspaces/bin/port-block"
printf 'hand edit\n' >> "$repair_repo/.claude/skills/open/SKILL.md"
python3 - "$repair_repo" <<'PY'
import pathlib, re, sys
p = pathlib.Path(sys.argv[1], '.claude', 'rules', 'ok-workspaces-cheatsheet.md')
p.write_text(re.sub(r'Materialized by ok-workspaces v[0-9A-Za-z.\-]+',
                    'Materialized by ok-workspaces v0.0.1', p.read_text(), count=1))
PY
[ "$(estate_manifest "$repair_repo")" != "$converged_estate" ] \
    || fail "the hand edits did not change the estate — the repair case proves nothing"

drifted=$( cd "$repair_repo" && node "$family/scripts/diagnose.js" 2>&1 ) \
    && fail "diagnose called a hand-edited estate clean"
for expected in \
    'DRIFT.*src-tag.*diverges from canonical' \
    'DRIFT.*port-block.*diverges from canonical' \
    'DRIFT.*cheatsheet.*stamped v0.0.1' \
    'DRIFT.*vendored.*skills/open/SKILL.md diverges'; do
    printf '%s\n' "$drifted" | grep -q "$expected" \
        || fail "diagnose does not report the drifted artifact matching: $expected"
done

( cd "$repair_repo" && node "$family/scripts/converge.js" >/dev/null )
[ "$(estate_manifest "$repair_repo")" = "$converged_estate" ] \
    || fail "converge did not restore the drifted estate to the canonical bytes"
( cd "$repair_repo" && node "$family/scripts/diagnose.js" >/dev/null ) \
    || fail "diagnose still reports drift after converge repaired the estate"
# A third pass over an already-clean estate changes nothing.
( cd "$repair_repo" && node "$family/scripts/converge.js" >/dev/null )
[ "$(estate_manifest "$repair_repo")" = "$converged_estate" ] \
    || fail "a repeat converge over a clean estate changed it"

# --- Retired payloads are removed, not left behind ------------------------
# Earlier versions materialized a session-start hook, its skills-index
# context payload, and a merged lifecycle verb the front door replaced.
# They are suite-owned, so removal is converge's job rather than a
# consent question — and the now-empty directories go too.
# @story: converge-project-estate
mkdir -p "$repair_repo/.ok-workspaces/hooks" "$repair_repo/.ok-workspaces/context" \
    "$repair_repo/.claude/skills/true-up"
printf 'old hook\n' > "$repair_repo/.ok-workspaces/hooks/session-start"
printf 'old context payload\n' > "$repair_repo/.ok-workspaces/context/skills-index.md"
printf 'old verb\n' > "$repair_repo/.claude/skills/true-up/SKILL.md"
retired_diag=$( cd "$repair_repo" && node "$family/scripts/diagnose.js" 2>&1 ) \
    && fail "diagnose called an estate carrying retired payloads clean"
for expected in \
    'DRIFT.*retired.*hooks/session-start' \
    'DRIFT.*retired.*context/skills-index.md' \
    'DRIFT.*retired.*true-up'; do
    printf '%s\n' "$retired_diag" | grep -q "$expected" \
        || fail "diagnose does not report the retired payload matching: $expected"
done

removal=$( cd "$repair_repo" && node "$family/scripts/converge.js" )
printf '%s\n' "$removal" \
    | grep -q 'retired payloads removed: hooks/session-start, context/skills-index.md, \.claude/skills/true-up/' \
    || fail "converge does not report which retired payloads it removed: $removal"
[ ! -e "$repair_repo/.ok-workspaces/hooks" ] \
    || fail "the retired hook directory survived converge"
[ ! -e "$repair_repo/.ok-workspaces/context" ] \
    || fail "the retired context payload directory survived converge"
[ ! -e "$repair_repo/.claude/skills/true-up" ] \
    || fail "the retired lifecycle verb survived converge"
[ "$(estate_manifest "$repair_repo")" = "$converged_estate" ] \
    || fail "removing the retired payloads left the estate different from a fresh converge"
( cd "$repair_repo" && node "$family/scripts/diagnose.js" >/dev/null ) \
    || fail "diagnose still reports retired payloads after converge removed them"

echo "demo: two isolated workspaces opened disjoint (checkouts, branches, ports ${ports_a//$'\n'/,} vs ${ports_b//$'\n'/,}, compose ${compose_a} vs ${compose_b});"
echo "demo: every close gate held (dirty paths named, integration branch '${integration}' resolved from the remote); work survives in ${merge_commit}"
echo "demo: git itself confirms the worktree cover (default via ${default_cover%%:*}, declared in-repo prefix via ${elsewhere_cover%%:*}, outside-the-repo prefix uncovered by design);"
echo "demo: detection proposed docker-compose/dev-server/none runtimes, a disagreeing declaration diagnosed as drift, no declaration refused, and a hand-edited estate repaired to the canonical bytes"
