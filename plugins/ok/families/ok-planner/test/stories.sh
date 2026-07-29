#!/usr/bin/env bash
# Story-level integration tests for the planner family — an ordinary
# test suite, run like any other.
#
# Every check here runs something — a vendored binary, a materialized
# hook, the converge core, a served HTTP surface — and asserts on what
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
# trace-corpus-to-code: the corpus view, exercised over a fixture project
# carrying both live artifact kinds, through its real HTTP surface: the
# listing carries every live story and decision with the determination
# its audit recorded; opening a story excerpts the code its audit cites;
# following that into the source file shows the same story
# claiming exactly those lines, an unclaimed region beside them, and the
# audit's whole-file pin held as a file-level claim rather than smeared
# over every line; a decision whose audit reaches a file by a plain
# anchor that appears twice claims both occurrences, excerpted on the
# artifact and marked in the code, so the two directions never give
# contradictory answers about one region; a source nothing claims is a
# row of its own; coverage
# is reported over the committed graph once one exists; and a
# deliberately broken citation reads stale in the view exactly as the
# project's own checker reports it — which is the point of the view
# calling that checker instead of reimplementing it. Both of the last
# two are asked of one long-lived server process after the tree moved
# under it, with nothing telling it so: the view reads the tree afresh
# per request, or it would answer from the snapshot it built at start
# and drift away from the checker it exists to agree with.
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
# inspection-registry / recorded-adjudication: the standing residue and
# the recorded adjudications the change inspector wrote are served to
# the project's own corpus view, live-or-lapsed against the committed
# graph the same way the checker judges them.
#
# local-web-surface: the page itself is served — the built bundle at
# `/`, its assets, the single-page fallback, and the containment guard
# that refuses to serve outside the bundle — a project with no build
# gets the no-build page instead of an error, and driving every route
# leaves the working tree byte-for-byte as it was, which is what
# "read-only, nothing left behind" means operationally.
#
# resolution-through-pinned-checker / per-project-pinning: a project
# carrying its own materialized checker resolves citations through that
# copy and says so; a project carrying none falls back to the payload
# and announces the fallback, as does the `browse` verb's own run
# block. Node citations — the form this corpus's pins use — resolve
# through the committed graph and go stale when the unit moves.
#
# built-bundle-fetched-at-pin: a project converged for real is served
# while running under a front door carrying a different build, and the
# bytes at `/` are the ones its own convergence placed; with only the
# placed build taken away the same project serves the carried one and
# says so, so the preference is a live choice between two reachable
# builds rather than one of them being invisible.
#
# relevance-scoped-queue-gate: the corpus surfacer the issue walk runs
# before presenting an issue ranks the artifacts the issue names above
# the ones it merely echoes, discards tokens common across the corpus,
# and prints nothing when nothing bears.
#
# @story: deterministic-source-graph
# @story: trace-corpus-to-code
# @story: certify-completion
# @story: see-governing-versions
# @story: session-awareness
# @decision: inspection-registry
# @decision: recorded-adjudication
# @decision: local-web-surface
# @decision: built-bundle-fetched-at-pin
# @decision: resolution-through-pinned-checker
# @decision: per-project-pinning
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

# --- trace-corpus-to-code: the corpus view, both directions ------------------
section trace-corpus-to-code
view_tmp=$(mktemp -d)
mkdir -p "$view_tmp/.ok-planner/design/stories" \
         "$view_tmp/.ok-planner/design/decisions" \
         "$view_tmp/.ok-planner/audits/stories" \
         "$view_tmp/.ok-planner/audits/decisions" \
         "$view_tmp/.ok-planner/issues" \
         "$view_tmp/src"
(cd "$view_tmp" && git init -q .)

# A fixture project carrying both live artifact kinds: a story whose audit
# cites one source file by span and pins it whole, a decision whose audit
# reaches a second file by a plain anchor that appears on two lines — the
# multi-hit form the checker allows — and a third file nothing in the
# corpus reaches at all.
cat > "$view_tmp/src/served.py" <<'FIXTURE'
def serve(request):
    handler = route(request)
    return handler(request)


def unrelated_helper(x):
    return x + 1
FIXTURE
cat > "$view_tmp/src/reg.py" <<'FIXTURE'
def setup():
    bind_port(7777)
    return True


def teardown():
    release()
    bind_port(7777)
FIXTURE
printf 'def nothing_claims_me():\n    return 0\n' > "$view_tmp/src/orphan.py"

cat > "$view_tmp/.ok-planner/design/stories/see-data.md" <<'FIXTURE'
---
story: see-data
---

# Serve a request

## Story

As a caller, I want my request served, so that I get an answer.
FIXTURE

story_hash=$(python3 -c '
import hashlib, sys
print(hashlib.sha256(open(sys.argv[1],"rb").read()).hexdigest()[:12])' \
  "$view_tmp/.ok-planner/design/stories/see-data.md")
span_hash=$(python3 - "$view_tmp" <<'PY'
import hashlib, os, sys
root = sys.argv[1]
lines = open(os.path.join(root, "src/served.py")).read().splitlines()[0:3]
print(hashlib.sha256(
    "\n".join(" ".join(l.split()) for l in lines).encode()).hexdigest()[:12])
PY
)
file_hash=$(python3 - "$view_tmp" <<'PY'
import hashlib, os, sys
print(hashlib.sha256(
    open(os.path.join(sys.argv[1], "src/served.py"), "rb").read()
).hexdigest()[:12])
PY
)
cat > "$view_tmp/.ok-planner/audits/stories/see-data.md" <<FIXTURE
---
audit: see-data
artifact: story:see-data
determination: satisfied
audited: 2026-07-28T00:00:00Z
artifact-hash: sha256:${story_hash}
---

# Does the code serve a request?

## Claims

Honored.

- cite-span: src/served.py :: "def serve(request):" +3 sha256:${span_hash}
- cite-file: src/served.py @ sha256:${file_hash}
FIXTURE

cat > "$view_tmp/.ok-planner/design/decisions/loopback-ports.md" <<'FIXTURE'
---
decision: loopback-ports
---

# The port is bound on loopback only

## Choice

The service binds 7777 on loopback, never on a routable interface.

## Rationale

A local reader's page is not a network service; binding wider buys
nothing and exposes the corpus.

## Alternatives

- Bind all interfaces — reachable from another machine, at the cost of
  exposing the corpus to it.
FIXTURE

printf '# Ports collide when two projects browse at once\n' \
  > "$view_tmp/.ok-planner/issues/2026-07-28-000000-ports-collide.md"

decision_hash=$(python3 -c '
import hashlib, sys
print(hashlib.sha256(open(sys.argv[1],"rb").read()).hexdigest()[:12])' \
  "$view_tmp/.ok-planner/design/decisions/loopback-ports.md")

cat > "$view_tmp/.ok-planner/audits/decisions/loopback-ports.md" <<FIXTURE
---
audit: loopback-ports
artifact: decision:loopback-ports
determination: violated
issue: 2026-07-28-000000-ports-collide.md
audited: 2026-07-28T00:00:00Z
artifact-hash: sha256:${decision_hash}
---

# Is the port bound on loopback only?

## Claims

The bind is hard-coded, but it happens twice and only one site was
reviewed when the choice was taken.

- cite: src/reg.py :: "bind_port(7777)"
FIXTURE

view_bin="$family/scripts/corpus-view"
view_port=$(python3 -c '
import socket
s = socket.socket(); s.bind(("127.0.0.1", 0)); print(s.getsockname()[1]); s.close()')
# The log lives outside the fixture: the read-only assertion below
# compares the fixture tree byte for byte before and after every route
# is driven, and a log the test itself parks inside it would be the one
# thing moving.
view_log="$tmp/corpus-view.log"
python3 "$view_bin" --root "$view_tmp" --port "$view_port" \
  > "$view_log" 2>&1 &
view_pid=$!
python3 - "$view_port" <<'PY'
import socket, sys, time
for _ in range(100):
    try:
        socket.create_connection(("127.0.0.1", int(sys.argv[1])), 0.2).close()
        break
    except OSError:
        time.sleep(0.05)
PY

fetch() { python3 -c '
import sys, urllib.request
print(urllib.request.urlopen(sys.argv[1]).read().decode())' "$1"; }
# The page half needs the status line and the content type, and needs an
# error response to come back rather than raise, so the guard cases can
# be asserted at all.
probe() {  # probe <url> <body-file> -> "<status> <content-type>"
  python3 - "$1" "$2" <<'PY'
import sys, urllib.error, urllib.request
url, out = sys.argv[1], sys.argv[2]
try:
    r = urllib.request.urlopen(url)
    code, body, ctype = r.getcode(), r.read(), r.headers.get("Content-Type", "")
except urllib.error.HTTPError as e:
    code, body, ctype = e.code, e.read(), e.headers.get("Content-Type", "")
with open(out, "wb") as f:
    f.write(body)
print("%d %s" % (code, ctype))
PY
}
base="http://127.0.0.1:${view_port}"

# The story, opened: the code its audit cites, excerpted in place.
detail=$(fetch "$base/api/artifact/story/see-data")
if printf '%s' "$detail" | python3 -c '
import json, sys
d = json.load(sys.stdin)
g = [x for x in d["groups"] if x["target"] == "src/served.py"][0]
span = [c for c in g["lines"] if c["form"] == "cite-span"][0]
cited = [l["text"] for ex in span["excerpts"] for l in ex["lines"] if l["cited"]]
sys.exit(0 if (span["status"] == "current" and span["start"] == 1
               and span["regions"] == [[1, 3]]
               and "def serve(request):" in cited[0] and len(cited) == 3
               and len(g["file"]) == 1) else 1)'; then
  ok "trace-corpus-to-code: opening a story excerpts the code its audit cites"
else
  bad "trace-corpus-to-code: the story's cited code was not excerpted: $detail"
fi

# Every live story AND decision, each with the determination its audit
# recorded — the listing is the view's front door and both kinds have to
# be in it, or half the corpus is invisible from the start.
arts=$(fetch "$base/api/artifacts")
if printf '%s' "$arts" | python3 -c '
import json, sys
rows = {(a["kind"], a["slug"]): a for a in json.load(sys.stdin)["artifacts"]}
story = rows.get(("story", "see-data"))
decision = rows.get(("decision", "loopback-ports"))
sys.exit(0 if (story and decision
               and story["determination"] == "satisfied"
               and decision["determination"] == "violated"
               and story["has_audit"] and decision["has_audit"]) else 1)'; then
  ok "trace-corpus-to-code: the listing carries every live story and decision with its audit determination"
else
  bad "trace-corpus-to-code: the artifact listing lost a kind or a determination: $arts"
fi

# A multi-hit plain anchor is legal — the checker enforces uniqueness only
# for spans — so every occurrence it reaches is a claimed region, and the
# two directions have to say the same thing about them: the artifact page
# excerpts each occurrence, and the source view marks each. Claiming only
# the first would show code a citation demonstrably reaches as claimed by
# nothing, while the page said all of them were marked.
fetch "$base/api/artifact/decision/loopback-ports" > "$view_tmp/dec.json"
fetch "$base/api/source?path=src/reg.py" > "$view_tmp/reg.json"
if python3 - "$view_tmp/dec.json" "$view_tmp/reg.json" <<'PY'
import json, sys
d = json.load(open(sys.argv[1]))
s = json.load(open(sys.argv[2]))
g = [x for x in d["groups"] if x["target"] == "src/reg.py"][0]
c = [x for x in g["lines"] if x["form"] == "cite"][0]
marked = sorted(l["n"] for l in s["lines"] if l["marks"])
excerpted = sorted(ex["start"] for ex in c["excerpts"])
sys.exit(0 if (c["regions"] == [[2, 2], [8, 8]]
               and "all are marked" in c["detail"]
               and marked == [2, 8] and excerpted == [2, 8]
               and all(m["slug"] == "loopback-ports"
                       for l in s["lines"] for m in l["marks"])) else 1)
PY
then
  ok "trace-corpus-to-code: every occurrence a multi-hit anchor reaches is claimed — excerpted on the artifact and marked in the code"
else
  bad "trace-corpus-to-code: a multi-hit anchor claimed only some of the lines it reaches: $(cat "$view_tmp/dec.json")"
fi

# Following it into the file: the same story claiming that region, a region
# nothing claims beside it, and the whole-file pin kept as a file-level
# claim rather than smeared over every line.
src=$(fetch "$base/api/source?path=src/served.py")
if printf '%s' "$src" | python3 -c '
import json, sys
d = json.load(sys.stdin)
marked = [l for l in d["lines"] if l["marks"]]
unmarked = [l for l in d["lines"] if not l["marks"]]
claimants = {m["artifact"] for l in marked for m in l["marks"]}
pop = d["population"]
sys.exit(0 if (claimants == {"story:see-data"}
               and len(marked) == 3 and len(unmarked) > 0
               and len(pop) == 1 and pop[0]["form"] == "cite-file"
               and len(marked) < len(d["lines"])) else 1)'; then
  ok "trace-corpus-to-code: the file shows the claiming story, an unclaimed region, and the whole-file claim as file-level"
else
  bad "trace-corpus-to-code: the file view conflated or lost a claim: $src"
fi

# The sources nothing claims, reachable as their own view.
srcs=$(fetch "$base/api/sources")
if printf '%s' "$srcs" | python3 -c '
import json, sys
rows = json.load(sys.stdin)["sources"]
by = {r["path"]: r for r in rows}
orphan = by.get("src/orphan.py")
sys.exit(0 if (orphan and not orphan["line_claims"]
               and not orphan["file_claims"]
               and by["src/served.py"]["line_claims"] == 1) else 1)'; then
  ok "trace-corpus-to-code: a source nothing claims is listed as its own row, not left implicit"
else
  bad "trace-corpus-to-code: the uncited source is invisible: $srcs"
fi

# With a committed graph present, the graph is the population — the same
# map the audits cite, so coverage is reported over what the corpus can
# actually reach rather than over whatever happens to be on disk.
(cd "$view_tmp" && python3 "$family/scripts/source-graph" build) >/dev/null 2>&1
# The same long-lived server process, asked again with no hint that
# anything moved: every request is a fresh read of the tree, so a view
# left running cannot go on serving the answer it gave before the graph
# existed.
graphed=$(fetch "$base/api/meta")
if printf '%s' "$graphed" | python3 -c '
import json, sys
sys.exit(0 if json.load(sys.stdin)["population_source"] == "graph" else 1)'; then
  ok "trace-corpus-to-code: coverage is reported over the committed graph once one exists"
else
  bad "trace-corpus-to-code: the committed graph was not used as the population: $graphed"
fi

# --- inspection-registry / recorded-adjudication: residue reaches the reader -
section inspection-registry recorded-adjudication
# Standing residue and recorded adjudications are not the gate's private
# bookkeeping: the decision routes them to the owner's own corpus view,
# so the territory no claim accounts for is visible where the claims
# are. The registry is written here exactly as the change inspector
# writes it — node-keyed, pinned to the committed graph — with one entry
# of each judged class, and the view is asked for it over the same
# long-lived process that has been answering artifact and source
# questions all along.
cat > "$view_tmp/.ok-planner/audits/inspection.md" <<'REG'
---
inspection-registry: v1
inspected: 2026-07-29T00:00:00Z
---

# Inspection registry

REG
(cd "$view_tmp" && python3 "$family/scripts/audit-check" cite-node src/orphan.py \
  | sed 's/^- cite-node: /- node: /') >> "$view_tmp/.ok-planner/audits/inspection.md"
cat >> "$view_tmp/.ok-planner/audits/inspection.md" <<'REG'
  class: residue
  note: an orphan module no claim in the corpus accounts for
REG
(cd "$view_tmp" && python3 "$family/scripts/audit-check" cite-node src/reg.py \
  | sed 's/^- cite-node: /- node: /') >> "$view_tmp/.ok-planner/audits/inspection.md"
cat >> "$view_tmp/.ok-planner/audits/inspection.md" <<'REG'
  class: adjudicated
  audit: decision:loopback-ports
  note: nomination promoted into the loopback-ports citation
REG

insp=$(fetch "$base/api/inspection")
if printf '%s' "$insp" | python3 -c '
import json, sys
d = json.load(sys.stdin)
by = {e["node"]: e for e in d["entries"]}
res = by.get("src/orphan.py")
adj = by.get("src/reg.py")
sys.exit(0 if (d["present"] and not d.get("malformed")
               and d["inspected"] == "2026-07-29T00:00:00Z"
               and res and res["class"] == "residue" and res["live"]
               and "no claim in the corpus accounts for" in res["note"]
               and adj and adj["class"] == "adjudicated" and adj["live"]
               and adj["audit"] == "decision:loopback-ports") else 1)'; then
  ok "inspection-registry: the view serves the standing residue and the recorded adjudications, each live against the committed graph"
else
  bad "inspection-registry: the registry did not reach the corpus view: $insp"
fi

# Precedent semantics, as the reader sees them: an entry stands until
# the code it names moves, and then it lapses — asked of the same
# running process, which re-reads the registry and the graph per
# request rather than answering from the parse it did at start.
printf 'def added_later():\n    return 1\n' >> "$view_tmp/src/orphan.py"
(cd "$view_tmp" && python3 "$family/scripts/source-graph" build) >/dev/null 2>&1
lapsed=$(fetch "$base/api/inspection")
if printf '%s' "$lapsed" | python3 -c '
import json, sys
by = {e["node"]: e for e in json.load(sys.stdin)["entries"]}
sys.exit(0 if (not by["src/orphan.py"]["live"]
               and by["src/reg.py"]["live"]) else 1)'; then
  ok "inspection-registry: an entry whose node moved reads lapsed while its untouched neighbour still stands"
else
  bad "inspection-registry: a lapsed entry was still served as live: $lapsed"
fi

# --- local-web-surface: the page itself, and nothing left behind -------------
section local-web-surface per-project-pinning
# Everything above this point asks the service for data. The choice is a
# *web application*, so the page has to be served too: the built bundle
# at the root, its assets, the single-page fallback for a deep link the
# frontend routes itself, and the containment guard that refuses a path
# escaping the bundle.
probe_dir=$(mktemp -d)
root_status=$(probe "$base/" "$probe_dir/index.html")
asset=$(sed -n 's/.*src="\.\/\(assets\/[^"]*\.js\)".*/\1/p' "$probe_dir/index.html" | head -1)
case "$root_status" in
  "200 text/html"*) root_ok=1 ;;
  *) root_ok=0 ;;
esac
if [ "$root_ok" -eq 1 ] && grep -q '<div id="app">' "$probe_dir/index.html" \
   && [ -n "$asset" ]; then
  ok "local-web-surface: the root serves the built page, not just the data routes ($root_status)"
else
  bad "local-web-surface: the root did not serve the built page ($root_status, asset '${asset:-none}')"
fi

# The bundle the page loads is the compiled `browser/src/` frontend —
# the half that delivers artifact-to-code and code-to-artifact
# navigation — so the asset is fetched and asked whether it carries the
# routes the service exposes.
asset_status=$(probe "$base/$asset" "$probe_dir/app.js")
case "$asset_status" in
  "200 "*javascript*) asset_ok=1 ;;
  *) asset_ok=0 ;;
esac
if [ "$asset_ok" -eq 1 ] \
   && grep -q '/api/artifacts' "$probe_dir/app.js" \
   && grep -q '/api/source' "$probe_dir/app.js" \
   && grep -q '/api/inspection' "$probe_dir/app.js"; then
  ok "local-web-surface: the served bundle is the frontend that drives both directions and the residue panel ($asset_status)"
else
  bad "local-web-surface: the served asset is not the corpus view's frontend ($asset_status)"
fi

# A deep link the frontend routes in the browser is not a file in the
# bundle; serving the page anyway is what makes lateral movement
# survive a reload, and a 404 there would end the navigation the
# surface was chosen for.
deep_status=$(probe "$base/source/src/reg.py" "$probe_dir/deep.html")
if [ "${deep_status%% *}" = "200" ] \
   && cmp -s "$probe_dir/deep.html" "$probe_dir/index.html"; then
  ok "local-web-surface: a deep link the frontend routes itself is answered with the page"
else
  bad "local-web-surface: a routed deep link did not fall back to the page ($deep_status)"
fi

# The service reads the project's own tree, so a path that walks out of
# the bundle must be refused rather than served — the guard is tested
# with an encoded traversal, which is the form that survives the client.
esc_status=$(probe "$base/%2e%2e%2f%2e%2e%2fetc/hosts" "$probe_dir/esc")
if [ "${esc_status%% *}" = "403" ] && grep -q "outside the bundle" "$probe_dir/esc"; then
  ok "local-web-surface: a path escaping the bundle is refused, not served"
else
  bad "local-web-surface: the bundle-containment guard did not fire ($esc_status)"
fi

# The manifest a read-only claim is held to: every path under the
# project with its content hash. The `.git` directory is excluded
# because nothing here runs git, and the strong form of the assertion
# (a manifest taken before the view has served a single request) is
# made on the pinned fixture below — taking it here, after this section
# has already driven a dozen requests, could not tell a write that
# happens once from a tree that was always like that.
tree_manifest() {
  (cd "$1" && find . -path ./.git -prune -o -type f -print | sort \
    | xargs shasum | shasum)
}

# per-project-pinning, the advisory half: this fixture carries no
# vendored checker, so the service is running the front door's carried
# copy — and says so, on its own line, rather than answering as if it
# were the project's own.
if grep -q "note: no vendored audit-check — using the payload's copy; /ok pins one to this project" "$view_log" \
   && grep -q "note: no vendored source-graph — using the payload's copy; /ok pins one to this project" "$view_log"; then
  ok "per-project-pinning: an advisory verb reading the payload's copy announces the fallback verbatim"
else
  bad "per-project-pinning: the payload fallback was not announced: $(cat "$view_log")"
fi
rm -rf "$probe_dir"

section trace-corpus-to-code
# A deliberately broken citation: the view's verdict has to be the
# checker's verdict, because the view calls the checker rather than
# reimplementing it.
python3 - "$view_tmp" <<'PY'
import os, sys
p = os.path.join(sys.argv[1], "src/served.py")
text = open(p).read().replace("handler = route(request)",
                              "handler = route(request, strict=True)")
open(p, "w").write(text)
PY
broken=$(fetch "$base/api/artifact/story/see-data")
checker_says=$(cd "$view_tmp" && python3 "$family/scripts/audit-check" . 2>&1 | \
  grep -c 'audit-stale-citation' || true)
if printf '%s' "$broken" | python3 -c '
import json, sys
d = json.load(sys.stdin)
g = [x for x in d["groups"] if x["target"] == "src/served.py"][0]
span = [c for c in g["lines"] if c["form"] == "cite-span"][0]
sys.exit(0 if span["status"] == "stale" else 1)' && [ "$checker_says" -ge 1 ]; then
  ok "trace-corpus-to-code: a broken citation reads stale in the view exactly as the project's own checker reports it"
else
  bad "trace-corpus-to-code: view and checker disagreed on a broken citation (checker findings: $checker_says): $broken"
fi

kill "$view_pid" 2>/dev/null || true
wait "$view_pid" 2>/dev/null || true
rm -rf "$view_tmp"

# --- resolution-through-pinned-checker: the project's own copy resolves ------
section resolution-through-pinned-checker per-project-pinning local-web-surface
# The fixture above deliberately carries no estate tooling, so the
# service there runs the payload's checker. This one is its opposite: a
# converged-shaped project whose own `.ok-planner/bin/` copies are
# stamped with a version the payload could not be carrying, so which
# copy answered is decidable from the answer rather than assumed. It is
# also a project with no placed build, which is the other half of the
# surface choice: the data routes answer and the page says why.
pin_tmp="$tmp/pinned-estate"
mkdir -p "$pin_tmp/.ok-planner/bin" \
         "$pin_tmp/.ok-planner/design/decisions" \
         "$pin_tmp/.ok-planner/audits/decisions" "$pin_tmp/src"
(cd "$pin_tmp" && git init -q .)
pin_version="0.0.1-pinned"
for s in audit-check source-graph corpus-view; do
  sed "s/{{OK_PLANNER_VERSION}}/$pin_version/g" "$family/scripts/$s" \
    > "$pin_tmp/.ok-planner/bin/$s"
  chmod +x "$pin_tmp/.ok-planner/bin/$s"
done

cat > "$pin_tmp/src/app.js" <<'FIXTURE'
function go(n) {
  return n * 2;
}

function stay(n) {
  return n;
}

module.exports = { go, stay };
FIXTURE

cat > "$pin_tmp/.ok-planner/design/decisions/node-pin.md" <<'FIXTURE'
---
decision: node-pin
---

# Citations pin declared units, not line numbers

## Choice

An audit citing code names the declared unit and the hash the committed
graph recorded for it.

## Rationale

Line numbers move for reasons that have nothing to do with the cited
mechanism; a declared unit's recorded hash moves only when its bytes do.

## Alternatives

- Cite line ranges — cheap to write, void on the next unrelated edit.
FIXTURE

python3 "$pin_tmp/.ok-planner/bin/source-graph" build "$pin_tmp" >/dev/null 2>&1
pin_artifact_hash=$(python3 -c '
import hashlib, sys
print(hashlib.sha256(open(sys.argv[1],"rb").read()).hexdigest()[:12])' \
  "$pin_tmp/.ok-planner/design/decisions/node-pin.md")
pin_cite=$(cd "$pin_tmp" && python3 .ok-planner/bin/audit-check cite-node src/app.js#go)

cat > "$pin_tmp/.ok-planner/audits/decisions/node-pin.md" <<FIXTURE
---
audit: node-pin
artifact: decision:node-pin
determination: satisfied
audited: 2026-07-28T00:00:00Z
artifact-hash: sha256:${pin_artifact_hash}
---

# Does the code pin a declared unit?

## Claims

Honored.

${pin_cite}
FIXTURE

pin_port=$(python3 -c '
import socket
s = socket.socket(); s.bind(("127.0.0.1", 0)); print(s.getsockname()[1]); s.close()')
pin_log="$tmp/pinned-view.log"
# Launched without a subshell wrapper, so `$!` is the server's own pid
# and the kill below reaches it: on bash 3.2 a `( ... ) &` wrapper is a
# real parent process that dies alone, orphaning the server on its port.
# `--root` already scopes the service, so no `cd` is wanted either.
env -u CLAUDE_PLUGIN_ROOT python3 \
  "$pin_tmp/.ok-planner/bin/corpus-view" --root "$pin_tmp" --port "$pin_port" \
  > "$pin_log" 2>&1 &
pin_pid=$!
python3 - "$pin_port" <<'PY'
import socket, sys, time
for _ in range(100):
    try:
        socket.create_connection(("127.0.0.1", int(sys.argv[1])), 0.2).close()
        break
    except OSError:
        time.sleep(0.05)
PY
pin_base="http://127.0.0.1:${pin_port}"
pin_probe=$(mktemp -d)
# Taken before the process has answered a single request, so a write
# that happens on the first request is caught as surely as one that
# happens on every request.
pin_before_tree=$(tree_manifest "$pin_tmp")

if grep -q "citations resolved by the project's own .ok-planner/bin/audit-check" "$pin_log" \
   && grep -q "citations resolved by the project's own .ok-planner/bin/source-graph" "$pin_log" \
   && ! grep -q "using the payload's copy" "$pin_log"; then
  ok "resolution-through-pinned-checker: the service names the project's own materialized checker as the resolver"
else
  bad "resolution-through-pinned-checker: the pinned resolver was not announced: $(cat "$pin_log")"
fi

pin_meta=$(fetch "$pin_base/api/meta")
if printf '%s' "$pin_meta" | python3 -c '
import json, sys
d = json.load(sys.stdin)
r = d["resolution"]
sys.exit(0 if (r["audit_check"]["source"] == "pinned"
               and r["audit_check"]["path"] == ".ok-planner/bin/audit-check"
               and r["source_graph"]["source"] == "pinned"
               and d["estate_version"] == "0.0.1-pinned"
               and d["running_version"] == "0.0.1-pinned"
               and d["version_agrees"] is True
               and d["bundle_source"] == "none") else 1)'; then
  ok "resolution-through-pinned-checker: the reported provenance is the project's copy, at the version the estate is stamped with"
else
  bad "resolution-through-pinned-checker: the service did not resolve through the pinned copy: $pin_meta"
fi

# The fourth citation form — the one this corpus's pins actually use,
# and the only one that goes through the committed graph and the
# declared-unit extractor rather than an anchor search.
pin_detail=$(fetch "$pin_base/api/artifact/decision/node-pin")
if printf '%s' "$pin_detail" | python3 -c '
import json, sys
d = json.load(sys.stdin)
g = [x for x in d["groups"] if x["target"] == "src/app.js"][0]
c = [x for x in g["lines"] if x["form"] == "cite-node"][0]
cited = [l["text"] for ex in c["excerpts"] for l in ex["lines"] if l["cited"]]
sys.exit(0 if (c["status"] == "current" and c["identity"] == "src/app.js#go"
               and c["regions"] == [[1, 3]] and len(cited) == 3
               and "function go(n)" in cited[0]) else 1)'; then
  ok "resolution-through-pinned-checker: a cite-node resolves through the committed graph to the declared unit's own lines"
else
  bad "resolution-through-pinned-checker: the node citation did not resolve: $pin_detail"
fi

# With no build placed, the page is the no-build page rather than an
# error — the data routes above answered from the same process.
pin_root_status=$(probe "$pin_base/" "$pin_probe/index.html")
if [ "${pin_root_status%% *}" = "200" ] \
   && grep -q "No build present" "$pin_probe/index.html" \
   && grep -q "/api/meta" "$pin_probe/index.html" \
   && grep -q "note: no frontend build found" "$pin_log"; then
  ok "local-web-surface: a project with no placed build serves the no-build page and says so, while the data routes still answer"
else
  bad "local-web-surface: the no-build fallback did not fire ($pin_root_status)"
fi

# "A process rather than an artifact — nothing is left behind." Every
# route the view declares is driven against this project, and the tree
# is hashed again against the manifest taken before the first request:
# a view that wrote anywhere — a cache, a lock, a log, a rendered
# page — shows up here as a changed manifest, and there is no other way
# to hold a read-only claim to account.
for route in "/" "/assets/nothing.js" "/api/meta" "/api/artifacts" \
             "/api/artifact/decision/node-pin" \
             "/api/artifact/story/no-such-story" "/api/sources" \
             "/api/source?path=src/app.js" "/api/source?path=nope.js" \
             "/api/inspection" "/api/no-such-route" "/deep/link" \
             "/%2e%2e%2f%2e%2e%2fetc/hosts"; do
  probe "$pin_base$route" "$pin_probe/sweep" >/dev/null
done
pin_after_tree=$(tree_manifest "$pin_tmp")
[ "$pin_before_tree" = "$pin_after_tree" ] \
  && ok "local-web-surface: driving every route leaves the project byte-for-byte as it was — the view is a process, not an artifact" \
  || bad "local-web-surface: serving the view modified the project's tree"

# The node moves: the view's verdict and the project's own checker's
# verdict have to be the same verdict, because the view calls it.
python3 - "$pin_tmp" <<'PY'
import os, sys
p = os.path.join(sys.argv[1], "src/app.js")
text = open(p).read().replace("return n * 2;", "return n * 3;")
open(p, "w").write(text)
PY
python3 "$pin_tmp/.ok-planner/bin/source-graph" build "$pin_tmp" >/dev/null 2>&1
pin_stale=$(fetch "$pin_base/api/artifact/decision/node-pin")
pin_checker=$(cd "$pin_tmp" && python3 .ok-planner/bin/audit-check . 2>&1 | \
  grep -c 'audit-stale-citation' || true)
if printf '%s' "$pin_stale" | python3 -c '
import json, sys
d = json.load(sys.stdin)
g = [x for x in d["groups"] if x["target"] == "src/app.js"][0]
c = [x for x in g["lines"] if x["form"] == "cite-node"][0]
sys.exit(0 if (c["status"] == "stale"
               and "the cited content changed" in c["detail"]) else 1)' \
   && [ "$pin_checker" -ge 1 ]; then
  ok "resolution-through-pinned-checker: a moved node reads stale in the view exactly as the project's own checker reports it (checker findings: $pin_checker)"
else
  bad "resolution-through-pinned-checker: view and pinned checker disagreed on a moved node (checker findings: $pin_checker): $pin_stale"
fi

kill "$pin_pid" 2>/dev/null || true
wait "$pin_pid" 2>/dev/null || true
rm -rf "$pin_probe"

# --- built-bundle-fetched-at-pin: the placed build is the one served ---------
section built-bundle-fetched-at-pin local-web-surface
# The clause the whole placement exists for: the build a project serves
# is the one its last convergence placed. A project is converged for
# real, so its estate holds the build that convergence placed; it is then
# served while running under a front door carrying a *different* build,
# which is the situation the decision is about — a project behind the
# current release must keep reading its own corpus through its own view.
# Serving the carried copy instead is the alternative this decision
# rejects, so the preference is asserted on the bytes that come back
# from `/`, and both ways round: the fallback is shown to be live, so the
# first assertion is a choice between two reachable builds rather than
# one candidate being invisible.
placed="$tmp/placed-build"
mkdir -p "$placed"
(cd "$placed" && git init -q . \
  && git -c user.email=p@e.c -c user.name=p commit -q --allow-empty -m init)
(cd "$placed" && bash "$planner_core") >/dev/null 2>&1
# A front door whose carried build is not this project's: a family-shaped
# payload directory (skills/ and admin/ are what the service recognises
# a carried family by) holding a dist of its own.
other_door="$tmp/other-front-door"
mkdir -p "$other_door/families/ok-planner/skills" \
         "$other_door/families/ok-planner/admin" \
         "$other_door/families/ok-planner/browser/dist"
printf '<!doctype html><title>carried</title>\n<p>CARRIED-BUILD-MARKER</p>\n' \
  > "$other_door/families/ok-planner/browser/dist/index.html"

if [ -f "$placed/.ok-planner/browser/index.html" ] \
   && [ -f "$placed/.ok-planner/browser/.build-stamp" ]; then
  ok "built-bundle-fetched-at-pin: converging the project placed a stamped build in its estate"
else
  bad "built-bundle-fetched-at-pin: converge placed no build, so there is nothing for the view to prefer"
fi

placed_port=$(python3 -c '
import socket
s = socket.socket(); s.bind(("127.0.0.1", 0)); print(s.getsockname()[1]); s.close()')
placed_log="$tmp/placed-view.log"
CLAUDE_PLUGIN_ROOT="$other_door" python3 \
  "$placed/.ok-planner/bin/corpus-view" --root "$placed" --port "$placed_port" \
  > "$placed_log" 2>&1 &
placed_pid=$!
python3 - "$placed_port" <<'PY'
import socket, sys, time
for _ in range(100):
    try:
        socket.create_connection(("127.0.0.1", int(sys.argv[1])), 0.2).close()
        break
    except OSError:
        time.sleep(0.05)
PY
placed_probe=$(mktemp -d)
placed_status=$(probe "http://127.0.0.1:${placed_port}/" "$placed_probe/index.html")
if [ "${placed_status%% *}" = "200" ] \
   && cmp -s "$placed_probe/index.html" "$placed/.ok-planner/browser/index.html" \
   && ! grep -q CARRIED-BUILD-MARKER "$placed_probe/index.html"; then
  ok "built-bundle-fetched-at-pin: the page served is byte-for-byte the build convergence placed, not the front door's carried one"
else
  bad "built-bundle-fetched-at-pin: / did not serve the placed build ($placed_status)"
fi

# And the provenance the view announces agrees with the bytes: the build
# is the project's own, at the version this project was converged to.
placed_meta=$(fetch "http://127.0.0.1:${placed_port}/api/meta")
if printf '%s' "$placed_meta" | python3 -c '
import json, os, sys
d = json.load(sys.stdin)
sys.exit(0 if (d["bundle_source"] == "project"
               and d["bundle"].endswith(os.path.join(".ok-planner", "browser"))
               and "other-front-door" not in d["bundle"]
               and d["bundle_version"] == sys.argv[1]) else 1)' "$suite_version"; then
  ok "built-bundle-fetched-at-pin: the view reports the served build as the project's own, at the version its estate is stamped with"
else
  bad "built-bundle-fetched-at-pin: the served build's reported provenance was not the project's placed one: $placed_meta"
fi
kill "$placed_pid" 2>/dev/null || true
wait "$placed_pid" 2>/dev/null || true

# The reverse: the same project, the same front door, with only the
# placed build taken away. The carried build is reachable and does get
# served — so the preference above was a live choice, and the note names
# the administration as the placer.
mv "$placed/.ok-planner/browser" "$tmp/placed-build-aside"
fallback_port=$(python3 -c '
import socket
s = socket.socket(); s.bind(("127.0.0.1", 0)); print(s.getsockname()[1]); s.close()')
fallback_log="$tmp/fallback-view.log"
CLAUDE_PLUGIN_ROOT="$other_door" python3 \
  "$placed/.ok-planner/bin/corpus-view" --root "$placed" --port "$fallback_port" \
  > "$fallback_log" 2>&1 &
fallback_pid=$!
python3 - "$fallback_port" <<'PY'
import socket, sys, time
for _ in range(100):
    try:
        socket.create_connection(("127.0.0.1", int(sys.argv[1])), 0.2).close()
        break
    except OSError:
        time.sleep(0.05)
PY
fallback_status=$(probe "http://127.0.0.1:${fallback_port}/" "$placed_probe/fallback.html")
if [ "${fallback_status%% *}" = "200" ] \
   && grep -q CARRIED-BUILD-MARKER "$placed_probe/fallback.html" \
   && grep -q "no build in this project's estate — serving the payload's copy" "$fallback_log"; then
  ok "built-bundle-fetched-at-pin: with the placed build removed the same project serves the carried one and announces the fallback"
else
  bad "built-bundle-fetched-at-pin: the carried build was not reachable, so the preference test had only one candidate ($fallback_status): $(cat "$fallback_log")"
fi
kill "$fallback_pid" 2>/dev/null || true
wait "$fallback_pid" 2>/dev/null || true
rm -rf "$placed_probe"

# --- per-project-pinning: the advisory verb's own run block ------------------
section per-project-pinning
# The decision's exception is not a licence to answer silently: a
# read-only advisory verb that reaches for the front door's carried copy
# has to say so. The `browse` verb's `## Run` block is executed here
# exactly as the skill declares it, in a project that carries no
# vendored binary, and the announcement it is required to make is
# asserted on the block's own output.
browse_block=$(awk '/^```bash$/{c=1; next} c && /^```$/{exit} c' \
  "$family/skills/browse/SKILL.md")
unpinned="$tmp/unpinned-browse"
mkdir -p "$unpinned"
(cd "$unpinned" && git init -q .)
browse_port=$(python3 -c '
import socket
s = socket.socket(); s.bind(("127.0.0.1", 0)); print(s.getsockname()[1]); s.close()')
browse_err="$tmp/browse.err"
browse_out=$(cd "$unpinned" && CLAUDE_PLUGIN_ROOT="$suite_repo/plugins/ok" \
  bash -s "$browse_port" <<<"$browse_block" 2>"$browse_err")
browse_pid=$(printf '%s' "$browse_out" | sed -n 's/.*corpus view: pid \([0-9]*\).*/\1/p' | head -1)
if grep -q "note: no vendored binary — using the payload's copy; /ok pins one to this project" "$browse_err" \
   && printf '%s' "$browse_out" | grep -q "corpus view: serving http://127.0.0.1:${browse_port}/"; then
  ok "per-project-pinning: the browse verb run for real falls back to the payload copy and announces the fallback"
else
  bad "per-project-pinning: the advisory fallback was not announced by the run block: $(cat "$browse_err")"
fi
[ -n "$browse_pid" ] && kill "$browse_pid" 2>/dev/null
[ ! -e "$unpinned/.ok-planner" ] \
  && ok "per-project-pinning: the advisory verb wrote nothing into the project it read" \
  || bad "per-project-pinning: the advisory verb materialized into the project"

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
