---
audit: deterministic-source-graph
artifact: story:deterministic-source-graph
determination: satisfied
audited: 2026-07-28T10:29:55Z
artifact-hash: sha256:effceb0cfdc9
---

# Whether the vendored graph tooling regenerates byte-identically, moves exactly the edited unit's hash, and flags its own drift — now that the walk asks git which files exist

Rewritten whole. The design artifact's hash is unchanged, so the prior
determinations bind where their cited reality stands — but the mechanism
under three of the Acceptance conjuncts moved: `walk_sources()` was rewritten
so the candidate file set comes from `git ls-files --cached --others
--exclude-standard -z` whenever the project root is a git work tree, with the
old filesystem walk kept as the non-git fallback and the hardcoded exclusions
refactored into `is_excluded()` applied on both paths. That change lands
directly inside this story's territory — it changes *which* files are graphed,
which is the input to every determinism and drift claim — and the prior pass
had recorded the absence it repairs ("the walk has no gitignore awareness") as
a boundary. So every claim about the exclusion rules is re-derived below
against the new walk rather than carried, the exhibitions are re-run on this
repository's own tree with the fixed binary, and the new proof case is judged
against the Acceptance including an independent mutation test. The existing
Notes ledger (the promoted genesis-spot-check note) carries forward verbatim.

One state of the world has to be stated up front, because half the evidence
below depends on it. The fix lives in the family source
(`plugins/ok/families/ok-planner/scripts/source-graph`); the vendored copy
this repository runs (`.ok-planner/bin/source-graph`) is still the pre-fix
rendering, because the vendored layer converges after certification, not
during it. Diffing the two modulo the version stamp shows exactly one
difference, and it is exactly the walk rewrite — no second, unaccounted
divergence hiding behind the expected one. Every exhibition of the *new*
behavior below was therefore run in a scratch copy of this tree against the
family source with the stamp substituted; every statement about this
repository's own committed graph describes what the pre-fix vendored binary
produced. Both are labelled as such.

## Claims

**Title / Story — "my project's sources mapped into a committed graph
that regenerates identically from the same tree and flags its own drift,
so that what a change invalidates is computed from recorded structure
instead of re-guessed at every close."** Honored, and the "so that" clause is
still delivered by a live consumer rather than in principle:
`.ok-planner/graph/` carries one `.graph` mirror per source file, each with a
`file` node, a `node` row per declared unit with a structural identity and
content hash, and `ref` edges; `audit-check` resolves `cite-node:` citations
through that committed graph; both gates compute the re-audit set from those
citations plus the change inspector reading the graph. This audit's own
Citations block is largely `cite-node:` lines resolving through it, and the
citations that went stale this cycle went stale *because* the mechanism
worked — the checker named the moved `source-graph` and `proofs.sh` node
hashes and the moved `walk_sources` span, and nothing else in this file.

**Acceptance 1 — "The owner (or a certifying session) runs the vendored
graph tooling → the committed graph appears or refreshes."** Honored, and
untouched by this cycle's change. The planner converge core materializes
`scripts/source-graph` to `.ok-planner/bin/source-graph`, version-stamped and
executable, and its diagnose pass drift-checks that rendering; that is what
makes the tool vendored for every converged project, and it is the citation
that survives any one project's estate moving. This repository carries the
vendored copy and its committed graph is that copy's output. Both gates name
`.ok-planner/bin/source-graph build` as the step preceding any judgment of
citations — the pinned process nodes of `certify-work` and `certify-all` both
carry it — and both make `source-graph check` at exit 0 part of the clean bar.
`build` regenerates wholesale, creating mirror directories, rewriting only
files whose body differs, and removing orphaned graph files with a re-listing
bottom-up sweep. Exhibited on the fixed binary over this tree in scratch: the
first build reported `247 files graphed (2 rewritten, 2 orphans removed)`, and
`check` then exited 0 — the refresh path, including orphan removal, driving
real output.

**Acceptance 2 — "byte-identical across repeated runs on an unchanged
tree."** Honored, and re-exhibited rather than carried, because the input
surface is what changed. The generator remains a pure function of the tree and
the walked file set: a sorted candidate list, no symlink following, sorted node
rows, a deduplicated `ref` set emitted sorted, hashes over exact span bytes;
`walk_sources` still ends in `sorted(found)`, and the git path's `set(...)`
comprehension — which is unordered by construction — is drained through that
same sort, so the set's iteration order cannot reach the output. Exhibition,
run this pass in a scratch copy of this repository against the fixed binary:
three consecutive `build` invocations each reported `247 files graphed (0
rewritten, 0 orphans removed)`, and the concatenated digest of all 247 mirrors
was `51ec0be515a1…` all three times, with `check` at exit 0.

What the change *did* alter, stated precisely because the claim lives here and
nowhere else: the walk's input is no longer only the non-`.git` filesystem. It
now reads git's index and git's standard exclude sources. Three consequences
were exhibited rather than reasoned about, all in scratch:

- A gitignored file is invisible. Overwriting `.claude/settings.local.json`
  with arbitrary new content left `check` at exit 0 — no `graph-missing`, no
  `graph-stale`. That is the repair's whole point, and it removes the prior
  pass's recorded portability boundary for ignored files: on this tree the
  fixed walk drops exactly the two mirrors the old one contributed
  (`.claude/settings.local.json`, `.claude/scheduled_tasks.lock`), 249 → 247.
- An *untracked but unignored* file is still graphed: creating `newfile.md`
  produced `[graph-missing] newfile.md has no committed graph file`. So the
  portability boundary is narrowed, not closed — a build run while an
  unignored file sits untracked commits a mirror a fresh clone will call
  orphaned.
- The index is now an input. `git add -f` on an ignored file — an act that
  changes no working-tree byte at all — flipped the file set and produced
  `[graph-missing] .claude/settings.local.json …` plus two `graph-stale`
  mirrors. Two more inputs are per-clone rather than per-tree:
  `--exclude-standard` honors `.git/info/exclude` and the global
  `core.excludesFile`, and in this very repository `.claude/scheduled_tasks.lock`
  is excluded through `.git/info/exclude` — a file that is not committed.

Is that the falsifier's "two runs on an identical tree produce differing
graphs"? Read honestly, no, and the reason is worth recording rather than
asserting. The falsifier is about *repeated runs* — same conditions, same
result — and that is exactly what the three-identical-digests exhibition
shows. The index and the exclude files are not the tree; they are the
project's own statement of which files it considers its own, and the one
index-only flip that changes the graph is force-adding a file the project
declared ignored, which is a deliberate act meaning "this is a source now".
Nothing in the Story, Acceptance or Falsifier says the graph is a function of
the working-tree bytes alone, or that it is reproducible across clones. The
claim is byte-identity on the same tree, which holds. Recorded, and the
tightening that would flip this is named in the Determination.

A fourth consequence is a genuine inconsistency between the tool's own two
file-set sources, recorded because the Acceptance does not reach it: presence
or absence of `.git` at the root changes the answer. Removing `.git` from the
scratch copy and rebuilding produced `249 files graphed` — the two ignored
files return — and the guard is `os.path.exists(os.path.join(root, ".git"))`,
not a `git rev-parse`, so a consumer project nested inside a parent repository
without its own `.git` takes the fallback and graphs the parent's ignored
files. Exhibited: a project root at `outer/sub` inside a git repository whose
`.gitignore` covers `sub/src/ignored.js` graphed `ignored.js` anyway. The two
sources agree on any tree where ignored files are simply absent (a clean
export), and disagree only where ignored files are present and `.git` is not.
The proof case asserts both halves of this deliberately, so the divergence is
declared rather than accidental.

**Acceptance 3 — "after an edit inside one declared unit, that unit's
recorded hash moves and unrelated hashes do not."** Honored, and re-exhibited
on real repository code with the fixed binary, because a walk change could in
principle have perturbed node extraction. It did not: in the scratch copy one
benign line was inserted inside the shell function `vendor_layer` of the
planner converge core and the graph rebuilt; that mirror moved exactly one
`node` row — `#vendor_layer` from `57c9adc41d84` to `0dd4e2f6450b` — while
`#check_rendered`, `#detect_premigration` and `#resolve_root` held their
recorded hashes byte for byte, and `check` returned to exit 0 after the edit
was reverted and rebuilt.

One second-order effect of the narrowed file set is visible here and is
correct rather than a defect: dropping the two ignored files also dropped two
`ref` edges that pointed at `.claude/settings.local.json` (from
`ok-planner/CLAUDE.md#claude-md.constraints` and from
`ok-workspaces/skills/open/SKILL.md#open-a-workspace.steps`), because
`resolve_ref` only resolves targets that are in the walked file set. No `node`
hash moved in either mirror. So "unrelated hashes do not move" survives a file
set change; only edge rows follow it, which is what a graph derived from a
population must do.

The harness holds the same property from the fixture side, including the
negative half: after editing one line inside `side()`, exactly two `node` lines
differ between the before and after graph, confined to `src/app.js#side`, and
the unrelated file's graph is byte-identical. A second fixture pins the case
that would have made this claim false in the language the suite is mostly
written in: a shell function containing heredoc bodies with stray braces.
Naive brace counting would close the enclosing function early, so an edit
after the heredoc but inside the function would move no hash at all;
`blank_sh_noise` blanks heredoc bodies through their terminator (honoring both
the quoted `<<'EOF'` and the tab-stripping `<<-END` form), and the harness
asserts the function is neither split nor swallowed, that the post-heredoc
edit does move its hash, and that the neighbouring function's hash stands
still.

The heredoc fixture's discriminating power was established adversarially in an
earlier pass and that finding binds, its cited reality unmoved (both seeded
body lines and all three enclosing spans verify unchanged this cycle).
Restated so it is not re-derived: the two seeded heredoc bodies are
deliberately brace-*unbalanced* per line — a lone `}` in the quoted body, a
lone `{` in the tab-stripped one — where a balanced pair on one line would
have cancelled under per-line net counting and left a naive extractor
accidentally correct. Run through a copy of `source-graph` with the heredoc
blanking removed, the enclosing `emit` node's hash did **not** move across the
post-heredoc edit while `other`'s hash and the node structure were unharmed,
so the harness's second heredoc assertion flips to `bad` under that regression
and only under it.

**Acceptance 4 — "with the committed graph out of date, the checker
reports drift and exits non-zero."** Honored on all three drift shapes, each
re-exhibited this pass against the real tree with the fixed binary rather than
argued: deleting a source produced `[graph-orphaned] no source file at
docs/integration-contract.md` (alongside `graph-stale` on the three mirrors
whose `ref` edges pointed at it — the population effect again); adding one
produced `[graph-missing] newfile.md has no committed graph file`; editing one
produced `[graph-stale] committed graph differs from the tree` — exit 2
throughout, exit 0 on the untouched graph and again after every revert. The
same three shapes are visible from the audit side, where `audit-check` refuses
to judge a `cite-node:` through a missing or tree-divergent graph and reports
`graph-missing` / `graph-stale` as its own findings. Five harness fixtures in
the companion `audit-check` harness hold the same triggers, green at exit 0
this cycle.

**Acceptance 5 — "The extractor and checker are real vendored tools
operating on the real source tree — not stubs."** Honored. The prior pass
confirmed this member by member against the genesis output; the parts that
depend on the walk are re-derived here against the fixed binary and the rest
binds by precedent with its cited reality verified unmoved.

- *Population accounting, re-derived.* Under the fixed walk this tree yields
  247 graphed files and 247 mirrors. Independently reconstructed: `git
  ls-files` names 719 tracked files, 247 of them outside `.ok-planner/`; the
  three untracked-but-unignored files in the tree are the new issue files,
  all inside the excluded estate; the two remaining untracked files are
  ignored and are exactly the two mirrors the fix drops. 247 = 247 + 0. The
  old count of 249 is fully explained.
- *Root-estate exclusion, re-derived against the refactor.* The guard moved
  from the walk into `is_excluded`, where it is `parts[0] == ".ok-planner"` —
  still root-scoped, so the harness's fixture trees under
  `test/fixtures/*/.ok-planner/` are still graphed, which is what lets the
  audit-corpus fixtures be ordinary sources. Verified by count, not by
  reading: 197 fixture-estate mirrors before the change, 197 after. `.git`
  and `node_modules` remain excluded at any depth, now by the same helper on
  both paths (`any(p in EXCLUDED_DIRS for p in parts[:-1])`), and `.DS_Store`
  by name. The fallback path additionally keeps its `os.walk` pruning, so the
  non-git path never descends into an excluded directory.
- *Symlink and non-regular-file handling survived the refactor.* The
  `os.path.islink(full) or not os.path.isfile(full)` guard moved from the
  fallback's inner loop into `walk_sources`, where it now covers the git path
  too — which it must, since `git ls-files --cached` names paths deleted from
  the working tree and symlinks git tracks as such.
- *Mask behavior, re-verified.* 35 mirrors carry `masked:` rows under the
  committed graph and 35 under the fixed binary's — the mask is untouched by
  this change (`hash_pair` and `mask_release_metadata` both verify unmoved),
  and the front-door manifest's mirror still records `sha256:0a63d8f25de3
  masked:6ec970155f6e` while `audit-check cite-node` for that path still emits
  `6ec970155f6e`.
- *Binary handling and adapters on real files* bind by precedent, their cited
  spans unmoved: two non-UTF-8 files with a file node and no declared-unit
  nodes hashed over raw bytes; the shell adapter finding exactly the four
  functions the converge core declares; the JavaScript adapter finding
  `repoRoot` and the arrow `stamp` and declining the non-function `const`
  bindings; markdown carrying nested heading-section identities.

The boundary recorded last pass — no python adapter, so this repository's two
python programs receive a file node and no declared-unit nodes — stands
unchanged and is still not charged: the Acceptance's declared-unit conjunct is
conditional on a declared unit existing.

**Falsifier — "Two runs on an identical tree produce differing graphs; an
edit inside a declared unit leaves its recorded hash unchanged, or moves
unrelated hashes; a stale committed graph passes the checker silently."**
Each of the three is exercised in the negative, twice over: by the harness on
fixtures, and this pass on the real tree under the fixed binary (three
identical digests over 247 files; one node moved and three neighbours held;
three drift shapes at exit 2). The middle clause is the one the heredoc
fixture guards and is demonstrated checkable rather than asserted. The first
clause is the one this cycle's change touches, and the honest reading of it is
argued under Acceptance 2 rather than glossed.

**Proof — "a deterministic harness case that builds the graph twice on an
unchanged fixture and byte-compares the results, edits one declared unit and
observes exactly that node's hash move, and corrupts the committed graph to
observe the checker exit non-zero."** All three conjuncts are exhibited, not
modelled: the harness drives the actual program (`$source_graph` resolves to
the **family** source, so the harness tests the fixed binary, not the lagging
vendored one) against fixture trees it constructs, and every assertion is a
consequence of running it. Green on this tree at exit 0, now 66 assertions
(63 before this cycle), thirteen of them under this story.

The three assertions added this cycle were judged against the Acceptance
rather than accepted, and they earn their place:

- *They cover the mechanism the change introduced.* A git fixture is built
  (`git init`, one tracked source, one source named in `.gitignore`), the
  graph is built, and the case asserts the tracked file **is** graphed while
  the ignored one is **not**, then that `check` is clean on that graph, then —
  after `rm -rf .git` — that the fallback walk **does** graph the previously
  ignored file.
- *The falsifier is real and narrow.* Verified independently rather than
  taken from the change's own claim: running the pre-fix binary
  (`.ok-planner/bin/source-graph`, which is that binary, still on disk) over
  the identical fixture graphs the gitignored file, so the first assertion
  turns `bad` — and the second and third do not, so the case fails exactly
  where it should and nowhere else.
- *The second half is not decoration.* The cheapest way to fake this
  behavior is a name-based exclusion rather than asking git. Constructed and
  run: a mutant whose `is_excluded` drops any basename containing `.local.`
  and whose `git_listed_files` always returns `None` passes the first
  assertion and fails the third. So the two halves are jointly discriminating
  — no implementation can satisfy both without genuinely consulting git on git
  trees and genuinely not consulting it elsewhere.

The Proof field's literal three conjuncts remain covered by the older block;
the heredoc fixture and now the gitignore fixture cover more than the field
asks. The one Acceptance clause the harness exercises only against fixture
trees — "operating on the real source tree" — is covered by the committed
graph itself and by the exhibitions above.

## Determination

**satisfied.** The tooling is a real program, vendored by the converge core
into a consumer estate and in use in this one, and it delivers each Acceptance
conjunct at a citable point after the walk rewrite as before it: a
deterministic generator whose output is a pure function of the tree and the
walked file set, a checker with three distinguished drift findings and a
non-zero exit, node identities derived from declared structure rather than
line positions, and content hashes over exact span bytes. The rewrite was
re-derived rather than carried: determinism re-exhibited at three identical
247-file digests, in-unit hash movement re-exhibited on real code with its
unrelated-hash negative, all three drift shapes re-exhibited at exit 2, the
root-estate guard confirmed still root-scoped by a 197-mirror fixture-estate
count, the symlink guard confirmed to have survived onto the git path, and the
mask confirmed unmoved at 35 masked mirrors on both sides. The new proof case
was mutation-tested twice — against the real pre-fix binary and against a
name-based cheat — and discriminates in both directions.

Three things are recorded as boundaries rather than charged, because no
sentence of the Story, Acceptance or Falsifier reaches them. (1) The graph's
inputs now include git state that is not the tree: the index, and
`--exclude-standard`'s per-clone sources (`.git/info/exclude`, the global
excludes file) — in this repository `.claude/scheduled_tasks.lock` is excluded
through an uncommitted local exclude. (2) Cross-clone reproducibility is
narrowed but not delivered: an untracked-but-unignored file is still graphed.
(3) The two file-set sources disagree — a root without its own `.git`, including
a consumer project nested inside a parent repository, takes the fallback and
graphs ignored files — which the proof case asserts deliberately in both
directions. Separately and not charged: this repository's committed graph is
still the pre-fix binary's 249-mirror output and will lose two mirrors at the
next converge; `check` is green today only because the vendored binary is the
one that built it, and the family source and the vendored copy differ by
exactly the walk rewrite and nothing else.

This determination stops holding if: `build` stops being a pure function of
the tree and the walked file set — an unsorted candidate list reaching the
output past `sorted(found)`, an unsorted ref set, a timestamp, or a mutable
path in a hash (the pinned `graph_for`, `expected_graph`, `walk_sources`,
`git_listed_files`, `filesystem_files` and `build` spans break first); `check`
stops distinguishing missing / stale / orphaned or stops exiting non-zero;
`is_excluded`'s root-estate guard stops being root-scoped, so the fixture
estates start being graphed or the real estate stops being (the pinned
`is_excluded` span breaks); the symlink / non-regular-file guard is dropped
from the git path, letting a `git ls-files` entry with no regular file behind
it into the graph; `blank_sh_noise` loses its heredoc handling; the seeded
heredoc bodies are rebalanced or reduced to a single form, at which point that
fixture stops discriminating (the two pinned body lines break first);
`source-graph`'s mask stops agreeing with `audit-check`'s (the pinned
`mask_release_metadata` and `hash_pair` spans break); the converge core stops
materializing `source-graph` into `.ok-planner/bin/` or either gate stops
naming `source-graph build` before judging citations; node identity is
re-derived from line positions rather than declared structure; or the
gitignore proof case loses either half — its git assertion or its no-git
fallback assertion — at which point a name-based exclusion would satisfy the
harness (the pinned proofs.sh block and its two assertion anchors break). It
would flip if the Acceptance or Falsifier were ever tightened to claim the
committed graph is reproducible across clones, or that the graph is a function
of the working-tree bytes alone — neither of which the git-sourced walk
delivers.

## Notes

- note: `.ok-planner/graph/` — 249 new `.graph` mirror files, the genesis build of the committed source graph (this project's first real `source-graph build` output) — implicated because this is the story's mechanism materializing for real for the first time in this project; worth spot-checking the output against the acceptance (root `.ok-planner` estate excluded, `.git`/`node_modules` excluded, binary/non-UTF-8 files carry a file-only node, masked hashes applied where stamps appear) rather than only the tool's source code.
  adjudication: promoted — the genesis output was spot-checked member by member under Acceptance 5 (population accounting 249 = 247 tracked non-estate + 2 untracked; root-scoped estate exclusion; two non-UTF-8 files with file-only nodes and no mask; 35 masked mirrors agreeing with `audit-check cite-node` on the front-door manifest; adapter behavior on real shell/JS/markdown files), and the nominated territory is now carried by the whole-file node pins on `scripts/source-graph`, `admin/converge` and `test/proofs.sh`, by the two pinned walk-exclusion lines, and by the `mask_release_metadata` and `hash_pair` spans that fix the mask contract; two boundaries were recorded (no python adapter; no gitignore awareness in the walk) and neither falsifies a claim.

## Citations

- cite-node: plugins/ok/families/ok-planner/scripts/source-graph @ sha256:868ff5e192f4
- cite-node: plugins/ok/families/ok-planner/admin/converge @ sha256:144ab87e08af
- cite-node: plugins/ok/families/ok-planner/test/proofs.sh @ sha256:56f10a35ea9e
- cite-node: plugins/ok/families/ok-planner/test/run.sh @ sha256:8c0006755840
- cite-node: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md#certify-the-work-the-change-scoped-gate.process @ sha256:d26bc8e299d5
- cite-node: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md#certify-everything-the-full-gate.process @ sha256:5c588bd4687c
- cite-span: plugins/ok/families/ok-planner/scripts/source-graph :: "def graph_for(root, rel, fileset):" +49 sha256:7eb05d494b4d
- cite-span: plugins/ok/families/ok-planner/scripts/source-graph :: "def expected_graph(root):" +3 sha256:cc355221871d
- cite-span: plugins/ok/families/ok-planner/scripts/source-graph :: "def is_excluded(rel):" +9 sha256:3a0528133060
- cite-span: plugins/ok/families/ok-planner/scripts/source-graph :: "def git_listed_files(root):" +22 sha256:c5673e243e74
- cite-span: plugins/ok/families/ok-planner/scripts/source-graph :: "def filesystem_files(root):" +13 sha256:8f5d71a3c45e
- cite-span: plugins/ok/families/ok-planner/scripts/source-graph :: "def walk_sources(root):" +13 sha256:d24b8652c511
- cite-span: plugins/ok/families/ok-planner/scripts/source-graph :: "def build(root):" +30 sha256:a6300c738da4
- cite-span: plugins/ok/families/ok-planner/scripts/source-graph :: "def check(root):" +26 sha256:9f97ed446964
- cite-span: plugins/ok/families/ok-planner/scripts/source-graph :: "def hash_pair(data, rel):" +9 sha256:67be9d7d4edd
- cite-span: plugins/ok/families/ok-planner/scripts/source-graph :: "def mask_release_metadata(text, target):" +13 sha256:b4095fb6d43a
- cite-span: plugins/ok/families/ok-planner/scripts/source-graph :: "def blank_sh_noise(lines):" +8 sha256:8c646d3c0036
- cite: plugins/ok/families/ok-planner/scripts/source-graph :: "# The file set is sourced from git whenever the project root is a git"
- cite: plugins/ok/families/ok-planner/scripts/source-graph :: "EXCLUDED_DIRS = (".git", "node_modules")"
- cite: plugins/ok/families/ok-planner/scripts/source-graph :: "and not (rel_dir == "." and d == ".ok-planner")"
- cite: plugins/ok/families/ok-planner/scripts/source-graph :: "HEADER = "# source-graph v1 — mechanically generated; do not hand-edit.\n""
- cite: plugins/ok/families/ok-planner/scripts/source-graph :: "source-graph build|check [<project-root>]"
- cite: .ok-planner/bin/source-graph :: "source-graph build|check [<project-root>]"
- cite-span: plugins/ok/families/ok-planner/admin/converge :: "    sed "s/{{OK_PLANNER_VERSION}}/${SUITE_VERSION}/g" "$SOURCE_GRAPH" > "${OK_DIR}/bin/source-graph"" +2 sha256:710a9e6e0dae
- cite: plugins/ok/families/ok-planner/admin/converge :: "    [ -f "$SOURCE_GRAPH" ] && check_rendered "$SOURCE_GRAPH" "${OK_DIR}/bin/source-graph" ".ok-planner/bin/source-graph""
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "def load_graph(root, source_rel):" +35 sha256:1aacd02c60fc
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "stale graph is a finding""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "missing graph is a finding""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "node content change trips""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "renamed node unresolves""
- cite: plugins/ok/families/ok-planner/test/proofs.sh :: "# @story: deterministic-source-graph"
- cite-span: plugins/ok/families/ok-planner/test/proofs.sh :: "# deterministic-source-graph: the vendored extractor builds the" +8 sha256:668af21ad84d
- cite-span: plugins/ok/families/ok-planner/test/proofs.sh :: "# --- deterministic-source-graph: build twice, edit one unit, corrupt ---------" +63 sha256:fcc4649a6c64
- cite-span: plugins/ok/families/ok-planner/test/proofs.sh :: "# A declared unit's span must survive text the language does not read as" +48 sha256:58072d2dac4c
- cite-span: plugins/ok/families/ok-planner/test/proofs.sh :: "# "Identical trees yield byte-identical graphs" is a claim about the" +31 sha256:1045548c4153
- cite: plugins/ok/families/ok-planner/test/proofs.sh :: "  "deterministic-source-graph: a gitignored local file stays out of the graph while its tracked neighbour is graphed""
- cite: plugins/ok/families/ok-planner/test/proofs.sh :: "  || bad "deterministic-source-graph: the fallback walk lost files in a project without git""
- cite: plugins/ok/families/ok-planner/test/proofs.sh :: "a lone } closing brace, unbalanced, inside heredoc prose"
- cite: plugins/ok/families/ok-planner/test/proofs.sh :: "	{ a lone opening brace in an indented heredoc body"
