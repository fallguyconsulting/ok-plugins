#!/usr/bin/env bash
# Test harness for surface-reconcile, the public-surface partition
# reconciler. The tool's contract is its exit codes — 0 settled, 2
# unclaimed-or-unratified, 1 error — and this drives each against a
# fixture built here, the same shape run.sh uses for audit-check.
#
# What is deliberately unexercised: whether a classification is *right*.
# Applying the guidance prose is the audit run's judgment; the tool only
# reconciles the recorded partition against what the committed member
# lists carry — the lists themselves are the agentic extraction's to
# maintain at the audit run's opening, and no enumerator commands exist.
#
# The tool itself is a payload vendored verbatim into consumer projects,
# so it carries no annotations of its own — this harness is repo-local,
# so it is where the corpus navigation lives.
#
# @story: rule-the-public-surface
# @decision: owner-guided-surface-partition
# @concept: surface-ruling
# @concept: surface-declaration
set -uo pipefail

here="$(cd "$(dirname "$0")" && pwd)"
reconcile="$here/../scripts/surface-reconcile"
fail=0

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

ok()  { echo "ok: $1"; }
bad() { echo "FAIL: $1"; fail=1; }

guidance_hash() {
  python3 - "$1" <<'PY'
import hashlib, sys
content = open(sys.argv[1], "rb").read()
print(hashlib.sha1(b"blob %d\0" % len(content) + content).hexdigest())
PY
}

# fixture <name> — a project with a declaration (three cli verbs, one
# expected-empty kind), committed member lists, and guidance, no ruling
# yet.
fixture() {
  local d="$tmp/$1"
  rm -rf "$d"
  mkdir -p "$d/.ok-planner/surface/members"
  printf '{"kinds":[{"kind":"cli-verbs","reads":"the CLI entry points"},{"kind":"empty-kind","reads":"a source with no members","expectedEmpty":true}]}\n' \
    > "$d/.ok-planner/surface/surface.json"
  printf 'alpha\nbeta\ngamma\n' > "$d/.ok-planner/surface/members/cli-verbs"
  : > "$d/.ok-planner/surface/members/empty-kind"
  printf 'All CLI verbs are public except gamma.\n' \
    > "$d/.ok-planner/surface/guidance.md"
  printf '%s' "$d"
}

# ruling <project> — a settled ruling matching the fixture's member
# lists and the guidance file as it stands.
ruling() {
  local d=$1 gh
  gh=$(guidance_hash "$d/.ok-planner/surface/guidance.md")
  mkdir -p "$d/.ok-planner/audits/surface"
  printf '{"commit":"abc1234","guidanceHash":"%s","kinds":[{"kind":"cli-verbs","public":["alpha","beta"],"private":["gamma"]},{"kind":"empty-kind","public":[],"private":[]}]}\n' \
    "$gh" > "$d/.ok-planner/audits/surface/ruling.json"
}

run_case() {  # run_case <name> <project> <expected-exit> <expected-substring>
  local name=$1 dir=$2 expected_exit=$3 expected_substr=$4
  local output actual_exit
  output=$(python3 "$reconcile" "$dir" 2>&1)
  actual_exit=$?
  if [ "$actual_exit" -ne "$expected_exit" ]; then
    echo "FAIL: $name — expected exit $expected_exit, got $actual_exit"
    sed 's/^/    /' <<<"$output"
    fail=1
  elif [ -n "$expected_substr" ] && ! grep -qF -- "$expected_substr" <<<"$output"; then
    echo "FAIL: $name — expected output to contain '$expected_substr'"
    sed 's/^/    /' <<<"$output"
    fail=1
  else
    echo "ok: $name"
  fi
}

# --- no ruling yet: every listed element is unclaimed, loudly ---------------
d=$(fixture first-run)
run_case "no ruling: every element unclaimed, exit 2" "$d" 2 "UNCLAIMED"
[ -f "$d/.ok-planner/audits/surface/extraction.json" ] \
  && ok "the fresh extraction is written beside where the ruling will live" \
  || bad "no extraction written on the first run"

# --- a settled partition passes silently ------------------------------------
d=$(fixture settled); ruling "$d"
run_case "a settled partition with ratified guidance: exit 0" "$d" 0 "settled"

# --- the retired declaration fields are rejected, naming the schema ---------
d=$(fixture legacy-enumerate)
printf '{"kinds":[{"kind":"cli-verbs","reads":"the CLI entry points","enumerate":"printf x"}]}\n' \
  > "$d/.ok-planner/surface/surface.json"
run_case "a legacy enumerate field: exit 1" "$d" 1 "retired \`enumerate\` field"

d=$(fixture legacy-derivation)
printf '{"kinds":[{"kind":"cli-verbs","reads":"the CLI entry points","derivation":"agentic"}]}\n' \
  > "$d/.ok-planner/surface/surface.json"
run_case "a legacy derivation marker: exit 1" "$d" 1 "retired \`derivation\` field"

# --- every kind names what its derivation reads ------------------------------
d=$(fixture no-reads)
printf '{"kinds":[{"kind":"cli-verbs"}]}\n' \
  > "$d/.ok-planner/surface/surface.json"
run_case "a kind without reads: exit 1" "$d" 1 "no one-line"

# --- an unratified guidance change is detected by anchors, not state --------
d=$(fixture unratified); ruling "$d"
printf 'A rule the ruling never applied.\n' >> "$d/.ok-planner/surface/guidance.md"
run_case "guidance changed since the ruling: exit 2" "$d" 2 "UNRATIFIED"

# --- a new listed member nothing rules is unclaimed, never private-by-omission
d=$(fixture new-element); ruling "$d"
printf 'delta\n' >> "$d/.ok-planner/surface/members/cli-verbs"
run_case "a newly listed member: UNCLAIMED, exit 2" "$d" 2 "cli-verbs/delta: UNCLAIMED"

# --- a ruled element the member list no longer carries is stale -------------
d=$(fixture stale-element); ruling "$d"
printf 'alpha\nbeta\n' > "$d/.ok-planner/surface/members/cli-verbs"
run_case "a ruled member no longer listed: STALE, exit 2" "$d" 2 "STALE"

# --- the error contract: loud, never silent ---------------------------------
d=$(fixture missing-list)
rm "$d/.ok-planner/surface/members/cli-verbs"
run_case "a kind with no committed member list: exit 1" "$d" 1 "no committed member list"

d=$(fixture list-empty)
: > "$d/.ok-planner/surface/members/cli-verbs"
run_case "an empty list without expectedEmpty: exit 1" "$d" 1 "expectedEmpty"

d=$(fixture no-declaration)
rm "$d/.ok-planner/surface/surface.json"
run_case "no declaration: exit 1" "$d" 1 "no surface declaration"

d=$(fixture no-guidance)
rm "$d/.ok-planner/surface/guidance.md"
run_case "no guidance: exit 1" "$d" 1 "no surface guidance"

if [ "$fail" -eq 0 ]; then
  echo "---"
  echo "all surface-reconcile tests passed"
fi
exit $fail
