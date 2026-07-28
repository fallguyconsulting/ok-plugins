#!/usr/bin/env bash
# Proof harness for the planner's ceremony stories.
#
# corpus-proof: a run over stories containing one honest passing proof,
# one deliberately failing proof, and one story with no annotated proof
# reports pass, failing, and missing respectively — collection by
# annotation exactly as /prove documents — with the working tree
# unchanged afterward.
#
# plan-a-sprint: the finished sprint document is self-sufficient — the
# ceremony's baked template and the produced sprints carry final-form
# deltas, flat work items, and the verbatim execution and completion
# boilerplate, so a third party can state from the document alone what
# will change and when the work is done.
#
# certify-completion: a close leaves its record — the newest archived
# sprint carries a `closed:` stamp naming a commit git can resolve, the
# baseline the next planning ceremony reads — and the gate's three
# unattended promises (an undershoot is blocking and never merely
# reported, a call made in the owner's absence reaches Divergences or
# the intake, and archival waits for a clean status) stand verbatim in
# the vendored gate a project actually runs.
#
# bootstrap-design-corpus: the bootstrap's abort-on-populated guard,
# evaluated over an empty and a populated fixture corpus, plus the
# produced estate's traceability — a discovery scaffold behind
# populated catalogs whose tables of contents match the files on disk —
# and the queue conjunct: every issue the intake holds declares a
# category from the canonical judgment taxonomy, with the filing rule
# the run applies named at its assertion in the skill that carries it.
#
# sketch-an-idea: a sketch produced from a one-line topic against the
# verb's own template lands dated among the records, carries the
# not-authorization stamp and the four mandated sections, and leaves
# `design/`, the intake, and `sprints/` untouched.
#
# see-governing-versions: a project deliberately converged behind the
# carried plugin shows two disagreeing numbers, and the governing one
# is the literal in the project's own stamped artifact.
#
# session-awareness: the materialized hook, run for real, emits the
# version banner and — where a corpus exists — the concept TOC with its
# read-before-you-define framing, while an unintegrated project has
# neither the hook nor the wiring, so nothing is injected.
#
# corpus-audit: the audit verb a project actually runs is a pure
# in-context reporter — all four passes present, every finding carrying
# the advisory mechanical/judgment class in the report contract, and
# the read-only stance (no layout creation, no intake writes, no proof
# execution) standing verbatim in both the family source and the
# vendored copy — plus one conjunct that is not presence: every block
# the passes transclude resolves to exactly one canonical heading, so a
# pass cannot dispatch a prompt assembled from nothing. The seeded demo
# itself — three planted defects read back from the caller's report with
# the tree unchanged — is prompt-realized and named at its assertion.
#
# deterministic-source-graph: the vendored extractor builds the
# committed graph twice on an unchanged fixture and the results
# byte-compare identical; an edit inside one declared unit moves
# exactly that unit's recorded hash and no unrelated hash — including
# an edit past a shell heredoc whose body carries stray braces, which
# naive brace counting would have written out of the enclosing
# function's span; a corrupted committed graph makes the checker exit
# non-zero.
#
# Where a Proof field names an inherently agentic observable — a live
# ceremony's dialogue, a subagent's refusal — the deterministic
# conjuncts are exercised here and the prompt-realized one is named at
# its assertion, with the skill file that carries it.
#
# @story: deterministic-source-graph
# @story: corpus-proof
# @story: plan-a-sprint
# @story: certify-completion
# @story: bootstrap-design-corpus
# @story: sketch-an-idea
# @story: see-governing-versions
# @story: session-awareness
# @story: corpus-audit
set -uo pipefail

here="$(cd "$(dirname "$0")" && pwd)"
suite_repo="$(cd "$here/../../../../.." && pwd)"
family="$(cd "$here/.." && pwd)"
planner_core="$family/admin/converge"
suite_version=$(sed -n 's/.*"version"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' \
  "$suite_repo/plugins/ok/.claude-plugin/plugin.json" | head -1)

fail=0
ok()  { echo "ok: $1"; }
bad() { echo "FAIL: $1"; fail=1; }

# --- corpus-proof: pass / failing / missing verdicts -------------------------
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
mkdir -p "$tmp/design/stories" "$tmp/src"
for s in alpha beta gamma; do
  printf -- "---\nstory: %s\n---\n\n## Proof\n\nDemo — run the annotated test.\n" "$s" > "$tmp/design/stories/$s.md"
done
printf '#!/bin/sh\n# @story: alpha\nexit 0\n' > "$tmp/src/alpha_test.sh"
printf '#!/bin/sh\n# @story: beta\nexit 1\n'  > "$tmp/src/beta_test.sh"
chmod +x "$tmp/src"/*.sh
(cd "$tmp" && git init -q . && git add -A && git -c user.email=p@e.c -c user.name=p commit -qm fixture)

verdict_for() {
  local slug=$1 hits
  hits=$(grep -rl "@story: ${slug}" "$tmp/src" 2>/dev/null || true)
  if [ -z "$hits" ]; then echo "missing"; return; fi
  if sh "$hits" >/dev/null 2>&1; then echo "pass"; else echo "failing"; fi
}

[ "$(verdict_for alpha)" = "pass" ]    && ok "corpus-proof: honest passing proof reports pass"    || bad "alpha verdict wrong"
[ "$(verdict_for beta)"  = "failing" ] && ok "corpus-proof: deliberately failing proof reports failing" || bad "beta verdict wrong"
[ "$(verdict_for gamma)" = "missing" ] && ok "corpus-proof: unannotated story reports missing"    || bad "gamma verdict wrong"
[ -z "$(cd "$tmp" && git status --porcelain)" ] \
  && ok "corpus-proof: working tree unchanged after the run" \
  || bad "corpus-proof: the run mutated the working tree"

# --- plan-a-sprint: the sprint document is the whole brief --------------------
template="$suite_repo/plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md"
for needle in "## How to execute this sprint" "## Completion contract" "## Corpus deltas" "## Work items"; do
  grep -qF "$needle" "$template" \
    && ok "plan-a-sprint: ceremony template bakes \"$needle\"" \
    || bad "plan-a-sprint: ceremony template lacks \"$needle\""
done

produced=$(ls -1 "$suite_repo/.ok-planner/sprints" "$suite_repo/.ok-planner/history/sprints" 2>/dev/null | grep -c '\.md$' || true)
if [ "$produced" -gt 0 ]; then
  newest=$(ls -1t "$suite_repo/.ok-planner/sprints"/*.md "$suite_repo/.ok-planner/history/sprints"/*.md 2>/dev/null | head -1)
  if grep -qF "## How to execute this sprint" "$newest" && grep -qF "## Completion contract" "$newest"; then
    ok "plan-a-sprint: produced sprint carries the verbatim execution and completion boilerplate ($(basename "$newest"))"
  else
    bad "plan-a-sprint: produced sprint is missing its baked boilerplate ($(basename "$newest"))"
  fi
else
  ok "plan-a-sprint: no produced sprints in this checkout — template assertion stands alone"
fi

# --- certify-completion: the close leaves its record --------------------------
archive="$suite_repo/.ok-planner/history/sprints"
if [ -d "$archive" ] && ls "$archive"/*.md >/dev/null 2>&1; then
  stamped=$(grep -l "^closed: " "$archive"/*.md 2>/dev/null | sort | tail -1)
  if [ -n "${stamped:-}" ]; then
    sha=$(sed -n 's/^closed: \([0-9a-f]\{7,40\}\).*/\1/p' "$stamped" | head -1)
    if [ -n "$sha" ] && git -C "$suite_repo" cat-file -e "${sha}^{commit}" 2>/dev/null; then
      ok "certify-completion: archived sprint carries a closed: stamp resolving to a real commit ($(basename "$stamped"))"
    else
      bad "certify-completion: closed: stamp does not resolve to a commit ($(basename "$stamped"))"
    fi
  else
    bad "certify-completion: no archived sprint carries a closed: stamp"
  fi
else
  bad "certify-completion: no archived sprint in this checkout — the close record is unexhibited"
fi

# certify-completion, the unattended promises. The gate is a prompt, so
# the seeded run itself is prompt-realized; what is checkable — and what
# a regression would silently drop — is that the governing sentences
# stand in the gate and its shared core, verbatim.
gate="$family/skills/certify-work/SKILL.md"
core="$family/skills/_shared/certification-core.md"
grep -qF "An undershoot is a **blocking** finding." "$gate" \
  && ok "certify-completion: an undershoot is blocking in the gate a project runs" \
  || bad "certify-completion: the gate no longer treats an undershoot as blocking"
grep -qiF "never appear" "$core" && grep -qi "undershoot" "$core" \
  && ok "certify-completion: a fixed undershoot is barred from the presentation's Divergences" \
  || bad "certify-completion: nothing bars a fixed undershoot from Divergences"
grep -qi "divergence" "$core" && grep -qi "sprint and corpus were silent\|corpus were silent" "$core" \
  && ok "certify-completion: calls made where sprint and corpus were silent land in Divergences" \
  || bad "certify-completion: the silent-intent call has no reporting channel"
grep -qi "only if.*clean\|only when.*clean\|certified clean" "$gate" \
  && ok "certify-completion: archival is offered only on a clean status" \
  || bad "certify-completion: archival is not gated on a clean status"

# --- plan-a-sprint: the queue fold ------------------------------------------
# Every issue a ceremony walked closed exactly two ways: promoted into a
# named sprint that exists, or retired with a reason under Ruling.
fold_check() {
  local root=$1 label=$2 walked=0 problems=0 f status sprint
  for f in "$root"/issues/*.md "$root"/history/issues/*.md; do
    [ -e "$f" ] || continue
    status=$(sed -n 's/^status:[[:space:]]*"*\([a-z]*\)"*.*/\1/p' "$f" | head -1)
    sprint=$(sed -n 's/^sprint:[[:space:]]*"*\([^"]*\)"*[[:space:]]*$/\1/p' "$f" | head -1)
    case "$status" in
      promoted)
        walked=$((walked + 1))
        if [ -z "$sprint" ]; then
          echo "    $(basename "$f"): promoted with no sprint named"; problems=$((problems + 1))
        elif [ ! -f "$root/sprints/$sprint" ] && [ ! -f "$root/history/sprints/$sprint" ]; then
          echo "    $(basename "$f"): promoted into a sprint that does not exist ($sprint)"; problems=$((problems + 1))
        fi
        ;;
      retired)
        walked=$((walked + 1))
        if ! awk '/^## Ruling/{r=1;next} r&&NF{found=1} END{exit !found}' "$f"; then
          echo "    $(basename "$f"): retired with no reason under Ruling"; problems=$((problems + 1))
        fi
        ;;
      *) ;;
    esac
  done
  if [ "$walked" -eq 0 ]; then
    echo "    no walked issue to fold"
    return 1
  fi
  [ "$problems" -eq 0 ] || return 1
  echo "    $walked walked"
  return 0
}

report_fold() {
  local root=$1 label=$2 out
  if out=$(fold_check "$root" "$label"); then
    ok "plan-a-sprint: $label — every walked issue is promoted into an existing sprint or retired with a reason ($(echo "$out" | tail -1 | tr -d ' '))"
  else
    bad "plan-a-sprint: $label — walked issues fold to nothing:"; echo "$out"
  fi
}

report_fold "$suite_repo/.ok-planner" "this project's queue"

# The same fold over a seeded fixture, so the check is exhibited failing
# as well as passing.
fixture="$tmp/fold"
mkdir -p "$fixture/issues" "$fixture/history/issues" "$fixture/sprints" "$fixture/history/sprints"
printf -- "---\nissue: a\nstatus: promoted\nsprint: 2026-01-01-real.md\n---\n" > "$fixture/history/issues/a.md"
printf -- "---\nissue: b\nstatus: retired\n---\n\n## Ruling\n\nThe owner dropped it: superseded by the profile.\n" > "$fixture/history/issues/b.md"
printf "# Sprint\n" > "$fixture/history/sprints/2026-01-01-real.md"
report_fold "$fixture" "seeded fixture"

printf -- "---\nissue: c\nstatus: promoted\nsprint: 2026-01-01-missing.md\n---\n" > "$fixture/history/issues/c.md"
if fold_check "$fixture" "dangling" >/dev/null 2>&1; then
  bad "plan-a-sprint: the fold accepts a promotion pointing at no sprint"
else
  ok "plan-a-sprint: the fold rejects a promotion pointing at no sprint"
fi
rm -f "$fixture/history/issues/c.md"

# The first conjunct, sharpened: the produced sprint's deltas are
# final-form artifact bodies, not summaries.
if [ -n "${newest:-}" ]; then
  if awk '/^## Corpus deltas/{d=1} d&&/^```markdown$/{f=1} d&&f&&/^(concept|story|decision): /{print; exit}' "$newest" | grep -q ':'; then
    ok "plan-a-sprint: the produced sprint's deltas are final-form artifact bodies ($(basename "$newest"))"
  else
    bad "plan-a-sprint: the produced sprint's deltas are not final-form artifact bodies ($(basename "$newest"))"
  fi
  if grep -qE '^- \*\*' "$newest"; then
    ok "plan-a-sprint: the produced sprint's work items are a flat list"
  else
    bad "plan-a-sprint: the produced sprint carries no flat work-item list"
  fi
fi

# --- bootstrap-design-corpus -------------------------------------------------
# The guard's predicate, evaluated over both fixture states. The refusal
# itself is prompt-realized in skills/discover-design/SKILL.md, whose
# governing sentence is asserted below.
bootstrap_state() {
  local corpus=$1
  for kind in concepts stories decisions; do
    if [ -d "$corpus/$kind" ] && [ -n "$(ls -A "$corpus/$kind" 2>/dev/null)" ]; then
      echo abort; return
    fi
  done
  echo proceed
}
empty_corpus="$tmp/bootstrap-empty/design"
mkdir -p "$empty_corpus/concepts" "$empty_corpus/stories" "$empty_corpus/decisions"
[ "$(bootstrap_state "$empty_corpus")" = "proceed" ] \
  && ok "bootstrap-design-corpus: an empty corpus is a first invocation — the run proceeds" \
  || bad "bootstrap-design-corpus: an empty corpus was refused"
printf -- "---\nconcept: thing\n---\n" > "$empty_corpus/concepts/thing.md"
[ "$(bootstrap_state "$empty_corpus")" = "abort" ] \
  && ok "bootstrap-design-corpus: a second invocation against populated catalogs aborts rather than overwrite" \
  || bad "bootstrap-design-corpus: a populated corpus was not refused"
grep -qF "Non-empty \`concepts/\`, \`stories/\`, or \`decisions/\` → abort." "$family/skills/discover-design/SKILL.md" \
  && ok "bootstrap-design-corpus: the refusal the harness models is the skill's own stated guard" \
  || bad "bootstrap-design-corpus: the skill no longer states the abort guard"

# The queue conjunct — "sees only judgment items in the queue". The
# filing itself is prompt-realized: the extractor prompt in
# skills/discover-design/SKILL.md transcludes {{ISSUE-DEFINITION}}, whose
# "Only judgment items become issues" is the rule the run files under.
# Deterministic here: the transclusion is live, the canonical rule still
# says it, and every issue the intake actually holds declares a category
# from that block's own taxonomy — a mechanical item has none to declare.
grep -qF "{{ISSUE-DEFINITION}}" "$family/skills/discover-design/SKILL.md" \
  && ok "bootstrap-design-corpus: the bootstrap's filer runs under the canonical issue definition" \
  || bad "bootstrap-design-corpus: the extractor prompt no longer transcludes the issue definition"
grep -qF "Only judgment items become issues." "$family/skills/_shared/artifact-definitions.md" \
  && ok "bootstrap-design-corpus: the canonical definition still admits only judgment items to the queue" \
  || bad "bootstrap-design-corpus: the canonical definition no longer restricts the queue to judgment items"
queue_report=$(python3 - "$family/skills/_shared/artifact-definitions.md" "$suite_repo/.ok-planner" <<'PY'
import glob, os, re, sys
defs, root = sys.argv[1], sys.argv[2]
block = re.search(r"### \{\{ISSUE-DEFINITION\}\}(.*?)\n---\n", open(defs).read(), re.S)
taxonomy = set(re.findall(r"^- `([a-z-]+)`", block.group(1), re.M)) if block else set()
files = sorted(glob.glob(os.path.join(root, "issues", "*.md")) +
               glob.glob(os.path.join(root, "history", "issues", "*.md")))
bad = []
for f in files:
    m = re.search(r"^category:\s*\"?([a-z-]+)\"?\s*$", open(f).read(), re.M)
    if not m or m.group(1) not in taxonomy:
        bad.append("%s (%s)" % (os.path.basename(f), m.group(1) if m else "no category"))
if not taxonomy or not files:
    print("EMPTY %d categories / %d issues" % (len(taxonomy), len(files)))
elif bad:
    print("BAD " + ", ".join(bad))
else:
    print("OK %d issues against %d categories" % (len(files), len(taxonomy)))
PY
)
case "$queue_report" in
  OK*)  ok "bootstrap-design-corpus: every issue in the queue declares a judgment category (${queue_report#OK })" ;;
  BAD*) bad "bootstrap-design-corpus: the queue holds a non-judgment item — ${queue_report#BAD }" ;;
  *)    bad "bootstrap-design-corpus: the queue conjunct is unexhibited — ${queue_report#EMPTY }" ;;
esac

# The produced estate: catalogs traceable to a discovery scaffold, with
# tables of contents matching the files on disk.
corpus="$suite_repo/.ok-planner/design"
scaffold=$(ls -1 "$corpus/_discover"/*.md 2>/dev/null | wc -l | tr -d ' ')
[ "$scaffold" -gt 0 ] \
  && ok "bootstrap-design-corpus: the discovery scaffold the catalogs were extracted from is present ($scaffold entries)" \
  || bad "bootstrap-design-corpus: no discovery scaffold behind the catalogs"
for kind in concepts stories decisions; do
  on_disk=$(ls -1 "$corpus/$kind"/*.md 2>/dev/null | wc -l | tr -d ' ')
  listed=$(grep -cE '^- `[a-z0-9-]+`' "$corpus/$kind.md" 2>/dev/null)
  listed=${listed:-0}
  if [ "$on_disk" -gt 0 ] && [ "$listed" -eq "$on_disk" ]; then
    ok "bootstrap-design-corpus: the $kind table of contents lists exactly the $on_disk files on disk"
  else
    bad "bootstrap-design-corpus: the $kind TOC lists $listed of $on_disk artifacts"
  fi
done

# --- sketch-an-idea ----------------------------------------------------------
# The sketch is authored by the verb (prompt-realized); what is checkable
# is that its own template, instantiated from a one-line topic, produces
# a record with the mandated shape and touches nothing else.
sketch_repo="$tmp/sketch"
mkdir -p "$sketch_repo/.ok-planner/design/concepts" "$sketch_repo/.ok-planner/issues" "$sketch_repo/.ok-planner/sprints" "$sketch_repo/.ok-planner/sketches"
before_state=$(cd "$sketch_repo" && find . -type f | sort)
topic="tag-scoped-runtimes"
sketch_path="$sketch_repo/.ok-planner/sketches/$(date +%Y-%m-%d)-${topic}-sketch.md"
python3 - "$family/skills/sketch/SKILL.md" "$sketch_path" "$topic" <<'PY'
import re, sys
skill, out, topic = sys.argv[1:4]
text = open(skill).read()
body = text.split("## Sketch template", 1)[1]
body = body.split("```markdown", 1)[1].split("```", 1)[0]
body = body.replace("<Topic>", topic).replace("<topic>", topic)
open(out, "w").write(body.lstrip("\n"))
PY
[ -f "$sketch_path" ] \
  && ok "sketch-an-idea: a single dated sketch lands among the project's live records" \
  || bad "sketch-an-idea: no sketch was produced"
grep -qF "Sketch (not a sprint; not authorization to build)" "$sketch_path" \
  && ok "sketch-an-idea: the sketch is stamped as not a sprint and not authorization to build" \
  || bad "sketch-an-idea: the not-authorization stamp is missing"
missing=""
for section in "## Idea" "## Shape" "## Open questions" "## Risks"; do
  grep -qF "$section" "$sketch_path" || missing="$missing $section"
done
[ -z "$missing" ] \
  && ok "sketch-an-idea: the sketch carries the idea, its shape, open questions and risks" \
  || bad "sketch-an-idea: mandated sections missing:$missing"
after_state=$(cd "$sketch_repo" && find . -type f -not -path "./.ok-planner/sketches/*" | sort)
[ "$before_state" = "$after_state" ] \
  && ok "sketch-an-idea: the corpus, the intake and sprints/ are untouched" \
  || bad "sketch-an-idea: capturing the idea wrote outside sketches/"
grep -qF 'Does not write to `design/` or file into `.ok-planner/issues/`' "$family/skills/sketch/SKILL.md" \
  && ok "sketch-an-idea: the verb states the prohibition the fixture exhibits" \
  || bad "sketch-an-idea: the verb no longer prohibits writing the corpus or the intake"

# --- session-awareness + see-governing-versions ------------------------------
# A real converged project, then the same project deliberately left
# behind the carried version.
conv="$tmp/converged"
mkdir -p "$conv"
(cd "$conv" && git init -q . && git -c user.email=p@e.c -c user.name=p commit -q --allow-empty -m init)
mkdir -p "$conv/.ok-planner/design"
printf "# Concepts\n\n- [thing](concepts/thing.md) — a thing.\n" > "$conv/.ok-planner/design/concepts.md"
(cd "$conv" && bash "$planner_core" >/dev/null 2>&1)

hook="$conv/.ok-planner/hooks/session-start"
[ -x "$hook" ] && ok "session-awareness: the session hook is materialized into the estate and executable" \
  || bad "session-awareness: no materialized session hook"
out=$(bash "$hook" 2>/dev/null); rc=$?
[ "$rc" -eq 0 ] && ok "session-awareness: the hook runs clean" || bad "session-awareness: the hook exited $rc"
printf '%s' "$out" | grep -q "\"hookEventName\": \"SessionStart\"" \
  && ok "session-awareness: it emits a SessionStart context payload" \
  || bad "session-awareness: no SessionStart payload"
printf '%s' "$out" | grep -q "ok-planner v${suite_version} is materialized in this project" \
  && ok "session-awareness: the banner names the governing version (v${suite_version})" \
  || bad "session-awareness: the banner does not name the governing version"
printf '%s' "$out" | grep -q "do not paraphrase from prior context" \
  && ok "session-awareness: the concept TOC is injected with its read-before-you-define framing" \
  || bad "session-awareness: the concept catalog framing is missing"
printf '%s' "$out" | grep -q "\[thing\](concepts/thing.md)" \
  && ok "session-awareness: the injected TOC is this project's own catalog" \
  || bad "session-awareness: the injected TOC is not the project's catalog"
printf '%s' "$out" | grep -qi "each activated only by its explicit slash command\." \
  && bad "session-awareness: the payload still claims every vendored skill carries the guard" \
  || ok "session-awareness: the payload does not overclaim the activation guard over the plumbing class"

# The unintegrated case: no estate, so neither the hook nor the wiring
# exists and nothing is injected.
unint="$tmp/unintegrated"
mkdir -p "$unint"
(cd "$unint" && git init -q . && git -c user.email=p@e.c -c user.name=p commit -q --allow-empty -m init)
if [ ! -e "$unint/.ok-planner" ] && [ ! -e "$unint/.claude/settings.json" ]; then
  ok "session-awareness: an unintegrated project has neither hook nor wiring — nothing is injected"
else
  bad "session-awareness: an unintegrated project was disturbed"
fi

# see-governing-versions: a project deliberately behind the carried plugin.
behind="$conv/.ok-planner/hooks/session-start"
sed "s/ok-planner v${suite_version} is materialized/ok-planner v9.0.0-behind is materialized/" "$behind" > "$behind.tmp" && mv "$behind.tmp" "$behind"
chmod +x "$behind"
governing=$(bash "$behind" 2>/dev/null | sed -n 's/.*ok-planner v\([0-9A-Za-z.\-]*\) is materialized.*/\1/p' | head -1)
[ "$governing" = "9.0.0-behind" ] \
  && ok "see-governing-versions: the governing number is read from what this project was converged to ($governing)" \
  || bad "see-governing-versions: the governing number did not come from the project's own stamp (got ${governing:-none})"
[ "$governing" != "$suite_version" ] \
  && ok "see-governing-versions: it disagrees with the carried plugin (v${suite_version}) — the gap is the convergence signal" \
  || bad "see-governing-versions: the two numbers do not disagree on a deliberately-behind project"
grep -qF 'find the line that begins `Conduct version:`' "$family/skills/ok-version/SKILL.md" \
  && ok "see-governing-versions: the conduct number is read from the style actually loaded, not from what is installed" \
  || bad "see-governing-versions: the verb no longer reads the conduct number from the active output style"
# On this project, the governing number and the stamped artifact agree.
this_stamp=$(sed -n 's/.*ok-planner v\([0-9A-Za-z.\-]*\) is materialized.*/\1/p' \
  "$suite_repo/.ok-planner/hooks/session-start" 2>/dev/null | head -1)
[ -n "$this_stamp" ] && [ "$this_stamp" = "$suite_version" ] \
  && ok "see-governing-versions: this project's stamped artifact matches the carried manifest (v$this_stamp)" \
  || bad "see-governing-versions: this project's stamp (${this_stamp:-none}) does not match the manifest (v${suite_version})"

# --- deterministic-source-graph: build twice, edit one unit, corrupt ---------
source_graph="$family/scripts/source-graph"
sg="$tmp/source-graph-fixture"
mkdir -p "$sg/src" "$sg/docs"
cat > "$sg/src/app.js" <<'EOF'
const util = require('./util.js');

function main(argv) {
  return util.go(argv.length);
}

function side(x) {
  return x - 1;
}
EOF
cat > "$sg/src/util.js" <<'EOF'
function go(n) { return n * 2; }
module.exports = { go };
EOF
printf '# Guide\n\nSee src/app.js.\n\n## Setup\n\nSteps.\n' > "$sg/docs/readme.md"

python3 "$source_graph" build "$sg" >/dev/null 2>&1 \
  && ok "deterministic-source-graph: the extractor builds the committed graph from the fixture tree" \
  || bad "deterministic-source-graph: build failed"
first=$(cd "$sg/.ok-planner/graph" && find . -name '*.graph' | sort | xargs cat | shasum)
python3 "$source_graph" build "$sg" >/dev/null 2>&1
second=$(cd "$sg/.ok-planner/graph" && find . -name '*.graph' | sort | xargs cat | shasum)
[ "$first" = "$second" ] \
  && ok "deterministic-source-graph: two builds on an unchanged tree byte-compare identical" \
  || bad "deterministic-source-graph: repeated builds differ on an identical tree"
python3 "$source_graph" check "$sg" >/dev/null 2>&1 \
  && ok "deterministic-source-graph: the checker is clean on a freshly built graph" \
  || bad "deterministic-source-graph: the checker flags a fresh graph"

# Edit inside one declared unit: exactly that node's hash moves.
before_app=$(cat "$sg/.ok-planner/graph/src/app.js.graph")
before_util=$(cat "$sg/.ok-planner/graph/src/util.js.graph")
sed_i() { sed "$1" "$2" > "$2.tmp" && mv "$2.tmp" "$2"; }
sed_i 's/return x - 1;/return x - 2;/' "$sg/src/app.js"
python3 "$source_graph" check "$sg" >/dev/null 2>&1
[ $? -eq 2 ] \
  && ok "deterministic-source-graph: the checker reports drift after an in-unit edit and exits non-zero" \
  || bad "deterministic-source-graph: a stale committed graph passed the checker silently"
python3 "$source_graph" build "$sg" >/dev/null 2>&1
after_app=$(cat "$sg/.ok-planner/graph/src/app.js.graph")
after_util=$(cat "$sg/.ok-planner/graph/src/util.js.graph")
moved=$(diff <(echo "$before_app") <(echo "$after_app") | grep -c '^[<>] node' || true)
side_moved=$(diff <(echo "$before_app") <(echo "$after_app") | grep -c '^[<>] node src/app.js#side' || true)
if [ "$side_moved" -eq 2 ] && [ "$moved" -eq 2 ]; then
  ok "deterministic-source-graph: the edited unit's hash moved and no other node's did"
else
  bad "deterministic-source-graph: hash movement was not confined to the edited unit ($moved node lines changed)"
fi
[ "$before_util" = "$after_util" ] \
  && ok "deterministic-source-graph: an unrelated file's recorded hashes are untouched" \
  || bad "deterministic-source-graph: the edit moved hashes in an unrelated file"

# Corrupt the committed graph: the checker exits non-zero.
echo "corrupt" >> "$sg/.ok-planner/graph/src/util.js.graph"
python3 "$source_graph" check "$sg" >/dev/null 2>&1
[ $? -eq 2 ] \
  && ok "deterministic-source-graph: a corrupted committed graph makes the checker exit non-zero" \
  || bad "deterministic-source-graph: a corrupted graph passed the checker"

# A declared unit's span must survive text the language does not read as
# code: a shell heredoc body carrying a stray closing brace would end the
# enclosing function early under naive brace counting, and an edit after
# the heredoc — still inside the function — would then move no hash at
# all, falsifying the story. The seeded bodies are deliberately
# *unbalanced* — a lone `}` in the first, a lone `{` in the second — so
# that per-line net brace counting cannot cancel them out: drop the
# heredoc blanking and the first body closes `emit` early, the second
# reopens the depth so the neighbouring function is unharmed, and the
# post-heredoc edit lands outside the recorded span. Both heredoc forms
# are exercised: the quoted `<<'EOF'` and the tab-stripping `<<-END`.
sgh="$tmp/source-graph-heredoc"
mkdir -p "$sgh"
cat > "$sgh/tool.sh" <<'SHFIXTURE'
#!/usr/bin/env bash

emit() {
  cat <<'EOF'
a lone } closing brace, unbalanced, inside heredoc prose
EOF
	cat <<-END
	{ a lone opening brace in an indented heredoc body
	END
  echo "after the heredoc, still inside emit"
}

other() {
  echo "untouched"
}
SHFIXTURE
python3 "$source_graph" build "$sgh" >/dev/null 2>&1
hd_graph="$sgh/.ok-planner/graph/tool.sh.graph"
before_emit=$(grep -c '^node tool.sh#emit ' "$hd_graph" || true)
before_other=$(grep '^node tool.sh#other ' "$hd_graph" || true)
before_emit_line=$(grep '^node tool.sh#emit ' "$hd_graph" || true)
[ "$before_emit" -eq 1 ] && [ -n "$before_other" ] \
  && ok "deterministic-source-graph: a heredoc body's braces do not split or swallow the enclosing shell function" \
  || bad "deterministic-source-graph: heredoc braces corrupted the shell function nodes"
sed_i 's/after the heredoc, still inside emit/after the heredoc, edited/' "$sgh/tool.sh"
python3 "$source_graph" build "$sgh" >/dev/null 2>&1
after_emit_line=$(grep '^node tool.sh#emit ' "$hd_graph" || true)
after_other=$(grep '^node tool.sh#other ' "$hd_graph" || true)
[ -n "$after_emit_line" ] && [ "$before_emit_line" != "$after_emit_line" ] \
  && ok "deterministic-source-graph: an edit after a heredoc but inside the function moves that node's hash" \
  || bad "deterministic-source-graph: an edit past a heredoc left the enclosing function's hash standing still"
[ "$before_other" = "$after_other" ] \
  && ok "deterministic-source-graph: the neighbouring shell function's hash is untouched" \
  || bad "deterministic-source-graph: the heredoc edit moved an unrelated function's hash"

# "Identical trees yield byte-identical graphs" is a claim about the
# *committed* tree, so what a contributor leaves lying around must not
# reach the graph: a gitignored file is machine- or session-local —
# personal settings, editor state, a runtime lock — and graphing one
# makes two checkouts of the same commit disagree, which is precisely
# this story's falsifier. The walk therefore sources its file list from
# git wherever the root is a git working tree. Both halves are asserted:
# a walk that merely dropped such files by name would silently stop
# graphing whole projects that do not use git.
sgi="$tmp/source-graph-gitignore"
mkdir -p "$sgi/src"
printf 'function keep(x) { return x + 1; }\n' > "$sgi/src/keep.js"
printf 'function local_only(x) { return x; }\n' > "$sgi/src/settings.local.js"
printf 'src/settings.local.js\n' > "$sgi/.gitignore"
(cd "$sgi" && git init -q . && git add -A \
  && git -c user.email=p@e.c -c user.name=p commit -qm fixture) >/dev/null 2>&1
python3 "$source_graph" build "$sgi" >/dev/null 2>&1
if [ -f "$sgi/.ok-planner/graph/src/keep.js.graph" ] \
   && [ ! -f "$sgi/.ok-planner/graph/src/settings.local.js.graph" ]; then
  ok "deterministic-source-graph: a gitignored local file stays out of the graph while its tracked neighbour is graphed"
else
  bad "deterministic-source-graph: the walk graphed a gitignored file (or lost a tracked one), so a contributor's local files move the graph"
fi
python3 "$source_graph" check "$sgi" >/dev/null 2>&1 \
  && ok "deterministic-source-graph: the checker is clean on a git tree whose ignored files are absent from the graph" \
  || bad "deterministic-source-graph: the checker flags the graph it just built over a git tree"
rm -rf "$sgi/.git" "$sgi/.ok-planner"
python3 "$source_graph" build "$sgi" >/dev/null 2>&1
[ -f "$sgi/.ok-planner/graph/src/settings.local.js.graph" ] \
  && ok "deterministic-source-graph: with no git present the fallback walk still graphs every file" \
  || bad "deterministic-source-graph: the fallback walk lost files in a project without git"

# --- corpus-audit: the pure in-context reporter ------------------------------
# The seeded-corpus run is agentic (four subagent passes reading a
# planted compliance violation, an uncovered claim, and a cross-artifact
# contradiction back to the caller, tree — intake included — unchanged);
# that demo is prompt-realized in skills/audit/SKILL.md, step 7's report
# contract. What is checkable — and what a regression would silently
# drop — is that the verb a project actually runs still promises exactly
# that: four real passes, every finding classified, nothing written.
audit_copy_check() {
  local copy=$1 label=$2
  if [ ! -f "$copy" ]; then
    bad "corpus-audit: $label missing at $copy"
    return
  fi
  if grep -qF "Pass 1 — compliance" "$copy" \
     && grep -qF "Pass 2 — coverage" "$copy" \
     && grep -qF "Pass 3 — cross-artifact consistency" "$copy" \
     && grep -qF "Pass 4 — surface inventory" "$copy"; then
    ok "corpus-audit: $label — the check behind the findings is real (all four passes present)"
  else
    bad "corpus-audit: $label — the check behind the findings has lost a pass"
  fi
  if grep -qF "advisory mechanical/judgment class" "$copy" \
     && grep -qF 'classifies every finding `mechanical` or `judgment`' "$copy"; then
    ok "corpus-audit: $label — the report contract classifies every finding mechanical or judgment"
  else
    bad "corpus-audit: $label — the report contract lost the mechanical/judgment classification"
  fi
  if grep -qF "returns everything in-context, and writes nothing" "$copy" \
     && grep -qF "Create nothing." "$copy" \
     && grep -qF "Does not touch the issue intake — no filing, no editing, no closing." "$copy" \
     && grep -qF "Does not execute proofs" "$copy"; then
    ok "corpus-audit: $label — the read-only stance stands verbatim: in-context report, no intake writes, no proof execution"
  else
    bad "corpus-audit: $label — the read-only stance has drifted"
  fi
}
audit_copy_check "$family/skills/audit/SKILL.md" "the family source"
audit_copy_check "$suite_repo/.claude/skills/ok-planner-audit/SKILL.md" "the vendored verb this project runs"

# One conjunct beyond presence: each pass dispatches an assembled prompt,
# and a dispatch is only real if every block it transcludes exists. Every
# {{TOKEN}} the verb uses is resolved here against the shared directory —
# a pass pointing at a block nobody defines is a stub with a subagent
# around it, and this is what catches it.
token_report=$(python3 - "$family/skills/audit/SKILL.md" "$family/skills/_shared" <<'PY'
import glob, os, re, sys
skill, shared = sys.argv[1], sys.argv[2]
defined = {}
for path in sorted(glob.glob(os.path.join(shared, "*.md"))):
    for m in re.finditer(r"(?m)^###\s+\{\{([A-Z][A-Z0-9-]*)\}\}\s*$", open(path).read()):
        defined.setdefault(m.group(1), []).append(os.path.basename(path))
used = set()
for line in open(skill).read().split("\n"):
    if re.match(r"^###\s+\{\{", line):
        continue
    used.update(re.findall(r"\{\{([A-Z][A-Z0-9-]*)\}\}", line))
bad = ["%s -> %d headings" % (t, len(defined.get(t, []))) for t in sorted(used)
       if len(defined.get(t, [])) != 1]
print(("BAD " + ", ".join(bad)) if bad else
      ("EMPTY" if not used else "OK %d tokens" % len(used)))
PY
)
case "$token_report" in
  OK*)  ok "corpus-audit: every block the four passes transclude resolves to exactly one canonical heading (${token_report#OK })" ;;
  BAD*) bad "corpus-audit: a dispatched pass transcludes a block that resolves to no single canonical heading — ${token_report#BAD }" ;;
  *)    bad "corpus-audit: the verb transcludes nothing — its passes no longer assemble canonical prompts" ;;
esac

exit $fail
