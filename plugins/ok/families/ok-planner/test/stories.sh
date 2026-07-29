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
# function's span; a corrupted committed graph makes the checker exit
# non-zero.
#
# @story: deterministic-source-graph
# @story: trace-corpus-to-code
# @story: certify-completion
# @story: see-governing-versions
# @story: session-awareness
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
python3 "$view_bin" --root "$view_tmp" --port "$view_port" \
  > "$view_tmp/serve.log" 2>&1 &
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

exit $fail
