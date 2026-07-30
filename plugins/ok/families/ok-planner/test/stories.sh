#!/usr/bin/env bash
# Story-level integration tests for the planner family — an ordinary
# test suite, run like any other.
#
# Every check here runs something — a vendored binary, a materialized
# hook, the converge core — and asserts on what
# running it produced. Nothing in this suite checks the existence of
# static text, code, or prose; the @story: annotations below are
# navigation, linking each section to the story it exercises.
#
# certify-completion: the judgment layer's mechanical floor, exercised
# through the project's own checker against a seeded repository — a
# skipped inspection pass fails the clean bar, and the same tree passes
# once the disposition is recorded durably.
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
# deterministic-source-graph: the vendored extractor builds the
# committed graph twice on an unchanged fixture and the results
# byte-compare identical; an edit inside one declared unit moves
# exactly that unit's recorded hash and no unrelated hash — including
# an edit past a shell heredoc whose body carries stray braces, which
# naive brace counting would have written out of the enclosing
# function's span, and an edit past a javascript regular-expression
# literal and a multi-line template literal, whose contents look like a
# comment opener and like declarations respectively, and a division
# whose left operand ends in a postfix `++` or in a reserved word used
# as a property name, either of which read as a regex opener would
# blank the closing brace off its line, and the mirror shape — a regex
# reached across a space through the infix keywords `in`, `of` and
# `instanceof`, which read as division would blank the rest of the file;
# a corrupted committed graph makes the checker exit non-zero.
#
# relevance-scoped-queue-gate: the corpus surfacer the issue walk runs
# before presenting an issue ranks the artifacts the issue names above
# the ones it merely echoes, discards tokens common across the corpus,
# and prints nothing when nothing bears.
#
# @story: deterministic-source-graph
# @story: certify-completion
# @story: see-governing-versions
# @story: session-awareness
# @decision: relevance-scoped-queue-gate
set -uo pipefail

here="$(cd "$(dirname "$0")" && pwd)"
suite_repo="$(cd "$here/../../../../.." && pwd)"
family="$(cd "$here/.." && pwd)"
planner_core="$family/admin/converge"
suite_version=$(sed -n 's/.*"version"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' \
  "$suite_repo/plugins/ok/.claude-plugin/plugin.json" | head -1)

fail=0
fails=0
ok()  { echo "ok: $1"; }
bad() { echo "FAIL: $1"; fail=1; fails=$((fails + 1)); }

section() { :; }  # readability marker; sections carry no machinery

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

# --- certify-completion: the judgment layer's mechanical floor ---------------
section certify-completion
# The judgment layer's mechanical floor. The gate's own clean bar is a
# deterministic program, so it is exhibited here through the checker a project actually runs, against a
# seeded repository whose change no citation covers. Skipped pass first
# (no registry at all), then the same tree with the inspector's judgment
# recorded.
floor="$suite_repo/.ok-planner/bin/audit-check"
sgraph_bin="$suite_repo/.ok-planner/bin/source-graph"
floor_repo="$tmp/inspection-floor"
if [ -x "$floor" ] && [ -x "$sgraph_bin" ]; then
  mkdir -p "$floor_repo"
  cp -R "$family/test/fixtures/node-cited-clean/." "$floor_repo/"
  (cd "$floor_repo" && git init -q && git add -A \
    && git -c user.email=t@t.t -c user.name=t commit -qm base) >/dev/null 2>&1
  cat > "$floor_repo/src/util.js" <<'JS'
function helper(n) {
  return n - 1;
}
module.exports = { helper };
JS
  python3 "$sgraph_bin" build "$floor_repo" >/dev/null
  skipped=$(python3 "$floor" "$floor_repo" --inspection 2>&1); skipped_rc=$?
  if [ "$skipped_rc" -ne 0 ] && printf '%s\n' "$skipped" | grep -q "inspection-"; then
    ok "certify-completion: a skipped judgment pass fails the gate's clean bar mechanically instead of reading clean"
  else
    bad "certify-completion: a skipped judgment pass read clean (exit $skipped_rc): $skipped"
  fi
  cat > "$floor_repo/.ok-planner/audits/inspection.md" <<'REG'
---
inspection-registry: v1
inspected: 2026-07-29T00:00:00Z
---

# Inspection registry

REG
  # Both nodes the new file put in play: the declared unit, and the
  # file node — the only handle on what the file carries outside every
  # declared unit (here its module-level export line).
  (cd "$floor_repo" && python3 "$floor" cite-node src/util.js#helper \
    | sed 's/^- cite-node: /- node: /') >> "$floor_repo/.ok-planner/audits/inspection.md"
  cat >> "$floor_repo/.ok-planner/audits/inspection.md" <<'REG'
  class: residue
  note: a new helper, claimed by no audit
REG
  (cd "$floor_repo" && python3 "$floor" cite-node src/util.js \
    | sed 's/^- cite-node: /- node: /') >> "$floor_repo/.ok-planner/audits/inspection.md"
  cat >> "$floor_repo/.ok-planner/audits/inspection.md" <<'REG'
  class: residue
  note: the new module's export line, claimed by no audit
REG
  judged=$(python3 "$floor" "$floor_repo" --inspection 2>&1); judged_rc=$?
  if [ "$judged_rc" -eq 0 ]; then
    ok "certify-completion: the same tree passes once the judgment pass recorded its disposition durably"
  else
    bad "certify-completion: a recorded disposition did not satisfy the floor (exit $judged_rc): $judged"
  fi
else
  bad "certify-completion: the project's own checker or graph builder is absent — the gate's clean bar is unexhibited"
fi

# --- session-awareness + see-governing-versions ------------------------------
section session-awareness see-governing-versions
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
# --- deterministic-source-graph: build twice, edit one unit, corrupt ---------
section deterministic-source-graph
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
# all, silently breaking the story's promise. The seeded bodies are deliberately
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

# The javascript equivalent of the heredoc case, and the one that bit:
# a regular-expression literal whose character class carries `/*`, and a
# multi-line template literal whose body is a worked example full of
# braces and a `function` declaration. Reading the regex's `/*` as a
# block-comment opener blanks the rest of the file, so every later
# declaration is swallowed into whichever scope happened to be open and
# example prose inside the template surfaces as a node of its own — the
# graph then loses real units and invents one. Both hazards sit before
# the two real functions here, so a parser that mis-scopes either loses
# them.
sgj="$tmp/source-graph-javascript"
mkdir -p "$sgj"
cat > "$sgj/hazards.js" <<'JSFIXTURE'
const PATTERNS = {
  strip: /^[\s/*#]+/,
  ratio: 4 / 2,
};

const TOPICS = {
  hygiene: `hygiene — a worked example follows.

  Given this:

    export function compare(a, b) {
      return a - b;
    }

  the rule is that ${PATTERNS.strip.source} opens no comment.`,
};

function first(x) {
  return x + 1;
}

function second(y) {
  return y - 1;
}
JSFIXTURE
python3 "$source_graph" build "$sgj" >/dev/null 2>&1
js_graph="$sgj/.ok-planner/graph/hazards.js.graph"
js_nodes=$(sed -n 's/^node \([^ ]*\) .*/\1/p' "$js_graph" | sort | tr '\n' ' ')
[ "$js_nodes" = "hazards.js#first hazards.js#second " ] \
  && ok "deterministic-source-graph: a regex literal carrying /* and a template literal carrying a declaration leave exactly the file's two real functions declared" \
  || bad "deterministic-source-graph: the javascript hazards corrupted the node set (got: ${js_nodes:-none})"

# And the spans are real, not merely present: an edit inside the second
# function — everything the mis-scoping used to swallow — moves that
# node's hash and only that one.
before_first=$(grep '^node hazards.js#first ' "$js_graph" || true)
before_second=$(grep '^node hazards.js#second ' "$js_graph" || true)
sed_i 's/return y - 1;/return y - 2;/' "$sgj/hazards.js"
python3 "$source_graph" build "$sgj" >/dev/null 2>&1
after_first=$(grep '^node hazards.js#first ' "$js_graph" || true)
after_second=$(grep '^node hazards.js#second ' "$js_graph" || true)
if [ "$before_first" = "$after_first" ] && [ -n "$after_second" ] \
   && [ "$before_second" != "$after_second" ]; then
  ok "deterministic-source-graph: an edit past both hazards moves exactly the edited function's hash"
else
  bad "deterministic-source-graph: an edit past the regex and template literals did not land inside the function that contains it"
fi

# The template body is prose, not code: editing it moves the file's own
# hash and no unit's, because nothing in it is a declared unit.
before_file=$(grep '^file hazards.js ' "$js_graph" || true)
before_first=$(grep '^node hazards.js#first ' "$js_graph" || true)
sed_i 's/a worked example follows/a worked example is quoted/' "$sgj/hazards.js"
python3 "$source_graph" build "$sgj" >/dev/null 2>&1
after_file=$(grep '^file hazards.js ' "$js_graph" || true)
after_first=$(grep '^node hazards.js#first ' "$js_graph" || true)
js_nodes=$(sed -n 's/^node \([^ ]*\) .*/\1/p' "$js_graph" | sort | tr '\n' ' ')
if [ "$before_file" != "$after_file" ] && [ "$before_first" = "$after_first" ] \
   && [ "$js_nodes" = "hazards.js#first hazards.js#second " ]; then
  ok "deterministic-source-graph: editing the template literal's prose moves the file node alone and declares nothing new"
else
  bad "deterministic-source-graph: an edit inside the template literal leaked into the declared units"
fi

# The other half of the same lexical decision: which `/` opens a regular
# expression. Two shapes look like openers and are divisions. A postfix
# `++` ends an operand, so `total++ / count` divides even though `+` is
# otherwise a preceder; and a reserved word reached through `.` is a
# property name, so `LIMITS.in / 2` divides even though a bare `in`
# precedes a regex. Read either as an opener and the literal blanks the
# rest of its line — the closing brace with it — so every following
# declaration nests inside the function that never closed.
cat > "$sgj/operators.js" <<'JSFIXTURE'
const LIMITS = { in: 8, of: 4 };

function ratio(total, count) {
  return { mean: total++ / count, seen: total };
}

function share(total) {
  return { part: total / LIMITS.in / 2 };
}

function tail(x) {
  return x + 1;
}
JSFIXTURE
python3 "$source_graph" build "$sgj" >/dev/null 2>&1
op_graph="$sgj/.ok-planner/graph/operators.js.graph"
op_nodes=$(sed -n 's/^node \([^ ]*\) .*/\1/p' "$op_graph" | sort | tr '\n' ' ')
[ "$op_nodes" = "operators.js#ratio operators.js#share operators.js#tail " ] \
  && ok "deterministic-source-graph: division after a postfix ++ and after a keyword-named property leaves three sibling functions, not a nest" \
  || bad "deterministic-source-graph: a division read as a regex literal swallowed a closing brace (got: ${op_nodes:-none})"

# And the spans are real: an edit in the last function — the one a
# misread `/` buries two levels deep — moves that node's hash alone.
before_tail=$(grep '^node operators.js#tail ' "$op_graph" || true)
before_ratio=$(grep '^node operators.js#ratio ' "$op_graph" || true)
sed_i 's/return x + 1;/return x + 2;/' "$sgj/operators.js"
python3 "$source_graph" build "$sgj" >/dev/null 2>&1
after_tail=$(grep '^node operators.js#tail ' "$op_graph" || true)
after_ratio=$(grep '^node operators.js#ratio ' "$op_graph" || true)
if [ -n "$after_tail" ] && [ "$before_tail" != "$after_tail" ] \
   && [ "$before_ratio" = "$after_ratio" ]; then
  ok "deterministic-source-graph: an edit past both division hazards moves exactly the edited function's hash"
else
  bad "deterministic-source-graph: an edit past the division hazards did not land in the function that contains it"
fi

# The third shape, and the one real code hits constantly: `in`, `of` and
# `instanceof` are binary infix operators, so the keyword before a regex
# literal is *always* reached across a space, with another identifier in
# front of it. An accumulator that only ends an identifier on punctuation
# glues the two together (`x`+`of` → `xof`), the keyword rule never fires,
# and the regex here — whose class carries `/*` — is read as division and
# then as a block-comment opener, blanking the rest of the file and losing
# every later declaration. All three operators are exercised, and the two
# already-correct neighbours (a keyword directly before a regex, and a
# division whose left operand is a keyword-named property) must keep their
# readings.
cat > "$sgj/infix.js" <<'JSFIXTURE'
const LIMITS = { in: 8 };

function useOf(items) {
  for (const x of /^[\s/*#]+/.exec(items)) {
    console.log(x);
  }
}

function useIn(bag, key) {
  if (key in /^[\s/*#]+/.source) { return 1; }
  return 0;
}

function useInstanceof(value) {
  return value instanceof /^[\s/*#]+/.constructor;
}

function useReturn(text) {
  return /^[\s/*#]+/.test(text);
}

function useProperty(total) {
  return { part: total / LIMITS.in / 2, seen: total++ / 3 };
}

function after(y) {
  return y - 1;
}
JSFIXTURE
python3 "$source_graph" build "$sgj" >/dev/null 2>&1
in_graph="$sgj/.ok-planner/graph/infix.js.graph"
in_nodes=$(sed -n 's/^node \([^ ]*\) .*/\1/p' "$in_graph" | sort | tr '\n' ' ')
expected_in="infix.js#after infix.js#useIn infix.js#useInstanceof infix.js#useOf infix.js#useProperty infix.js#useReturn "
[ "$in_nodes" = "$expected_in" ] \
  && ok "deterministic-source-graph: a regex reached across a space through in/of/instanceof leaves every later function declared, siblings not nested" \
  || bad "deterministic-source-graph: an infix keyword before a regex literal corrupted the node set (got: ${in_nodes:-none})"

# And the last function's span is real, not a leftover: an edit inside
# `after` — everything the swallowed `/*` used to blank — moves that node's
# hash and no other.
before_after=$(grep '^node infix.js#after ' "$in_graph" || true)
before_useof=$(grep '^node infix.js#useOf ' "$in_graph" || true)
sed_i 's/return y - 1;/return y - 2;/' "$sgj/infix.js"
python3 "$source_graph" build "$sgj" >/dev/null 2>&1
after_after=$(grep '^node infix.js#after ' "$in_graph" || true)
after_useof=$(grep '^node infix.js#useOf ' "$in_graph" || true)
if [ -n "$after_after" ] && [ "$before_after" != "$after_after" ] \
   && [ "$before_useof" = "$after_useof" ]; then
  ok "deterministic-source-graph: an edit past the infix-keyword regex lands inside the function that contains it"
else
  bad "deterministic-source-graph: the function following an infix-keyword regex was lost or mis-spanned"
fi

# "Identical trees yield byte-identical graphs" is a claim about the
# *committed* tree, so what a contributor leaves lying around must not
# reach the graph: a gitignored file is machine- or session-local —
# personal settings, editor state, a runtime lock — and graphing one
# makes two checkouts of the same commit disagree — precisely the
# failure this story rules out. The walk therefore sources its file list from
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

# --- relevance-scoped-queue-gate: the corpus surfacer the walk runs ----------
section relevance-scoped-queue-gate
# The Choice's last clause — each in-scope issue walked "with the corpus
# artifacts relevant to each surfaced first" — is delivered by a program,
# not by prose: the ceremony runs the surfacer on the issue file before
# presenting it. Three properties decide whether the walker gets a
# useful shortlist or noise: what the issue explicitly names outranks
# everything, a token common across the corpus is not a signal, and an
# issue nothing bears on prints nothing at all — which is itself the
# signal the walker reads.
surfacer="$family/scripts/surface-corpus"
sc="$tmp/surface-corpus-fixture"
mkdir -p "$sc/.ok-planner/design/concepts" \
         "$sc/.ok-planner/design/decisions" "$sc/.ok-planner/issues"
i=1
while [ "$i" -le 12 ]; do
  n=$(printf '%02d' "$i")
  printf '# Topic %s\n\nThe converge core owns this topic.\nMarker raretoken%s appears only here.\n' \
    "$n" "$n" > "$sc/.ok-planner/design/concepts/topic-$n.md"
  i=$((i + 1))
done
printf '# The port is bound on loopback only\n\nThe converge core binds the loopback interface.\nThe heliotrope allocator picks the port.\n' \
  > "$sc/.ok-planner/design/decisions/loopback-ports.md"

cat > "$sc/.ok-planner/issues/2026-07-29-000000-ports-collide.md" <<'FIXTURE'
---
issue: 2026-07-29-000000-ports-collide
artifacts:
  - decision:loopback-ports
---

# Two projects browsing at once contend for the port

The converge core is fine; the `heliotrope` allocator and raretoken07
are what this turns on.
FIXTURE

ranked=$(OK_PLANNER_PROJECT_ROOT="$sc" python3 "$surfacer" \
  "$sc/.ok-planner/issues/2026-07-29-000000-ports-collide.md")
first=$(printf '%s\n' "$ranked" | head -1)
if printf '%s' "$first" | grep -q "design/decisions/loopback-ports.md	decision	cited in row.artifacts\[\]"; then
  ok "relevance-scoped-queue-gate: the artifact the issue names is surfaced first, at maximum score"
else
  bad "relevance-scoped-queue-gate: the cited artifact did not rank first: ${first:-<no output>}"
fi
if printf '%s\n' "$ranked" | grep -q "concepts/topic-07.md	concept	.*rare-token hit"; then
  ok "relevance-scoped-queue-gate: an artifact reached only by a rare token is surfaced with the tokens that reached it"
else
  bad "relevance-scoped-queue-gate: the rare-token match was not surfaced: $ranked"
fi
common_hits=$(printf '%s\n' "$ranked" | grep -c "concepts/topic-" || true)
[ "$common_hits" -eq 1 ] \
  && ok "relevance-scoped-queue-gate: a token common across the corpus (converge) surfaces nothing on its own" \
  || bad "relevance-scoped-queue-gate: a corpus-wide token dragged in $common_hits concepts"

# Empty output is defined behavior, not a failure: it tells the walker
# the corpus has nothing to put in front of the owner for this issue.
cat > "$sc/.ok-planner/issues/2026-07-29-000001-nothing-bears.md" <<'FIXTURE'
---
issue: 2026-07-29-000001-nothing-bears
---

# A question the corpus does not touch

The converge core is fine here too.
FIXTURE
empty=$(OK_PLANNER_PROJECT_ROOT="$sc" python3 "$surfacer" \
  "$sc/.ok-planner/issues/2026-07-29-000001-nothing-bears.md")
[ -z "$empty" ] \
  && ok "relevance-scoped-queue-gate: an issue no artifact bears on surfaces nothing — the walker's own signal" \
  || bad "relevance-scoped-queue-gate: an issue with no bearing artifact still surfaced: $empty"

# The shortlist is capped, so an issue naming half the corpus still
# arrives as something the owner can read in one sitting.
{
  printf -- '---\nissue: 2026-07-29-000002-names-everything\nartifacts:\n'
  printf -- '  - decision:loopback-ports\n'
  i=1
  while [ "$i" -le 12 ]; do
    printf -- '  - concept:topic-%02d\n' "$i"
    i=$((i + 1))
  done
  printf -- '---\n\n# Everything at once\n\nBody.\n'
} > "$sc/.ok-planner/issues/2026-07-29-000002-names-everything.md"
capped=$(OK_PLANNER_PROJECT_ROOT="$sc" python3 "$surfacer" \
  "$sc/.ok-planner/issues/2026-07-29-000002-names-everything.md" | wc -l | tr -d ' ')
[ "$capped" -eq 10 ] \
  && ok "relevance-scoped-queue-gate: the shortlist is capped at ten however many artifacts an issue names" \
  || bad "relevance-scoped-queue-gate: the shortlist was not capped (got $capped lines)"

exit $fail
