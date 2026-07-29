---
audit: resolution-through-pinned-checker
artifact: decision:resolution-through-pinned-checker
determination: satisfied
audited: 2026-07-28T18:00:00Z
artifact-hash: sha256:665e3d02bd25
---

# Does the serving program really resolve every citation by calling the project's own checker rather than a second implementation?

Refreshed. The design artifact is unchanged. Both stale citations are
whole-file node pins — `audit-check` and `corpus-view` — moved by the
Release v11.2.0 commit. `audit-check` gained the `--inspection` flag, the
git-diff-driven `git_changed_sources`/`head_graph_rows` helpers, and the
inspection-registry parser/checks — all new functions, read directly
against this audit's four named primitives: `locate_anchor`,
`mask_release_metadata`, `span_hash`, and `masked_file_hash` are
byte-unchanged (confirmed by diff — none of their `def` lines appear in
the commit's diff), and `check_audit` only gained a parameter, not a
behavior change to `cite:`/`cite-span:`/`cite-file:`/`cite-node:`
resolution. `corpus-view` gained `inspection_now()` and the
`/api/inspection` route, which reads the registry and the graph but calls
none of `resolve_citation`'s machinery — it is new, separate read surface,
not a change to how any citation form resolves. C1–C8's cited call sites
(`self.checker.locate_anchor`, `.mask_release_metadata`, `.span_hash`,
`.masked_file_hash`, `.load_graph`) are all untouched. Citations
regenerated; nothing else touched.

Refreshed again. The two whole-file pins (`audit-check`, `test/proofs.sh`)
moved a second time this cycle — `audit-check` for the same reason as
before (further `--inspection`-floor growth: `check_inspection` gained a
`base=None` parameter and an outside-unit remainder-hashing block, neither
touching the four named primitives or `check_audit`'s resolution behavior),
and `test/proofs.sh` for unrelated conjunct growth elsewhere in the file.
This decision's one proof-side anchor
(`broken=$(fetch "$base/api/artifact/story/see-data")`) still resolves
verbatim. Citations regenerated; nothing else touched.

Refreshed again. The design artifact is unchanged. The one stale citation
is the whole-file pin on `test/proofs.sh`, moved by unrelated conjunct
growth elsewhere in the file (the cap-rewording exhibitions added to the
`certify-completion` story's section). This decision's own cited anchor
(`broken=$(fetch "$base/api/artifact/story/see-data")`) still resolves
verbatim. Citation regenerated; nothing else touched.

## Claims

**Why this is a re-audit, and what moved.** The design artifact is unchanged
(hash identical to last cycle). `corpus-view` changed substantially this
cycle — the resolver's returned shape moved from a bare `hits` list plus
ad-hoc `start`/`end` fields to a uniform `regions` list every resolver
populates through one `_set_regions` helper, and `payload_dir()` was
rewritten to stop deriving the payload from `__file__` unconditionally (it
now checks the directory actually looks like a carried family before
trusting it, falling back to `CLAUDE_PLUGIN_ROOT`). Neither touches this
decision's subject. C6 is the claim most exposed to a refactor of this
shape — "Calling the project's own copy makes that disagreement structurally
impossible" — because the `cite:` form is explicitly the one composed
rather than called, so re-verifying it, not just refreshing its hash, is
what this cycle demanded. Read against the current `_resolve_anchor`: it
still computes `masked = self.checker.mask_release_metadata(anchor, target)`
and `present = normalize(masked) in normalize("\n".join(lines))` using
`self.checker.normalize`, over `lines` built by
`self.checker.mask_release_metadata(raw, rel).splitlines()` — the same two
checker primitives the prior audit found, called the same way. I compared
this against `check_audit`'s own `cite:` test in `audit-check` directly
rather than trusting the prior audit's characterization: it tests
`normalize(mask_release_metadata(anchor, target)) not in
normalize(content)` where `content = mask_release_metadata(f.read(), target)`
over the whole file. `normalize` collapses every run of whitespace
(including newlines) to one space, so the view's
`"\n".join(lines).splitlines()`-then-`join` round trip and the checker's
raw-file read normalize to the same string — the join cannot introduce or
remove a place where `normalize` would have collapsed anyway, since every
boundary `splitlines()` cuts on is itself whitespace. The composition is
still arithmetically identical to the gate's, unchanged. The `hits`-to-
`regions` refactor touched only how a match's *location* is packaged for
display (`_set_regions`, used identically by all four resolvers), never the
presence test itself, and every `cite:`/`cite-span:`/`cite-file:`/
`cite-node:` primitive call this audit cites by exact line — `locate_anchor`,
`mask_release_metadata`, `span_hash`, `masked_file_hash`, `load_graph` — was
checked directly this cycle and still resolves verbatim (`audit-check`
confirms: none of this audit's `cite:` anchor lines went stale, only the two
whole-file `cite-node:` pins on `corpus-view` and `test/proofs.sh`).
`payload_dir()`'s rewrite bears on C2's fallback path (which checker is
used when a project has none of its own) and is unaffected in substance:
the fallback still resolves to the carried payload's copy when the
project's own is absent, just via a more careful directory check.

**C1 — "resolves every citation."** Quantified over citation forms, so
the population is enumerated from the checker itself rather than from the
decision's prose or from what the view happens to handle. The checker
recognizes exactly four citation line patterns — `cite:`, `cite-span:`,
`cite-file:` and `cite-node:` — and treats any other line beginning with
one of those four prefixes as malformed rather than as a fifth form. The
whole checker file is pinned below as that enumeration source, so a fifth
form landing there re-triggers this audit. The view's resolver dispatches
on all four, **and does so using the checker's own compiled patterns**
(`ac.CITE_LINE`, `ac.CITE_SPAN_LINE`, `ac.CITE_FILE_LINE`,
`ac.CITE_NODE_LINE`) rather than patterns of its own — so even the
parsing cannot drift from what the gate parses. **Honored.**

**C2 — "by calling the project's own materialized audit checker."** The
tooling loader imports `.ok-planner/bin/audit-check` from the project
root as a module and records the provenance as `pinned`; only where the
project has no materialized copy does it fall back to the carried
payload's, recorded as `payload` and announced on the terminal and in
the page header. Where a project has a checker, that checker is what
answers. **Honored,** with the fallback stated under Determination.

**C3 — "rather than reimplementing anchor location, release-metadata
masking, and span hashing inside itself."** Checked one named primitive
at a time, against the whole serving program:

- *Anchor location* — both the `cite:` and `cite-span:` resolvers call
  `self.checker.locate_anchor`. The view computes no line index of its
  own for either form.
- *Release-metadata masking* — every file the view reads is passed
  through `self.checker.mask_release_metadata` before any comparison or
  display, and each anchor is masked with the same function before being
  matched; whole-file pins go through `self.checker.masked_file_hash`.
  There is no mask pattern in the serving program.
- *Span hashing* — `self.checker.span_hash`, on the exact slice the
  checker would take.
- *Graph node lookup*, beyond the three named — `self.checker.load_graph`,
  including its `graph-missing` / `graph-stale` outcomes, which the view
  reports as distinct states rather than collapsing into "current".

**Honored,** with the two composition sites recorded under Determination.

**C4 — Rationale: "The checker carries the certification gate's
arithmetic, including a masking rule that deliberately ignores
release-mutable metadata so that a version bump voids no audit."** True
of the checker as it stands: its masking neutralizes materialization
stamps, `VERSION =` literals, suite-family version tokens, and manifest
versions. Because the view calls that function rather than a copy, the
property is inherited rather than restated. **Honored.**

**C5 — Rationale: "the drift would surface as the view calling a
citation stale that the gate calls clean — worst precisely during a
release."** This is the failure the choice exists to prevent, and it is
prevented for all four forms: each form's verdict is computed from the
checker's own primitives on the checker's own masked text. The story's
proof exercises the same property end to end on a deliberately broken
span, asserting the view's `stale` against the checker's finding count in
one run. **Honored.**

**C6 — Rationale: "Calling the project's own copy makes that
disagreement structurally impossible."** The strongest sentence in the
artifact, and the one most worth attacking. Three of the four forms are
literally structural: for `cite-span:`, `cite-file:` and `cite-node:` the
view calls the checker's primitives and compares against the audit's
pinned hash exactly as `check_audit` does, including the multi-hit span
anchor case, which both call ambiguous. The `cite:` form is the
exception: the checker exposes no per-citation predicate, so the view
composes the same test from the checker's `normalize` and
`mask_release_metadata` — containment of the normalized masked anchor in
the normalized masked file. That composition is arithmetically identical
to the gate's today (both collapse every whitespace run to a single space
over the whole file, and the view's intermediate `splitlines()`/`join`
cannot change the result, since every boundary `splitlines` splits on is
whitespace to `normalize`). So no disagreement exists — but it is
prevented by matching construction, not by structure. **Honored, with
the qualification recorded.**

**C7 — Rationale: "inherits each project's pinned resolution behavior
without tracking it separately."** True by C2: nothing in the serving
program records or compares resolution behavior across versions; it runs
whatever the estate holds. **Honored.**

**C8 — the alternatives are real.** Reimplementing resolution, shelling
out to the checker's command line (whose output reports findings rather
than locations), and reading the committed graph alone (blind to the
anchor forms) are each a plausible different choice with a stated cost.
This is a decision, not a default. **Honored.**

## Determination

**satisfied.** Every one of the four citation forms the checker
recognizes is resolved by calling into that checker — its patterns, its
masking, its anchor location, its span and file hashing, its graph
loading — and the project's materialized copy is preferred over the
carried one. The disagreement the decision exists to prevent does not
exist for any form.

Three qualifications, recorded so a later auditor inherits the reasoning
rather than re-deriving it, none of which changes the determination:

- **The `cite:` presence test is composed, not called.** The checker
  offers no predicate for it, so the view rebuilds the test from the
  checker's `normalize` and masking primitives. It agrees exactly today.
  This is the one channel through which a future change to the checker's
  `cite:` rule could reopen drift silently — which is why the checker is
  pinned whole below, so any change to it re-triggers this audit.
- **Multi-line anchor localization is the view's own.** A helper searches
  the joined normalized text to find which lines an anchor spanning line
  breaks occupies. The checker has no counterpart, and this code cannot
  contradict it: it never sets or overrides a status, only the excerpt
  bounds the page draws. It is a display refinement, not a second
  resolution rule.
- **The fallback checker.** With no materialized checker, the payload's
  copy resolves and the provenance is announced. A project with no
  materialized checker has none to be "its own", so this is degradation
  outside the Choice's subject rather than a breach of it.

**What would have to change for this to stop holding.** A fifth citation
form appearing in the checker that the view's resolver does not dispatch;
any of `locate_anchor`, `mask_release_metadata`, `span_hash`,
`masked_file_hash` or `load_graph` being replaced in the view by local
code; the checker's `cite:` rule changing shape without the view's
composed test following it; or the estate copy losing its precedence over
the payload's in the tooling loader.

## Citations

- cite-node: plugins/ok/families/ok-planner/scripts/audit-check @ sha256:32b1732e3fdd
- cite: plugins/ok/families/ok-planner/scripts/audit-check :: "CITE_LINE = re.compile"
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "def locate_anchor(file_lines, anchor):" +4 sha256:3451b66c9daf
- cite: plugins/ok/families/ok-planner/scripts/audit-check :: "def mask_release_metadata(text, target):"
- cite: plugins/ok/families/ok-planner/scripts/audit-check :: "def span_hash(lines):"
- cite: plugins/ok/families/ok-planner/scripts/audit-check :: "def masked_file_hash(full, target):"
- cite-node: plugins/ok/families/ok-planner/scripts/corpus-view @ sha256:c985b50ad376
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "def resolve_citation(self, raw):"
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "m = ac.CITE_NODE_LINE.match(raw)"
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "hits = self.checker.locate_anchor(lines, masked)"
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "present = normalize(masked) in normalize("\n".join(lines))"
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "def _spanning_range(lines, needle):"
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "actual = self.checker.span_hash(lines[start:start + count])"
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "actual = self.checker.masked_file_hash(full, target)"
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "rows, err = self.checker.load_graph(self.root, target)"
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "lines = self.checker.mask_release_metadata(raw, rel).splitlines()"
- cite-span: plugins/ok/families/ok-planner/scripts/corpus-view :: "def load_tooling(root):" +4 sha256:98b2caa37c65
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "provenance[name] = {"source": "pinned", "path": rel}"
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "out.append("note: no vendored %s — using the payload's copy; ""
- cite-node: plugins/ok/families/ok-planner/test/proofs.sh @ sha256:10f3b1e855fd
- cite: plugins/ok/families/ok-planner/test/proofs.sh :: "broken=$(fetch "$base/api/artifact/story/see-data")"
