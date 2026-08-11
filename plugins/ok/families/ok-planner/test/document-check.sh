#!/usr/bin/env bash
# Test harness for document-check, the documentation-corpus validator.
# The checker has seven jobs — stamp, warrant, remainder, vocabulary,
# evidence, catalog, and citation — and this drives each against a
# fixture built here rather than committed.
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

# fixture <name> — a git project with one committed source file, a
# committed surface extraction (kind cli-verbs: run and help public,
# debug internal), and an empty corpus layout. Prints "<dir> <sha>" —
# the sha holds the extraction, so catalog: citations resolve at the
# stamp.
fixture() {
  local d="$tmp/$1"
  rm -rf "$d"
  mkdir -p "$d/src" \
           "$d/.ok-planner/audits/surface" \
           "$d/.ok-planner/documentation/catalog" \
           "$d/.ok-planner/documentation/assessments" \
           "$d/.ok-planner/documentation/traps" \
           "$d/.ok-planner/documentation/evidence" \
           "$d/.ok-planner/experiments"
  echo "print('hello')" > "$d/src/app.py"
  printf '{"commit":"seed","elements":[{"kind":"cli-verbs","id":"run","location":"src/app.py","public":true,"rule":"every CLI verb under src/ is public","defaulted":false},{"kind":"cli-verbs","id":"help","location":"src/app.py","public":true,"rule":"every CLI verb under src/ is public","defaulted":false},{"kind":"cli-verbs","id":"debug","location":"src/app.py","public":false,"rule":"debug is named internal by the intent","defaulted":false}]}\n' \
    > "$d/.ok-planner/audits/surface/extraction.json"
  (
    cd "$d"
    git init -q .
    git add -A
    git -c user.email=t@example.com -c user.name=t commit -qm seed
  )
  printf '%s %s' "$d" "$(git -C "$d" rev-parse --short HEAD)"
}

# experiment_record <project> <slug> <commit> — an experiment archive entry.
experiment_record() {
  local d=$1 slug=$2 commit=$3
  mkdir -p "$d/.ok-planner/experiments/$slug"
  printf -- '---\nexperiment: %s\ncommit: %s\n---\n\n# %s\n\nRan against the release; observed the answer.\n' \
    "$slug" "$commit" "$slug" \
    > "$d/.ok-planner/experiments/$slug/record.md"
  echo "probe" > "$d/.ok-planner/experiments/$slug/run.sh"
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
    echo "Attempted the way through catalog:cli-verbs/run and observed the outcome."
    [ -n "$body" ] && printf '%s\n' "$body"
    echo
    echo "## Unverified"
    echo
    echo "Nothing beyond the measured way."
  } > "$d/.ok-planner/documentation/assessments/$slug.md"
}

# trap_record <project> <slug> <release> <demonstration>
trap_record() {
  local d=$1 slug=$2 release=$3 demonstration=$4
  {
    echo "---"
    echo "trap: $slug"
    echo "release: $release"
    echo "demonstration: $demonstration"
    echo "---"
    echo
    echo "# $slug"
    echo
    echo "## Assumption"
    echo
    echo "A user would assume catalog:cli-verbs/help behaves like its sibling."
    echo
    echo "## Actual behavior"
    echo
    echo "It does not."
  } > "$d/.ok-planner/documentation/traps/$slug.md"
}

# evidence_record <project> <slug> <release> <body>
evidence_record() {
  local d=$1 slug=$2 release=$3 body=$4
  {
    echo "---"
    echo "trap: $slug"
    echo "release: $release"
    echo "---"
    echo
    echo "# $slug"
    echo
    printf '%s\n' "$body"
  } > "$d/.ok-planner/documentation/evidence/$slug.md"
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

# --- a clean split corpus passes --------------------------------------------
# Held claims rest on the maintained experiments, publishable records speak
# catalog rows, and the trap's evidence set is a verification-layer
# record free to read the tree.
# @concept: experiment
read -r d sha < <(fixture clean)
experiment_record "$d" probe-1 "$sha"
assessment "$d" see-data--default story:see-data held "experiment:probe-1" "$sha"
trap_record "$d" sibling-differs "$sha" "experiment:probe-1"
evidence_record "$d" sibling-differs "$sha" "Read src:src/app.py — the sibling path is absent."
catalog_file "$d" cli-verbs "$sha" 2 run help
out=$(python3 "$document_check" "$d"); rc=$?
if [ "$rc" -eq 0 ] && [ -z "$out" ]; then
  ok "a well-formed split corpus is clean (exit 0, no output)"
else
  bad "clean corpus reported findings (exit $rc): $out"
fi

# A project with no documentation corpus at all is clean: the corpus is
# produced at releases, and absence is a state, not a defect.
# @decision: full-reassessment-per-release
read -r bare _ < <(fixture bare)
rm -rf "$bare/.ok-planner/documentation" "$bare/.ok-planner/experiments"
python3 "$document_check" "$bare" >/dev/null 2>&1 \
  && ok "no corpus, nothing to validate: exit 0" \
  || bad "an absent corpus was reported as a finding"

# --- warrant: held rests on the experiments, and only the experiments ---------------
# @decision: affirmative-warrant-ladder
read -r d sha < <(fixture warrant)
assessment "$d" see-data--default story:see-data held none "$sha"
out=$(python3 "$document_check" "$d"); rc=$?
[ "$rc" -eq 2 ] && grep -q '\[warrant\]' <<<"$out" \
  && ok "held with warrant none is a warrant finding (exit 2)" \
  || bad "held-without-warrant not caught (exit $rc): $out"

assessment "$d" see-data--default story:see-data held "test:tests/test_app.py" "$sha"
out=$(python3 "$document_check" "$d")
grep -q 'retired' <<<"$out" \
  && ok "the test: warrant form is retired — a warrant finding names it" \
  || bad "retired test: warrant not caught: $out"

assessment "$d" see-data--default story:see-data unverified "experiment:probe-1" "$sha"
out=$(python3 "$document_check" "$d")
grep -q '\[warrant\]' <<<"$out" \
  && ok "unverified beside a warrant is the contradiction it looks like" \
  || bad "unverified-with-warrant not caught: $out"

# --- remainder: the Unverified section is mandatory ------------------------
# @concept: assessment
read -r d sha < <(fixture remainder)
experiment_record "$d" probe-1 "$sha"
assessment "$d" see-data--default story:see-data held "experiment:probe-1" "$sha"
a_file="$d/.ok-planner/documentation/assessments/see-data--default.md"
sed '/## Unverified/,$d' "$a_file" > "$a_file.tmp" && mv "$a_file.tmp" "$a_file"
out=$(python3 "$document_check" "$d")
grep -q '\[remainder\]' <<<"$out" \
  && ok "a missing ## Unverified section is a remainder finding" \
  || bad "missing remainder section not caught: $out"

# --- stamp: every record names its release ---------------------------------
read -r d sha < <(fixture stamp)
experiment_record "$d" probe-1 "$sha"
assessment "$d" see-data--default story:see-data held "experiment:probe-1" ""
out=$(python3 "$document_check" "$d")
grep -q '\[stamp\]' <<<"$out" \
  && ok "an empty release stamp is a stamp finding" \
  || bad "empty stamp not caught: $out"

# --- vocabulary: the shipped layer never cites the tree ---------------------
# @decision: documentation-citations-are-product
read -r d sha < <(fixture vocabulary)
experiment_record "$d" probe-1 "$sha"
assessment "$d" see-data--default story:see-data held "experiment:probe-1" "$sha" \
  "See src:src/app.py for the implementation."
out=$(python3 "$document_check" "$d")
grep -q '\[vocabulary\]' <<<"$out" \
  && ok "a src: citation in a publishable record is a vocabulary finding" \
  || bad "src: in publishable record not caught: $out"

# --- evidence: a trap rests on its evidence set ----------------------------
# @concept: trap
read -r d sha < <(fixture evidence)
trap_record "$d" sibling-differs "$sha" none
out=$(python3 "$document_check" "$d")
grep -q '\[evidence\]' <<<"$out" \
  && ok "a trap with no evidence record is an evidence finding" \
  || bad "missing evidence record not caught: $out"

evidence_record "$d" sibling-differs "$sha" ""
out=$(python3 "$document_check" "$d")
grep -q '\[evidence\]' <<<"$out" \
  && ok "an empty evidence record is an evidence finding" \
  || bad "empty evidence record not caught: $out"

evidence_record "$d" sibling-differs "$sha" "Read the source."
trap_record "$d" sibling-differs "$sha" maybe
out=$(python3 "$document_check" "$d")
grep -q 'demonstration' <<<"$out" \
  && ok "a demonstration value outside the grammar is a shape finding" \
  || bad "bad demonstration vocabulary not caught: $out"

# --- catalog: rows match the population, and the population the extraction --
# @concept: surface-extraction
read -r d sha < <(fixture catalog)
catalog_file "$d" cli-verbs "$sha" 3 run help
out=$(python3 "$document_check" "$d")
grep -q '\[catalog\]' <<<"$out" \
  && ok "2 rows against population: 3 is a catalog finding" \
  || bad "catalog count mismatch not caught: $out"

catalog_file "$d" cli-verbs "$sha" 1 run
out=$(python3 "$document_check" "$d")
grep -q 'public member' <<<"$out" \
  && ok "a population disagreeing with the extraction's public side is caught" \
  || bad "population-vs-extraction mismatch not caught: $out"

# --- citation: catalog rows resolve against the extraction at the stamp -----
# @decision: documentation-citations-are-product
read -r d sha < <(fixture citation)
experiment_record "$d" probe-1 "$sha"
assessment "$d" see-data--default story:see-data held "experiment:probe-1" "$sha" \
  "The internal catalog:cli-verbs/debug verb is not part of the surface."
out=$(python3 "$document_check" "$d")
grep -q 'does not resolve to a public member' <<<"$out" \
  && ok "a catalog: citation naming an internal member is a citation finding" \
  || bad "catalog: citation to an internal member not caught: $out"

assessment "$d" see-data--default story:see-data held "experiment:probe-1" "$sha" \
  "The catalog:cli-verbs/vanish verb."
out=$(python3 "$document_check" "$d")
grep -q '\[citation\]' <<<"$out" \
  && ok "a catalog: citation naming no extracted member is a citation finding" \
  || bad "dangling catalog: citation not caught: $out"

# --- the verification layer keeps its resolve-in-tree check -----------------
read -r d sha < <(fixture tree-citation)
trap_record "$d" cites-badly "$sha" none
evidence_record "$d" cites-badly "$sha" "Read src:src/gone.py at the release."
out=$(python3 "$document_check" "$d")
grep -q 'does not resolve in the tree' <<<"$out" \
  && ok "an evidence citation that does not resolve at the stamp is a citation finding" \
  || bad "dangling evidence citation not caught: $out"

evidence_record "$d" cites-badly "$sha" "Read src:src/app.py at the release."
python3 "$document_check" "$d" >/dev/null 2>&1 \
  && ok "an evidence citation resolving at the stamp is clean" \
  || bad "a resolving evidence citation was flagged"

rm -f "$d/.ok-planner/documentation/traps/cites-badly.md" \
      "$d/.ok-planner/documentation/evidence/cites-badly.md"
trap_record "$d" cites-nowhere deadbeef1234 none
evidence_record "$d" cites-nowhere deadbeef1234 "Read src:src/app.py at the release."
out=$(python3 "$document_check" "$d")
grep -q '\[citation\]' <<<"$out" \
  && ok "a stamp git does not know fails the citation, loudly" \
  || bad "unknown release stamp not caught: $out"

# --- the experiment archive: record shape and its commit stamp -----------------
# @concept: experiment
read -r d sha < <(fixture experiments)
mkdir -p "$d/.ok-planner/experiments/probe-x"
echo "probe" > "$d/.ok-planner/experiments/probe-x/run.sh"
out=$(python3 "$document_check" "$d")
grep -q 'no record.md' <<<"$out" \
  && ok "an archived experiment without a record is a shape finding" \
  || bad "recordless experiment not caught: $out"

rm -rf "$d/.ok-planner/experiments/probe-x"
mkdir -p "$d/.ok-planner/experiments/probe-y"
printf -- '---\nexperiment: probe-y\nrelease: %s\n---\n\n# probe-y\n\nObserved.\n' "$sha" \
  > "$d/.ok-planner/experiments/probe-y/record.md"
out=$(python3 "$document_check" "$d")
grep -q 'missing `commit:`' <<<"$out" \
  && ok "an experiment record without its commit stamp is a shape finding" \
  || bad "missing commit stamp on experiment record not caught: $out"

exit $fail
