#!/usr/bin/env bash
# Test harness for document-check, the documentation-corpus validator.
# The checker has six jobs — stamp, warrant, remainder, evidence,
# catalog, and citation — and this drives each against a fixture built
# here rather than committed, the same shape run.sh uses for
# audit-check.
#
# What is deliberately unexercised: whether a warrant's run actually
# passed or a trap is really a trap. That is the ceremony's assessors,
# and no program can stand in for them.
#
# The checker itself is a payload vendored verbatim into consumer
# projects, so it carries no annotations of its own — a slug live in this
# monorepo's corpus dangles in every consumer's. This harness is
# repo-local, so it is where the corpus navigation lives.
#
# @story: answer-absence-from-catalogs
# @concept: documentation-corpus
set -uo pipefail

here="$(cd "$(dirname "$0")" && pwd)"
document_check="$here/../scripts/document-check"
fail=0

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

ok()  { echo "ok: $1"; }
bad() { echo "FAIL: $1"; fail=1; }

# fixture <name> — a git project with one committed source file (so
# citations have a real commit to resolve at) and an empty corpus
# layout. Prints "<dir> <sha>".
fixture() {
  local d="$tmp/$1"
  rm -rf "$d"
  mkdir -p "$d/src" \
           "$d/.ok-planner/documentation/catalog" \
           "$d/.ok-planner/documentation/assessments" \
           "$d/.ok-planner/documentation/traps" \
           "$d/.ok-planner/documentation/experiments"
  echo "print('hello')" > "$d/src/app.py"
  (
    cd "$d"
    git init -q .
    git add -A
    git -c user.email=t@example.com -c user.name=t commit -qm seed
  )
  printf '%s %s' "$d" "$(git -C "$d" rev-parse --short HEAD)"
}

# assessment <project> <slug> <subject> <outcome> <warrant> <release> [body]
assessment() {
  local d=$1 slug=$2 subject=$3 outcome=$4 warrant=$5 release=$6 body=${7:-}
  {
    echo "---"
    echo "assessment: $slug"
    echo "subject: $subject"
    echo "way: default"
    echo "release: $release"
    echo "outcome: $outcome"
    echo "warrant: $warrant"
    echo "---"
    echo
    echo "# $slug"
    echo
    echo "Attempted the way and observed the outcome."
    [ -n "$body" ] && printf '%s\n' "$body"
    echo
    echo "## Unverified"
    echo
    echo "Nothing beyond the measured way."
  } > "$d/.ok-planner/documentation/assessments/$slug.md"
}

# trap_record <project> <slug> <release> <repro> <evidence>
trap_record() {
  local d=$1 slug=$2 release=$3 repro=$4 evidence=$5
  {
    echo "---"
    echo "trap: $slug"
    echo "release: $release"
    echo "repro: $repro"
    echo "---"
    echo
    echo "# $slug"
    echo
    echo "## Assumption"
    echo
    echo "A user would assume the sibling behaves the same."
    echo
    echo "## Actual behavior"
    echo
    echo "It does not."
    echo
    echo "## Evidence"
    echo
    printf '%s\n' "$evidence"
  } > "$d/.ok-planner/documentation/traps/$slug.md"
}

# catalog_file <project> <kind> <release> <population> <rows...>
catalog_file() {
  local d=$1 kind=$2 release=$3 population=$4; shift 4
  {
    echo "---"
    echo "kind: $kind"
    echo "release: $release"
    echo "population: $population"
    echo "---"
    echo
    echo "# $kind"
    echo
    for r in "$@"; do echo "- \`$r\` — a member."; done
  } > "$d/.ok-planner/documentation/catalog/$kind.md"
}

# --- a clean corpus passes -------------------------------------------------
# The archived experiment below is the ladder's third rung, kept with what
# it observed rather than maintained by any suite.
# @concept: experiment
read -r d sha < <(fixture clean)
assessment "$d" see-data--default story:see-data held "test:tests/test_app.py" "$sha"
trap_record "$d" sibling-differs "$sha" not-attempted "Read src:src/app.py — the sibling path is absent."
catalog_file "$d" cli-verbs "$sha" 2 run help
mkdir -p "$d/.ok-planner/documentation/experiments/probe-1"
printf -- '---\nexperiment: probe-1\nrelease: %s\n---\n\n# probe-1\n\nRan against the release; observed the answer.\n' "$sha" \
  > "$d/.ok-planner/documentation/experiments/probe-1/record.md"
echo "probe" > "$d/.ok-planner/documentation/experiments/probe-1/run.sh"
out=$(python3 "$document_check" "$d"); rc=$?
if [ "$rc" -eq 0 ] && [ -z "$out" ]; then
  ok "a well-formed corpus is clean (exit 0, no output)"
else
  bad "clean corpus reported findings (exit $rc): $out"
fi

# A project with no documentation corpus at all is clean: the corpus is
# produced at releases, and absence is a state, not a defect.
# @decision: full-reassessment-per-release
read -r bare _ < <(fixture bare)
rm -rf "$bare/.ok-planner/documentation"
python3 "$document_check" "$bare" >/dev/null 2>&1 \
  && ok "no corpus, nothing to validate: exit 0" \
  || bad "an absent corpus was reported as a finding"

# --- warrant: held needs an affirmative warrant ----------------------------
# @decision: affirmative-warrant-ladder
read -r d sha < <(fixture warrant)
assessment "$d" see-data--default story:see-data held none "$sha"
out=$(python3 "$document_check" "$d"); rc=$?
[ "$rc" -eq 2 ] && grep -q '\[warrant\]' <<<"$out" \
  && ok "held with warrant none is a warrant finding (exit 2)" \
  || bad "held-without-warrant not caught (exit $rc): $out"

assessment "$d" see-data--default story:see-data unverified "test:tests/test_app.py" "$sha"
out=$(python3 "$document_check" "$d")
grep -q '\[warrant\]' <<<"$out" \
  && ok "unverified beside a warrant is the contradiction it looks like" \
  || bad "unverified-with-warrant not caught: $out"

# --- remainder: the Unverified section is mandatory ------------------------
# @concept: assessment
read -r d sha < <(fixture remainder)
assessment "$d" see-data--default story:see-data held "test:tests/test_app.py" "$sha"
a_file="$d/.ok-planner/documentation/assessments/see-data--default.md"
sed '/## Unverified/,$d' "$a_file" > "$a_file.tmp" && mv "$a_file.tmp" "$a_file"
out=$(python3 "$document_check" "$d")
grep -q '\[remainder\]' <<<"$out" \
  && ok "a missing ## Unverified section is a remainder finding" \
  || bad "missing remainder section not caught: $out"

# --- stamp: every record names its release ---------------------------------
read -r d sha < <(fixture stamp)
assessment "$d" see-data--default story:see-data held "test:tests/test_app.py" ""
out=$(python3 "$document_check" "$d")
grep -q '\[stamp\]' <<<"$out" \
  && ok "an empty release stamp is a stamp finding" \
  || bad "empty stamp not caught: $out"

# --- evidence: a trap rests on its evidence set ----------------------------
# @concept: trap
read -r d sha < <(fixture evidence)
trap_record "$d" sibling-differs "$sha" not-attempted ""
out=$(python3 "$document_check" "$d")
grep -q '\[evidence\]' <<<"$out" \
  && ok "an empty ## Evidence section is an evidence finding" \
  || bad "empty evidence not caught: $out"

trap_record "$d" sibling-differs "$sha" maybe "Read the source."
out=$(python3 "$document_check" "$d")
grep -q 'repro' <<<"$out" \
  && ok "a repro value outside the three states is a shape finding" \
  || bad "bad repro vocabulary not caught: $out"

# --- catalog: rows match the declared population one-to-one ----------------
# @concept: surface-declaration
read -r d sha < <(fixture catalog)
catalog_file "$d" cli-verbs "$sha" 3 run help
out=$(python3 "$document_check" "$d")
grep -q '\[catalog\]' <<<"$out" \
  && ok "2 rows against population: 3 is a catalog finding" \
  || bad "catalog count mismatch not caught: $out"

catalog_file "$d" cli-verbs "$sha" 0
python3 "$document_check" "$d" >/dev/null 2>&1 \
  && ok "population: 0 with no rows is legal (expected-empty kind)" \
  || bad "an expected-empty catalog was flagged"

# --- citation: src: paths resolve at the stamped commit --------------------
# @decision: documentation-citations-are-product
read -r d sha < <(fixture citation)
trap_record "$d" cites-well "$sha" not-attempted "Read src:src/app.py at the release."
python3 "$document_check" "$d" >/dev/null 2>&1 \
  && ok "a citation resolving at the stamp is clean" \
  || bad "a resolving citation was flagged"

trap_record "$d" cites-badly "$sha" not-attempted "Read src:src/gone.py at the release."
out=$(python3 "$document_check" "$d")
grep -q '\[citation\]' <<<"$out" \
  && ok "a citation that does not resolve at the stamp is a citation finding" \
  || bad "dangling citation not caught: $out"

rm -f "$d/.ok-planner/documentation/traps/cites-badly.md"
trap_record "$d" cites-nowhere deadbeef1234 not-attempted "Read src:src/app.py at the release."
out=$(python3 "$document_check" "$d")
grep -q '\[citation\]' <<<"$out" \
  && ok "a release stamp git does not know fails the citation, loudly" \
  || bad "unknown release stamp not caught: $out"

exit $fail
