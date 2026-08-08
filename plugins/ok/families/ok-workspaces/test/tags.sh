#!/usr/bin/env bash
# Proof for content-addressed artifacts, run against the script converge
# actually materializes into a project (not the payload source).
#
# Exhibits the three things the story's Proof field names:
#   1. the same tree hashed on two checkouts produces the identical tag
#      — including when the two checkouts differ in per-machine and
#      per-clone git ignore configuration (core.excludesFile,
#      $GIT_DIR/info/exclude), which is not tree content;
#   2. one edited file produces a different tag (tracked edit and new
#      untracked file alike), with no commit anywhere;
#   3. a harness that resolves an artifact by tag fails loudly when the
#      tag is absent, rather than falling back to a mutable tag.
#
# Conjunct 3 is exhibited by a consumer-shaped harness built here in the
# fixture — the shape the materialized cheatsheet's rule 3 requires of
# consumer projects; whether a given project's real verification path
# obeys it is the audit ceremony's agentic sweep over this family's estate
# (see ceremony/audit.md, ## Sweep check 1), not something this harness can
# decide.
#
# @story: content-addressed-artifacts
set -uo pipefail

here="$(cd "$(dirname "$0")" && pwd)"
family="$(cd "$here/.." && pwd)"

fail=0
fails=0
ok()  { echo "ok: $1"; }
bad() { echo "FAIL: $1"; fail=1; fails=$((fails + 1)); }

section() { :; }  # readability marker; sections carry no machinery

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

section content-addressed-artifacts

export GIT_AUTHOR_NAME=proof GIT_AUTHOR_EMAIL=proof@example.invalid
export GIT_COMMITTER_NAME=proof GIT_COMMITTER_EMAIL=proof@example.invalid

# Two checkouts of the same tree, converged from the same profile.
make_checkout() {
    local dir=$1
    git init -q "$dir"
    mkdir -p "$dir/src" "$dir/.ok-workspaces"
    printf 'hello\n' > "$dir/src/app.txt"
    printf 'build noise\n' > "$dir/scratch.log"
    printf 'scratch.log\nartifacts/\n' > "$dir/.gitignore"
    cat > "$dir/.ok-workspaces/config.json" <<'JSON'
{
  "stacks": [],
  "runtime": "none",
  "worktrees": { "dirPrefix": ".ok-workspaces/worktrees/", "branchPrefix": "wt/" },
  "srcTag": { "path": ".ok-workspaces/bin/src-tag" }
}
JSON
    (cd "$dir" && node "$family/scripts/converge.js" >/dev/null && git add -A && git commit -qm base)
}

make_checkout "$tmp/one"
make_checkout "$tmp/two"

# The second checkout carries ignore configuration that is not tree
# content: a per-machine excludes file and a per-clone info/exclude. Both
# name UNTRACKED paths that no committed .gitignore mentions and that both
# checkouts carry identically — the only case that discriminates, since a
# derivation honouring per-machine ignore config would drop those paths
# from the second checkout's hash and only that one.
printf 'local note\n' > "$tmp/one/local-note.txt"
printf 'local note\n' > "$tmp/two/local-note.txt"
mkdir -p "$tmp/one/local-tmp" "$tmp/two/local-tmp"
printf 'per-clone state\n' > "$tmp/one/local-tmp/state.txt"
printf 'per-clone state\n' > "$tmp/two/local-tmp/state.txt"
printf 'local-note.txt\n' > "$tmp/machine-excludes"
git -C "$tmp/two" config core.excludesFile "$tmp/machine-excludes"
printf 'local-tmp/\n' > "$tmp/two/.git/info/exclude"

untracked_seen() { git -C "$1" status --porcelain --untracked-files=all | grep -q "$2"; }
if untracked_seen "$tmp/one" 'local-note.txt' && untracked_seen "$tmp/one" 'local-tmp/state.txt'; then
  ok "the first checkout offers both local paths as untracked content"
else
  bad "the first checkout does not see the local paths — the ignore-config case cannot discriminate"
fi
if untracked_seen "$tmp/two" 'local-note.txt' || untracked_seen "$tmp/two" 'local-tmp/state.txt'; then
  bad "the second checkout's per-machine and per-clone excludes are not in force — the ignore-config case cannot discriminate"
else
  ok "the second checkout's per-machine and per-clone excludes hide both local paths from git itself"
fi

# @decision: content-addressed-src-tag
tag() { (cd "$1" && ./.ok-workspaces/bin/src-tag); }

t1=$(tag "$tmp/one")
t2=$(tag "$tmp/two")
case "$t1" in
  src-????????????) ok "tag has the frozen shape: $t1" ;;
  *) bad "tag is not src- plus 12 hex: $t1" ;;
esac
[ "$t1" = "$t2" ] \
  && ok "identical trees produce the identical tag on both checkouts ($t1)" \
  || bad "identical trees produced different tags ($t1 vs $t2) — the derivation read something outside the tree"

# One edited file changes it — uncommitted, no commit required.
printf 'hello, world\n' > "$tmp/one/src/app.txt"
t1_edited=$(tag "$tmp/one")
[ "$t1_edited" != "$t1" ] \
  && ok "an uncommitted edit to a tracked file changes the tag ($t1_edited)" \
  || bad "an edited file did not change the tag"
[ -n "$(cd "$tmp/one" && git status --porcelain)" ] \
  && ok "the edit is still uncommitted — no commit was required to tag it" \
  || bad "the harness committed the edit"

printf 'new\n' > "$tmp/one/src/extra.txt"
t1_untracked=$(tag "$tmp/one")
[ "$t1_untracked" != "$t1_edited" ] \
  && ok "a new untracked file changes the tag ($t1_untracked)" \
  || bad "an untracked file did not change the tag"

# Ignored paths are outside the hash by construction — this is what keeps
# a job's worktree (which lives under an ignored prefix) from perturbing
# the tag of the tree it was cut from.
printf 'more noise\n' >> "$tmp/one/scratch.log"
[ "$(tag "$tmp/one")" = "$t1_untracked" ] \
  && ok "content the repo's own ignore rules exclude leaves the tag alone" \
  || bad "an ignored file perturbed the tag"

# The real index is never mutated by tagging.
before=$(cd "$tmp/one" && git status --porcelain | sort)
tag "$tmp/one" >/dev/null
after=$(cd "$tmp/one" && git status --porcelain | sort)
[ "$before" = "$after" ] \
  && ok "tagging leaves the real index and working tree untouched" \
  || bad "tagging mutated the repository state"

# --- A harness resolving by tag fails loudly on a missing artifact ---------
# The consumer-side shape the cheatsheet's rule 3 requires: resolve by
# src-tag, fail loudly when the artifact for that tag is absent — never
# fall back to a mutable tag that might be anything.
mkdir -p "$tmp/one/artifacts"
cat > "$tmp/one/harness" <<'SH'
#!/bin/sh
set -eu
tag=$(./.ok-workspaces/bin/src-tag)
artifact="artifacts/app-${tag}.tar"
if [ ! -f "$artifact" ]; then
    echo "harness: no artifact for ${tag} — build it; refusing to fall back to artifacts/app-latest.tar" >&2
    exit 3
fi
echo "harness: verified ${artifact}"
SH
chmod +x "$tmp/one/harness"
: > "$tmp/one/artifacts/app-latest.tar"

out=$( (cd "$tmp/one" && ./harness) 2>&1 ); rc=$?
if [ "$rc" -eq 3 ] && printf '%s' "$out" | grep -q 'refusing to fall back'; then
  ok "a harness lookup of a missing tag fails loudly instead of falling back to :latest"
else
  bad "the missing-tag lookup did not fail loudly (exit $rc): $out"
fi

: > "$tmp/one/artifacts/app-$(tag "$tmp/one").tar"
if (cd "$tmp/one" && ./harness >/dev/null 2>&1); then
  ok "the same harness resolves the artifact once it exists for this tag"
else
  bad "the harness failed on a present artifact"
fi

grep -q 'loudly when it is missing' "$tmp/one/.claude/rules/ok-workspaces-cheatsheet.md" \
  && ok "the materialized cheatsheet states the fail-loudly rule the harness follows" \
  || bad "the materialized cheatsheet does not state the fail-loudly rule"

exit $fail
