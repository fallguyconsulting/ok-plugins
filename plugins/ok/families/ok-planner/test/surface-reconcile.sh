#!/usr/bin/env bash
# Test harness for surface-reconcile, the public-surface partition
# reconciler. The tool's contract is its exit codes — 0 settled, 2
# unclaimed-or-unratified, 1 error — and this drives each against a
# fixture built here, the same shape run.sh uses for audit-check.
#
# What is deliberately unexercised: whether a classification is *right*.
# Applying the guidance prose is the audit run's judgment; the tool only
# reconciles the recorded partition against what the enumerators
# produce.
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
# expected-empty kind) and guidance, no ruling yet.
fixture() {
  local d="$tmp/$1"
  rm -rf "$d"
  mkdir -p "$d/.ok-planner/surface"
  printf '{"kinds":[{"kind":"cli-verbs","enumerate":"printf %s"},{"kind":"empty-kind","enumerate":"true","expectedEmpty":true}]}\n' \
    "'alpha\\nbeta\\ngamma\\n'" > "$d/.ok-planner/surface/surface.json"
  printf 'All CLI verbs are public except gamma.\n' \
    > "$d/.ok-planner/surface/guidance.md"
  printf '%s' "$d"
}

# ruling <project> — a settled ruling matching the fixture's enumerators
# and the guidance file as it stands.
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

# --- no ruling yet: every enumerated element is unclaimed, loudly -----------
d=$(fixture first-run)
run_case "no ruling: every element unclaimed, exit 2" "$d" 2 "UNCLAIMED"
[ -f "$d/.ok-planner/audits/surface/extraction.json" ] \
  && ok "the fresh extraction is written beside where the ruling will live" \
  || bad "no extraction written on the first run"

# --- a settled partition passes silently ------------------------------------
d=$(fixture settled); ruling "$d"
run_case "a settled partition with ratified guidance: exit 0" "$d" 0 "settled"
run_case "no marked kinds: the inventory line still prints" "$d" 0 \
  "agentic kinds: 0 of 2"

# --- an agentic kind: the committed member list is its mechanical face -------
agentic_fixture() {
  local d="$tmp/$1" gh
  rm -rf "$d"
  mkdir -p "$d/.ok-planner/surface/members" "$d/.ok-planner/audits/surface"
  printf '{"kinds":[{"kind":"cli-verbs","enumerate":"printf %s"},{"kind":"config-keys","enumerate":"cat .ok-planner/surface/members/config-keys","derivation":"agentic","reads":"the config parser"}]}\n' \
    "'alpha\\nbeta\\ngamma\\n'" > "$d/.ok-planner/surface/surface.json"
  printf 'All CLI verbs are public except gamma; config keys as ruled.\n' \
    > "$d/.ok-planner/surface/guidance.md"
  printf 'alpha-key\nbeta-key\n' \
    > "$d/.ok-planner/surface/members/config-keys"
  gh=$(guidance_hash "$d/.ok-planner/surface/guidance.md")
  printf '{"commit":"abc1234","guidanceHash":"%s","kinds":[{"kind":"cli-verbs","public":["alpha","beta"],"private":["gamma"]},{"kind":"config-keys","public":["alpha-key"],"private":["beta-key"]}]}\n' \
    "$gh" > "$d/.ok-planner/audits/surface/ruling.json"
  printf '%s' "$d"
}

d=$(agentic_fixture agentic-settled)
run_case "a marked kind reading its members file: settled, exit 0" "$d" 0 \
  "settled"
run_case "the agentic inventory prints on a settled run" "$d" 0 \
  "agentic kinds: 1 of 2 — config-keys (reads the config parser)"

# --- the marked/`reads` pairing is validated both ways -----------------------
d=$(fixture agentic-no-reads)
printf '{"kinds":[{"kind":"config-keys","enumerate":"printf x","derivation":"agentic"}]}\n' \
  > "$d/.ok-planner/surface/surface.json"
run_case "marked agentic without reads: exit 1" "$d" 1 "no one-line"

d=$(fixture reads-unmarked)
printf '{"kinds":[{"kind":"config-keys","enumerate":"printf x","reads":"the config parser"}]}\n' \
  > "$d/.ok-planner/surface/surface.json"
run_case "reads without the agentic mark: exit 1" "$d" 1 "not marked"

# --- an unratified guidance change is detected by anchors, not state --------
d=$(fixture unratified); ruling "$d"
printf 'A rule the ruling never applied.\n' >> "$d/.ok-planner/surface/guidance.md"
run_case "guidance changed since the ruling: exit 2" "$d" 2 "UNRATIFIED"

# --- a new element nothing rules is unclaimed, never private-by-omission ----
d=$(fixture new-element); ruling "$d"
printf '{"kinds":[{"kind":"cli-verbs","enumerate":"printf %s"},{"kind":"empty-kind","enumerate":"true","expectedEmpty":true}]}\n' \
  "'alpha\\nbeta\\ngamma\\ndelta\\n'" > "$d/.ok-planner/surface/surface.json"
run_case "a newly enumerated element: UNCLAIMED, exit 2" "$d" 2 "cli-verbs/delta: UNCLAIMED"

# --- a ruled element no enumerator produces any more is stale ---------------
d=$(fixture stale-element); ruling "$d"
printf '{"kinds":[{"kind":"cli-verbs","enumerate":"printf %s"},{"kind":"empty-kind","enumerate":"true","expectedEmpty":true}]}\n' \
  "'alpha\\nbeta\\n'" > "$d/.ok-planner/surface/surface.json"
run_case "a ruled element no longer enumerated: STALE, exit 2" "$d" 2 "STALE"

# --- the error contract: loud, never silent ---------------------------------
d=$(fixture enum-error)
printf '{"kinds":[{"kind":"cli-verbs","enumerate":"exit 3"}]}\n' \
  > "$d/.ok-planner/surface/surface.json"
run_case "an enumerator that errors: exit 1" "$d" 1 "exited 3"

d=$(fixture enum-empty)
printf '{"kinds":[{"kind":"cli-verbs","enumerate":"true"}]}\n' \
  > "$d/.ok-planner/surface/surface.json"
run_case "zero members without expectedEmpty: exit 1" "$d" 1 "expectedEmpty"

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
