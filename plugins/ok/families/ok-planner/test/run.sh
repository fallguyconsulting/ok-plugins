#!/usr/bin/env bash
# Test harness for audit-check, the audit-corpus shape-and-invariant
# validator. The checker has four jobs — coverage, shape, brevity, and
# accountability — and this drives each against a fixture built here
# rather than committed: an audit is nine lines, so a fixture the reader
# can see inside the case that uses it beats one they have to go find.
#
# What is deliberately unexercised: whether a determination is *true*.
# That is the periodic audit run's judgment, made by agents reading the
# code, and no program can stand in for it.
set -uo pipefail

here="$(cd "$(dirname "$0")" && pwd)"
audit_check="$here/../scripts/audit-check"
fail=0

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

# fixture <name> — a project with one story and one decision, no audits.
fixture() {
  local d="$tmp/$1"
  rm -rf "$d"
  mkdir -p "$d/.ok-planner/design/stories" "$d/.ok-planner/design/decisions" \
           "$d/.ok-planner/audits/stories" "$d/.ok-planner/audits/decisions" \
           "$d/.ok-planner/issues"
  printf -- '---\nstory: see-data\n---\n\n# See the data\n\n## Story\n\nAs a reader, I want to see the data, so that I can act on it.\n' \
    > "$d/.ok-planner/design/stories/see-data.md"
  printf -- '---\ndecision: loopback-ports\n---\n\n# Ports bind loopback\n\n## Choice\n\nThe port binds the loopback interface.\n' \
    > "$d/.ok-planner/design/decisions/loopback-ports.md"
  printf '%s' "$d"
}

# audit <project> <bucket> <slug> <determination> [issue] — the canonical
# shape: frontmatter, a heading, one paragraph.
audit() {
  local d=$1 bucket=$2 slug=$3 det=$4 issue=${5:-} kind=decision
  [ "$bucket" = stories ] && kind=story
  {
    echo "---"
    echo "audit: $slug"
    echo "artifact: $kind:$slug"
    echo "determination: $det"
    echo "commit: abc1234"
    echo "audited: 2026-07-30T00:00:00Z"
    [ -n "$issue" ] && echo "issue: $issue"
    echo "---"
    echo
    echo "# Whether the project supports it"
    echo
    echo "$det. Checked all 3 call sites the interface's implementors name."
  } > "$d/.ok-planner/audits/$bucket/$slug.md"
}

both_audited() {  # both_audited <project> [determination] [issue]
  audit "$1" stories see-data "${2:-supported}" "${3:-}"
  audit "$1" decisions loopback-ports "${2:-supported}" "${3:-}"
}

file_issue() {  # file_issue <project> <slug> [dir]
  local d=$1 slug=$2 sub=${3:-issues}
  mkdir -p "$d/.ok-planner/$sub"
  printf -- '---\nissue: %s\n---\n\n# A gap\n' "$slug" \
    > "$d/.ok-planner/$sub/$slug.md"
}

run_case() {  # run_case <name> <project> <expected-exit> <expected-substring>
  local name=$1 dir=$2 expected_exit=$3 expected_substr=$4
  local output actual_exit
  output=$(python3 "$audit_check" "$dir" 2>&1)
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

# --- coverage: one audit per live artifact, and no orphans ------------------
d=$(fixture clean); both_audited "$d"
run_case "clean corpus" "$d" 0 ""

d=$(fixture missing); audit "$d" stories see-data supported
run_case "a live artifact with no audit" "$d" 2 "audit-missing"

d=$(fixture orphaned); both_audited "$d"
audit "$d" decisions retired-thing supported
run_case "an audit whose artifact is gone" "$d" 2 "audit-orphaned"

# --- accountability: a non-supported determination names its issue ----------
d=$(fixture unlinked); both_audited "$d" unsupported
run_case "unsupported without an issue" "$d" 2 "audit-unlinked"

d=$(fixture unclear-unlinked); both_audited "$d" unclear
run_case "unclear without an issue" "$d" 2 "audit-unlinked"

d=$(fixture dangling); both_audited "$d" unsupported 2026-07-30-000000-gap
run_case "an issue slug resolving to no file" "$d" 2 "resolves to no file"

d=$(fixture linked); both_audited "$d" unsupported 2026-07-30-000000-gap
file_issue "$d" 2026-07-30-000000-gap
run_case "unsupported with a real issue" "$d" 0 ""

d=$(fixture linked-history); both_audited "$d" unclear 2026-07-30-000000-gap
file_issue "$d" 2026-07-30-000000-gap history/issues
run_case "an archived issue still counts as held" "$d" 0 ""

d=$(fixture supported-linked); both_audited "$d" supported 2026-07-30-000000-gap
file_issue "$d" 2026-07-30-000000-gap
run_case "supported carrying an issue link" "$d" 2 "carries issue:"

# --- shape: frontmatter, slug, kind, determination vocabulary ---------------
d=$(fixture no-frontmatter); both_audited "$d"
printf '# just prose\n' > "$d/.ok-planner/audits/stories/see-data.md"
run_case "no frontmatter block" "$d" 2 "no closed YAML frontmatter"

d=$(fixture no-commit); both_audited "$d"
a="$d/.ok-planner/audits/stories/see-data.md"
grep -v '^commit:' "$a" > "$d/t" && mv "$d/t" "$a"
run_case "frontmatter without the commit it describes" "$d" 2 "lacks commit:"

d=$(fixture bad-determination); both_audited "$d"
a="$d/.ok-planner/audits/stories/see-data.md"
sed 's/^determination: supported/determination: satisfied/' "$a" > "$d/t" && mv "$d/t" "$a"
run_case "a determination outside the three words" "$d" 2 "is not one of"

d=$(fixture wrong-kind); both_audited "$d"
a="$d/.ok-planner/audits/stories/see-data.md"
sed 's/^artifact: story:see-data/artifact: decision:see-data/' "$a" > "$d/t" && mv "$d/t" "$a"
run_case "an artifact kind disagreeing with its bucket" "$d" 2 "must be 'story:see-data'"

d=$(fixture wrong-slug); both_audited "$d"
a="$d/.ok-planner/audits/stories/see-data.md"
sed 's/^audit: see-data/audit: something-else/' "$a" > "$d/t" && mv "$d/t" "$a"
run_case "an audit slug disagreeing with its filename" "$d" 2 "does not match the filename"

# --- brevity: one paragraph, and only a Referrals section beside it ---------
d=$(fixture verbose); both_audited "$d"
printf '\nA second paragraph, which is one more than an audit gets.\n' \
  >> "$d/.ok-planner/audits/stories/see-data.md"
run_case "a second paragraph" "$d" 2 "audit-verbose"

d=$(fixture extra-section); both_audited "$d"
printf '\n## Citations\n\n- cite: src/app.py :: "def go():"\n' \
  >> "$d/.ok-planner/audits/stories/see-data.md"
run_case "a citations section, which no longer exists" "$d" 2 "unexpected section"

d=$(fixture empty-body); both_audited "$d"
python3 - "$d/.ok-planner/audits/stories/see-data.md" <<'PY'
import sys
p = sys.argv[1]
head = open(p).read().split("# Whether")[0]
open(p, "w").write(head + "# Whether the project supports it\n")
PY
run_case "no determination paragraph at all" "$d" 2 "no determination paragraph"

# --- referrals: the fixed three-field grammar -------------------------------
d=$(fixture referral-ok); both_audited "$d"
cat >> "$d/.ok-planner/audits/stories/see-data.md" <<'MD'

## Referrals

- referral: whether the rendered table reads clearly
  established: the table is generated from the committed column set
  discipline: ux
MD
run_case "a well-formed referral" "$d" 0 ""

d=$(fixture referral-short); both_audited "$d"
cat >> "$d/.ok-planner/audits/stories/see-data.md" <<'MD'

## Referrals

- referral: whether the rendered table reads clearly
  discipline: ux
MD
run_case "a referral missing established:" "$d" 2 "lacks established"

d=$(fixture referral-bad-field); both_audited "$d"
cat >> "$d/.ok-planner/audits/stories/see-data.md" <<'MD'

## Referrals

- referral: whether the rendered table reads clearly
  delivered: the table is generated from the committed column set
  discipline: ux
MD
run_case "a referral field outside the grammar" "$d" 2 "is not one of"

# --- the checker's own error contract --------------------------------------
d="$tmp/no-corpus"; mkdir -p "$d"
run_case "a project with no design corpus" "$d" 1 "no design corpus"

if [ "$fail" -eq 0 ]; then
  echo "---"
  echo "all audit-check tests passed"
fi
exit $fail
