#!/usr/bin/env bash
# Test harness for audit-check, the audit-corpus shape-and-invariant
# validator. The checker has eight jobs — coverage, catalogs, shape,
# brevity, agreement, the surface ruling, the assumption records, and
# the run report at close — and this drives each against a fixture built
# here rather than committed: an audit is nine lines, so a fixture the
# reader can see inside the case that uses it beats one they have to go
# find.
#
# What is deliberately unexercised: whether an implementation verdict is
# *true*. That is the periodic audit run's judgment, made by agents
# reading the code, and no program can stand in for it.
set -uo pipefail

here="$(cd "$(dirname "$0")" && pwd)"
audit_check="$here/../scripts/audit-check"
fail=0

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

# fixture <name> — a project with one story and one decision, no audits.
# The run report for the stamp every audit helper writes (abc1234) is
# present by default: a fully stamped corpus without its report is the
# report-missing finding, exercised by its own case below.
fixture() {
  local d="$tmp/$1"
  rm -rf "$d"
  mkdir -p "$d/.ok-planner/design/stories" "$d/.ok-planner/design/decisions" \
           "$d/.ok-planner/audits/stories" "$d/.ok-planner/audits/decisions" \
           "$d/.ok-planner/issues" "$d/.ok-planner/history/audits"
  printf -- '---\nstory: see-data\n---\n\n# See the data\n\n## Story\n\nAs a reader, I want to see the data, so that I can act on it.\n' \
    > "$d/.ok-planner/design/stories/see-data.md"
  printf -- '---\ndecision: loopback-ports\n---\n\n# Ports bind loopback\n\n## Choice\n\nThe port binds the loopback interface.\n' \
    > "$d/.ok-planner/design/decisions/loopback-ports.md"
  printf -- '# Audit run — fixture at abc1234\n' \
    > "$d/.ok-planner/history/audits/2026-07-30-abc1234-report.md"
  catalog "$d" stories see-data
  catalog "$d" decisions loopback-ports
  printf '%s' "$d"
}

# assumption <project> <slug> <disposition> [issue] — a run-generated
# assumption record under audits/assumptions/.
assumption() {
  local d=$1 slug=$2 disposition=$3 issue=${4:-}
  mkdir -p "$d/.ok-planner/audits/assumptions"
  {
    echo "---"
    echo "assumption: $slug"
    echo "commit: abc1234"
    echo "disposition: $disposition"
    [ -n "$issue" ] && echo "issue: $issue"
    echo "---"
    echo
    echo "# A prior a user would hold"
    echo
    echo "The prior, and what the measuring run observed."
  } > "$d/.ok-planner/audits/assumptions/$slug.md"
}

# catalog <project> <bucket> <slug>... — the generated index beside a
# collection. Every durable catalog has one, so every fixture does too.
catalog() {
  local d=$1 bucket=$2; shift 2
  {
    echo "# Catalog (auto-generated)"
    echo
    echo "## Entries"
    echo
    for s in "$@"; do echo "- \`$s\` — a one-line summary."; done
  } > "$d/.ok-planner/design/$bucket.md"
}

# audit <project> <bucket> <slug> <implementation> — the canonical shape:
# frontmatter, a heading, one paragraph. The audit corpus and the issue
# intake are independent; the frontmatter carries no issue: field.
audit() {
  local d=$1 bucket=$2 slug=$3 impl=$4 kind=decision
  [ "$bucket" = stories ] && kind=story
  [ "$bucket" = subjects ] && kind=subject
  {
    echo "---"
    echo "audit: $slug"
    echo "artifact: $kind:$slug"
    echo "text: compliant"
    echo "implementation: $impl"
    echo "commit: abc1234"
    echo "audited: 2026-07-30T00:00:00Z"
    echo "---"
    echo
    echo "# Whether the project supports it"
    echo
    echo "$impl. Checked all 3 call sites the interface's implementors name."
  } > "$d/.ok-planner/audits/$bucket/$slug.md"
}

both_audited() {  # both_audited <project> [implementation]
  audit "$1" stories see-data "${2:-supported}"
  audit "$1" decisions loopback-ports "${2:-supported}"
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

# --- shape: frontmatter, slug, kind, implementation vocabulary --------------
d=$(fixture no-frontmatter); both_audited "$d"
printf '# just prose\n' > "$d/.ok-planner/audits/stories/see-data.md"
run_case "no frontmatter block" "$d" 2 "no closed YAML frontmatter"

d=$(fixture no-commit); both_audited "$d"
a="$d/.ok-planner/audits/stories/see-data.md"
grep -v '^commit:' "$a" > "$d/t" && mv "$d/t" "$a"
run_case "frontmatter without the commit it describes" "$d" 2 "lacks commit:"

d=$(fixture bad-implementation); both_audited "$d"
a="$d/.ok-planner/audits/stories/see-data.md"
sed 's/^implementation: supported/implementation: satisfied/' "$a" > "$d/t" && mv "$d/t" "$a"
run_case "an implementation value outside the two words" "$d" 2 "is not one of"

d=$(fixture wrong-kind); both_audited "$d"
a="$d/.ok-planner/audits/stories/see-data.md"
sed 's/^artifact: story:see-data/artifact: decision:see-data/' "$a" > "$d/t" && mv "$d/t" "$a"
run_case "an artifact kind disagreeing with its bucket" "$d" 2 "must be 'story:see-data'"

d=$(fixture wrong-slug); both_audited "$d"
a="$d/.ok-planner/audits/stories/see-data.md"
sed 's/^audit: see-data/audit: something-else/' "$a" > "$d/t" && mv "$d/t" "$a"
run_case "an audit slug disagreeing with its filename" "$d" 2 "does not match the filename"

d=$(fixture audit-with-issue); both_audited "$d"
a="$d/.ok-planner/audits/stories/see-data.md"
sed 's/^audited:/issue: some-slug\naudited:/' "$a" > "$d/t" && mv "$d/t" "$a"
run_case "an audit carrying an issue link" "$d" 2 "an audit is a record, not an intake link"

# --- brevity: one paragraph, and only the format's sections beside it -------
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
run_case "no verdict paragraph at all" "$d" 2 "no verdict paragraph"

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

# --- the text axis: independent of the implementation verdict ---------------
# @story: corpus-audit
d=$(fixture no-text); both_audited "$d"
a="$d/.ok-planner/audits/stories/see-data.md"
grep -v '^text:' "$a" > "$d/t" && mv "$d/t" "$a"
run_case "frontmatter without the text axis" "$d" 2 "lacks text:"

d=$(fixture bad-text); both_audited "$d"
a="$d/.ok-planner/audits/stories/see-data.md"
sed 's/^text: compliant/text: mostly/' "$a" > "$d/t" && mv "$d/t" "$a"
run_case "a text value outside the two words" "$d" 2 "text: 'mostly' is not one of"

d=$(fixture noncompliant-bare); both_audited "$d"
a="$d/.ok-planner/audits/stories/see-data.md"
sed 's/^text: compliant/text: noncompliant/' "$a" > "$d/t" && mv "$d/t" "$a"
run_case "noncompliant text without saying which rule" "$d" 2 "without a Compliance section"

d=$(fixture noncompliant-said); both_audited "$d"
a="$d/.ok-planner/audits/stories/see-data.md"
sed 's/^text: compliant/text: noncompliant/' "$a" > "$d/t" && mv "$d/t" "$a"
printf '\n## Compliance\n\nThe Story line carries no "so that" clause.\n' >> "$a"
run_case "a noncompliant artifact accurately implemented" "$d" 0 ""

d=$(fixture compliant-with-section); both_audited "$d"
printf '\n## Compliance\n\nNothing to report.\n' \
  >> "$d/.ok-planner/audits/stories/see-data.md"
run_case "compliant text carrying a Compliance section" "$d" 2 "compliant text beside a Compliance section"

# --- the coverage shape: counts, and the members nothing accounts for -------
# @story: practice-coverage-report
# A second estate, whose live collection sits directly under the estate
# rather than under design/ — the checker resolves either.
coverage_fixture() {  # coverage_fixture <name> <unaccounted> [implementation] [checked]
  local d; d=$(fixture "$1"); local n=$2 impl=${3:-supported} checked=${4:-12}
  mkdir -p "$d/.ok-plumbline/subjects" "$d/.ok-plumbline/audits/subjects" \
           "$d/.ok-plumbline/history/audits"
  printf -- '# Audit run — fixture at abc1234\n' \
    > "$d/.ok-plumbline/history/audits/2026-07-30-abc1234-report.md"
  printf -- '---\nsubject: wire-payloads\n---\n\n# Wire payloads\n\n## What it is\n\nEvery value crossing the wire.\n' \
    > "$d/.ok-plumbline/subjects/wire-payloads.md"
  printf -- '# Subject catalog\n\n## Subjects\n\n- `wire-payloads` — every value crossing the wire.\n' \
    > "$d/.ok-plumbline/subjects.md"
  {
    echo "---"
    echo "audit: wire-payloads"
    echo "artifact: subject:wire-payloads"
    echo "text: compliant"
    echo "implementation: $impl"
    echo "commit: abc1234"
    echo "audited: 2026-07-30T00:00:00Z"
    echo "checked: $checked"
    echo "unaccounted: $n"
    echo "---"
    echo
    echo "# How far the practices reached"
    echo
    echo "Enumerated $checked members from the declared call sites."
  } > "$d/.ok-plumbline/audits/subjects/wire-payloads.md"
  printf '%s' "$d"
}

d=$(coverage_fixture coverage-full 0); both_audited "$d"
run_case "a fully covered subject in a second estate" "$d" 0 ""

d=$(coverage_fixture coverage-gap 3 unsupported); both_audited "$d"
printf '\n## Unaccounted\n\n- three payload types no practice claims\n' \
  >> "$d/.ok-plumbline/audits/subjects/wire-payloads.md"
run_case "unaccounted members named" "$d" 0 ""

d=$(coverage_fixture coverage-unnamed 3 unsupported); both_audited "$d"
run_case "unaccounted members nobody named" "$d" 2 "without an Unaccounted section"

d=$(coverage_fixture coverage-disagrees 3); both_audited "$d"
printf '\n## Unaccounted\n\n- three payload types no practice claims\n' \
  >> "$d/.ok-plumbline/audits/subjects/wire-payloads.md"
run_case "supported beside a nonzero unaccounted count" "$d" 2 "audit-disagrees"

d=$(coverage_fixture coverage-zero-disagrees 0 unsupported); both_audited "$d"
run_case "nothing unaccounted beside an unsupported verdict" "$d" 2 "audit-disagrees"

d=$(coverage_fixture coverage-half 0); both_audited "$d"
a="$d/.ok-plumbline/audits/subjects/wire-payloads.md"
grep -v '^checked:' "$a" > "$d/t" && mv "$d/t" "$a"
run_case "half the coverage shape" "$d" 2 "both checked: and unaccounted:"

d=$(fixture remediation-uncounted); both_audited "$d"
printf '\n## Remediation\n\n- one site departs from the practice governing it\n' \
  >> "$d/.ok-planner/audits/stories/see-data.md"
run_case "a remediation list on a non-coverage audit" "$d" 2 "belong to coverage-shaped"

# --- coverage when an estate has a corpus but no audits at all --------------
# The state coverage exists to report, and the one an estate-level audits/
# gate used to swallow whole.
d="$tmp/unaudited"; rm -rf "$d"
mkdir -p "$d/.ok-planner/design/decisions" "$d/.ok-planner/issues"
printf -- '---\ndecision: loopback-ports\n---\n\n# Ports bind loopback\n\n## Choice\n\nThe port binds the loopback interface.\n' \
  > "$d/.ok-planner/design/decisions/loopback-ports.md"
catalog "$d" decisions loopback-ports
run_case "a live corpus with no audits/ at all reports every artifact missing" "$d" 2 "audit-missing"

d="$tmp/no-catalog"; rm -rf "$d"
mkdir -p "$d/.ok-planner/design/decisions" "$d/.ok-planner/audits/decisions" "$d/.ok-planner/issues"
printf -- '---\ndecision: loopback-ports\n---\n\n# Ports bind loopback\n\n## Choice\n\nThe port binds the loopback interface.\n' \
  > "$d/.ok-planner/design/decisions/loopback-ports.md"
audit "$d" decisions loopback-ports supported
run_case "a collection with no table of contents at all" "$d" 2 "catalog-missing"

# --- catalogs: the TOC beside a collection is the audit's backstop ----------
# @concept: catalog-toc
d=$(fixture catalog-clean); both_audited "$d"
catalog "$d" stories see-data
catalog "$d" decisions loopback-ports
run_case "a TOC listing exactly its collection's live slugs" "$d" 0 ""

d=$(fixture catalog-stale); both_audited "$d"
catalog "$d" stories see-data retired-thing
catalog "$d" decisions loopback-ports
run_case "a TOC bullet naming no live artifact" "$d" 2 "catalog-stale"

d=$(fixture catalog-incomplete); both_audited "$d"
catalog "$d" stories
catalog "$d" decisions loopback-ports
run_case "a live artifact with no TOC entry" "$d" 2 "catalog-incomplete"

# --- the surface ruling: anchors, totality, guidance agreement --------------
# @decision: owner-guided-surface-partition
# ruling_fixture <name> — a clean corpus plus a settled surface ruling
# whose guidanceHash matches the guidance file (the working-tree blob is
# the comparison fallback where the stamped commit does not resolve,
# which is every fixture here).
guidance_hash() {
  python3 - "$1" <<'PY'
import hashlib, sys
content = open(sys.argv[1], "rb").read()
print(hashlib.sha1(b"blob %d\0" % len(content) + content).hexdigest())
PY
}

ruling_fixture() {
  local d; d=$(fixture "$1"); both_audited "$d"
  mkdir -p "$d/.ok-planner/surface" "$d/.ok-planner/audits/surface"
  printf 'All CLI verbs are public except the plumbing ones.\n' \
    > "$d/.ok-planner/surface/guidance.md"
  local gh; gh=$(guidance_hash "$d/.ok-planner/surface/guidance.md")
  printf '{"kinds":[{"kind":"cli-verbs","members":["alpha","beta"]}]}\n' \
    > "$d/.ok-planner/audits/surface/extraction.json"
  printf '{"commit":"abc1234","guidanceHash":"%s","kinds":[{"kind":"cli-verbs","public":["alpha"],"private":["beta"]}]}\n' "$gh" \
    > "$d/.ok-planner/audits/surface/ruling.json"
  printf '%s' "$d"
}

d=$(ruling_fixture ruling-clean)
run_case "a settled ruling: anchors, total partition, ratified guidance" "$d" 0 ""

d=$(ruling_fixture ruling-no-commit)
python3 - "$d/.ok-planner/audits/surface/ruling.json" <<'PY'
import json, sys
p = sys.argv[1]; r = json.load(open(p)); del r["commit"]
json.dump(r, open(p, "w"))
PY
run_case "a ruling without its commit anchor" "$d" 2 "no commit anchor"

d=$(ruling_fixture ruling-no-guidance-hash)
python3 - "$d/.ok-planner/audits/surface/ruling.json" <<'PY'
import json, sys
p = sys.argv[1]; r = json.load(open(p)); del r["guidanceHash"]
json.dump(r, open(p, "w"))
PY
run_case "a ruling without its guidance anchor" "$d" 2 "no guidanceHash anchor"

d=$(ruling_fixture ruling-unruled-member)
printf '{"kinds":[{"kind":"cli-verbs","members":["alpha","beta","gamma"]}]}\n' \
  > "$d/.ok-planner/audits/surface/extraction.json"
run_case "an enumerated member nothing rules" "$d" 2 "never private by omission"

d=$(ruling_fixture ruling-stale-member)
printf '{"kinds":[{"kind":"cli-verbs","members":["alpha"]}]}\n' \
  > "$d/.ok-planner/audits/surface/extraction.json"
run_case "a ruled member absent from the extraction" "$d" 2 "absent from the cached extraction"

d=$(ruling_fixture ruling-both-sides)
python3 - "$d/.ok-planner/audits/surface/ruling.json" <<'PY'
import json, sys
p = sys.argv[1]; r = json.load(open(p))
r["kinds"][0]["private"].append("alpha")
json.dump(r, open(p, "w"))
PY
run_case "a member ruled both public and private" "$d" 2 "both public and private"

d=$(ruling_fixture ruling-unratified)
printf 'A rule the ruling never applied.\n' >> "$d/.ok-planner/surface/guidance.md"
run_case "guidance changed since the ruling was derived" "$d" 2 "unratified change"

d=$(ruling_fixture ruling-no-extraction)
rm "$d/.ok-planner/audits/surface/extraction.json"
run_case "a ruling with no cached extraction beside it" "$d" 2 "no cached extraction"

# --- the assumption corpus: run-generated records, shape and dispositions ---
# @concept: assumption
d=$(fixture assumptions-clean); both_audited "$d"
assumption "$d" fast-by-default held
assumption "$d" symmetric-verbs trap
assumption "$d" offline-mode unverified
run_case "assumption records with the three dispositions" "$d" 0 ""

d=$(fixture assumption-vocab); both_audited "$d"
assumption "$d" fast-by-default confirmed
run_case "a disposition outside the three words" "$d" 2 "is not one of held, trap, unverified"

d=$(fixture assumption-undisposed); both_audited "$d"
assumption "$d" fast-by-default held
sed -i '' '/^disposition:/d' "$d/.ok-planner/audits/assumptions/fast-by-default.md"
run_case "an assumption record with no disposition" "$d" 2 "lacks disposition:"

d=$(fixture assumption-filed); both_audited "$d"
assumption "$d" fast-by-default trap some-issue
run_case "an assumption carrying an issue link" "$d" 2 "an assumption files nothing"

d=$(fixture assumption-mismatch); both_audited "$d"
assumption "$d" fast-by-default held
mv "$d/.ok-planner/audits/assumptions/fast-by-default.md" \
   "$d/.ok-planner/audits/assumptions/other-name.md"
run_case "an assumption slug disagreeing with its filename" "$d" 2 "does not match the filename"

d=$(fixture assumption-bodyless); both_audited "$d"
assumption "$d" fast-by-default held
printf -- '---\nassumption: fast-by-default\ncommit: abc1234\ndisposition: held\n---\n\n# A heading only\n' \
  > "$d/.ok-planner/audits/assumptions/fast-by-default.md"
run_case "an assumption record with no body" "$d" 2 "no body"

# --- the run report: a stamped corpus names its report at close -------------
d=$(fixture report-missing); both_audited "$d"
rm "$d/.ok-planner/history/audits/2026-07-30-abc1234-report.md"
run_case "a stamped corpus with no run report" "$d" 2 "report-missing"

d=$(fixture report-midrun); both_audited "$d"
rm "$d/.ok-planner/history/audits/2026-07-30-abc1234-report.md"
sed -i '' 's/^commit: abc1234/commit: pending/' \
  "$d/.ok-planner/audits/stories/see-data.md"
run_case "mixed stamps mid-run: the report check stays silent" "$d" 0 ""

# --- the checker's own error contract --------------------------------------
d="$tmp/no-corpus"; mkdir -p "$d"
run_case "a project with no corpus at all" "$d" 1 "no estate carries a corpus"

if [ "$fail" -eq 0 ]; then
  echo "---"
  echo "all audit-check tests passed"
fi
exit $fail
