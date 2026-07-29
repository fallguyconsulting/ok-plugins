---
audit: built-bundle-fetched-at-pin
artifact: decision:built-bundle-fetched-at-pin
determination: satisfied
audited: 2026-07-28T23:00:00Z
artifact-hash: sha256:8882717e6d56
---

# Is the view's build really built per release, carried as payload, placed by converge, and kept out of the repository?

Refreshed. The design artifact's hash is unchanged. The one stale citation
was the whole-file node pin on `corpus-view`, moved by the Release
v11.2.0 commit's addition of `inspection_now()` and the `/api/inspection`
route — the change-inspection registry's read-side surface, added entirely
inside `ViewServer` alongside `corpus_now()` and dispatched from `do_GET`.
Read directly: the addition touches none of `find_bundle`, `browser_stamp`,
`bundle_version`, or the `if cand and os.path.isfile(...)` resolution this
decision's C1–C4 cite — it is new, unrelated territory (inspection-registry
reads), not a change to build resolution. Citation regenerated; nothing
else touched.

Amended. The design artifact's hash is unchanged. Four citations moved this
pass — the whole-file pins on `admin/converge` and `corpus-view`, the
`find_bundle` span, and the release skill's step-5a node — and each was
re-derived below rather than assumed harmless, because C2 and C4 rest
directly on the two functions that changed. Every other claim's evidence is
untouched.

`admin/converge` gained a fourth materialized site since this audit was
last written (`browser_stamp()` / `.build-stamp`, alongside the already-cited
`PROOF_TIMINGS`/`CORPUS_VIEW`/`ESTATE_GITIGNORE` additions) and now writes a
content digest beside the placed build so a later diagnose can distinguish
missing / unstamped / stale / drifted — a strengthening of C2's "same pass"
claim, not a threat to it: the stamp write sits inside the same unconditional
`if [ -f "${BROWSER_BUILD}/index.html" ]` block as the `cp -R` this claim
already cites, so the two still cannot happen apart. `find_bundle` itself
was rewritten to route the payload candidate through a new `payload_dir()`
helper (fixing a latent bug where the vendored copy's own `__file__` could
never resolve to a family directory) rather than deriving it inline, but the
function's observable contract — three candidates, override then estate then
payload, first `index.html` wins — is unchanged; re-read below rather than
assumed from the diff's shape. Both re-derivations are folded into C2 and C4;
nothing about the Determination moves.

## Claims

**C1 — "built once per suite release and carried as family payload."**
The release ceremony carries a step of its own for it, marked "do not
skip", that runs the frontend's build and then asserts the output
exists, and states that the output directory is committed with the
release while its dependency tree is not. Reality agrees: the built
bundle is tracked in the index (three files under `browser/dist/`), the
repository's ignore file covers only `browser/node_modules/`, and
`git check-ignore` reports the built `index.html` as not ignored. So the
build is carried as payload rather than fetched. **Honored,** with the
enforcement strength recorded under Determination.

**C2 — "A project receives the build matching the suite version its
estate is already stamped with: the family's converge places it, in the
same administration pass that writes the estate's version stamp."**
Enumerated from the converge core itself, which is the only mechanism
that writes a consumer estate. One run of that script both stamps the
estate — substituting the suite version, read from the front-door
manifest, into the materialized `CLAUDE.md`, cheatsheet, checker,
extractor, cost recorder and the view's own service — and copies the
carried build into `.ok-planner/browser/`, replacing whatever was there,
then writes a build stamp beside it (`browser_stamp()`, new this pass and
re-read directly rather than assumed: a content digest over every placed
byte plus the suite version) so a later diagnose can tell an intact build
of this version from an older version's build or one corrupted in place.
The stamp write sits inside the identical `if [ -f "${BROWSER_BUILD}/index.html" ]`
guard as the `cp -R`, immediately after it, unconditionally — so a
convergence still cannot place a build without also stamping it.
There is no path by which one happens without the other: both are
unconditional statements in the same top-level script body, guarded only
by the payload files existing. **Honored.**

**C3 — "inside the planner's estate and ignored by git rather than
committed."** The build lands at `.ok-planner/browser/`, and the same
converge run writes the estate's own ignore file, whose first entry is
`browser/`. Because the ignore file sits inside the estate it governs
that directory regardless of the consumer's root ignore rules, and
because the source-graph extractor asks git what is ignored before it
walks, the bundle is also kept out of the committed graph. **Honored.**

**C4 — "The fetch is the administration's act, never the view's: the
build a project serves is the one its last convergence placed, not
something retrieved when a reader opens the page."** The negative half is
absolute: the serving program contains no network client of any kind —
its bundle resolution is three local filesystem candidates tested for an
`index.html`, in order (an explicit override, the estate's build, the
carried payload's build) — so nothing is retrieved at page open, ever.
`find_bundle` was rewritten this cycle to reach the payload candidate
through a new `payload_dir()` helper rather than deriving it inline — read
directly rather than assumed from the diff's shape, because the function is
this claim's own evidence. The rewrite is a bug fix, not a behavior change:
the old inline form derived the payload directory from `__file__`
unconditionally, which cannot resolve for the vendored copy (whose
`__file__` sits under a consumer's `.ok-planner/bin/`, never under a
carried family); `payload_dir()` instead checks whether `__file__` genuinely
sits in a family directory first, falls back to `CLAUDE_PLUGIN_ROOT` when it
does not, and returns `None` rather than a directory that can never carry a
build — so the vendored copy's fallback to the payload can actually fire.
The three-candidate order the claim rests on — override, estate, payload —
is unchanged. The positive half holds for every project that has a placed
build: the estate's copy is preferred over the payload's whenever it exists.
**Honored,** with the un-placed case recorded under Determination.

**C5 — "Earlier versioned builds stay retrievable because every released
version carries its own, so a project pinned to an older suite version
keeps a build that understands the corpus of its era."** The mechanism
is C1's: the build is committed into the release, so each release tag
carries the bundle built against that release's corpus, and converge
never reaches past the payload it was invoked from. Enumerated from
reality rather than from the sentence: **no existing release tag carries
a build** — checked across `v5.1.0`, `v6.0.0`, `v7.0.0`, `v8.0.0`,
`v9.0.0`, `v10.0.0`, `v11.1.1` and `v11.1.2`, every one of which has zero
tracked files under `browser/`. The 17 tracked browser files are the
uncommitted work under audit. The property therefore begins with the
first release cut after this change and is empty over the releases that
exist today. **Honored as a property of how releases are now cut;
recorded as presently-empty over its population.**

**C6 — Rationale: "Per-project pinning is the property that decides
this... a view built against a newer corpus renders an older project as
empty or broken."** This is the reason, and it is consistent with the
mechanism chosen: the placed build is whatever the payload that stamped
the estate carried, so build and corpus-era move together by
construction. **Honored.**

**C7 — Rationale: "Committing the build into each consumer estate would
pin it correctly but pay a permanent, churning generated artifact."**
The refused cost is real and the chosen shape avoids it — C3 keeps the
bundle untracked in every consumer. **Honored.**

**C8 — Rationale: "No new committed record is needed to support it
either: the estate already carries the suite version stamp and already
serves as the discovery marker."** Verified against the reading side: the
service recovers the estate's pinned version from artifacts that already
existed for other reasons — the materialized checker's `VERSION` literal,
falling back to the `Materialized by ok-planner v…` line in the estate's
`CLAUDE.md` — and no file was added to carry it. **Honored.**

**C9 — the alternatives are real.** Committing the bundle per consumer,
running the front door's carried build unpinned, and server-side
rendering with no build at all are each a plausible different choice with
a stated cost. This is a decision, not a default. **Honored.**

## Determination

**satisfied.** Every deterministic half of the Choice is present and
mechanical: the bundle is committed payload, converge places it into the
estate in the same pass that stamps the estate's version, the estate's
own ignore file keeps it out of the repository and out of the source
graph, and the serving program has no retrieval path — only a local
lookup that prefers the estate's copy.

Three things an adversarial reader should have on the record, none of
which defeats the Choice as written:

- **C1's enforcement is a ceremony instruction, not a gate.** The guard
  after the build tests only that `dist/index.html` exists — a condition
  a leftover bundle from the previous release satisfies — so a release
  whose build silently failed would ship a stale bundle rather than stop.
  The prose says to report and stop; that is agentic, like the version
  bump beside it, and consistent with how the rest of that ceremony is
  enforced.
- **C4's positive half degrades rather than fails when no build has been
  placed.** A project with no `.ok-planner/browser/` is served the front
  door's carried build — which is the alternative this decision refuses —
  announced both on the terminal and in the page's own header. Today that
  is every consumer, because C5's population is empty; it resolves for
  each project at its next convergence and cannot recur once releases
  carry builds.
- **Converge's diagnose now reports a missing, unstamped, stale, or
  drifted estate build, not merely a missing one.** This closes a gap the
  prior pass recorded as a live limit rather than a breach — read directly
  against the new code rather than carried: diagnose recomputes
  `browser_stamp()` over both the carried payload's build and the placed
  estate copy and compares each against the stamp file, distinguishing "no
  build placed" from "a build placed but never stamped" from "the placed
  build is an earlier version's" from "the placed build no longer matches
  its own stamp" (bytes changed in place after placement). None of the four
  findings blocks anything — diagnose only reports, and the next converge
  overwrites the build wholesale regardless of which finding fired — so
  this strengthens visibility into C1/C2 without changing what either
  clause requires.

## Notes

- note: `.ok-planner/design/concepts/estate.md` (What it is / Boundaries) was amended to add a general content kind — "the machine-local content a family's own ignore file excludes from the repository (a build its administration placed, a measurement one of its runs left)" — naming this decision's own mechanism (the fetched build, ignored by git rather than committed) as its first worked example. No citation here covers the concept file, and this decision's Choice and Rationale are exactly the "a build its administration placed" instance the new sentence generalizes from.
  adjudication: promoted — read against the concept's own Boundaries paragraph rather than the diff alone: the new sentence generalizes a content kind ("machine-local content a family's own ignore file excludes from the repository") and names as its first worked example exactly this decision's mechanism (a build the administration placed). The concept does not narrow or contradict anything C3 or C9 claims — it corroborates C3's "ignored by git rather than committed" and C9's rejected "committing the bundle per consumer" alternative from the corpus's general-model side, and adds no new obligation this decision must additionally satisfy (the concept states no invariant about builds specifically; it only classifies the kind). Now carried under Citations as `cite-file: .ok-planner/design/concepts/estate.md @ sha256:afc2da6d39e9` and `cite: .ok-planner/design/concepts/estate.md :: "the machine-local content a family's own ignore file excludes from the repository (a build its administration placed, a measurement one of its runs left)"`.

**What would have to change for this to stop holding.** The release step
being dropped or its output ceasing to be committed (C1); converge
placing the build in a pass that does not stamp the version, or ceasing
to place it at all (C2); `browser/` leaving the estate's ignore file, or
the bundle being written outside the estate, either of which makes it
repository content (C3); any network retrieval appearing in the serving
program, or the estate's copy losing its precedence over the payload's
(C4).

## Citations

- cite-node: plugins/ok/families/ok-planner/admin/converge @ sha256:a75d56bfab1e
- cite: plugins/ok/families/ok-planner/admin/converge :: "BROWSER_BUILD="${SCRIPT_DIR}/../browser/dist""
- cite: plugins/ok/families/ok-planner/admin/converge :: "cp -R "${BROWSER_BUILD}/." "${OK_DIR}/browser/""
- cite: plugins/ok/families/ok-planner/admin/converge :: "sed "s/{{OK_PLANNER_VERSION}}/${SUITE_VERSION}/g" "$TEMPLATE" > "${OK_DIR}/CLAUDE.md""
- cite: plugins/ok/families/ok-planner/admin/converge :: "sed "s/{{OK_PLANNER_VERSION}}/${SUITE_VERSION}/g" "$CORPUS_VIEW" > "${OK_DIR}/bin/corpus-view""
- cite: plugins/ok/families/ok-planner/admin/converge :: "sed "s/{{OK_PLANNER_VERSION}}/${SUITE_VERSION}/g" "$ESTATE_GITIGNORE" > "${OK_DIR}/.gitignore""
- cite: plugins/ok/families/ok-planner/admin/converge :: "findings+=("missing: .ok-planner/browser/ (the corpus view's build for v${SUITE_VERSION})")"
- cite: plugins/ok/families/ok-planner/admin/converge :: "browser_stamp() {  # browser_stamp <build-dir>"
- cite: plugins/ok/families/ok-planner/admin/converge :: "browser_stamp "$BROWSER_BUILD" > "${OK_DIR}/browser/${BROWSER_STAMP_NAME}""
- cite-file: plugins/ok/families/ok-planner/scripts/ok-planner-gitignore @ sha256:6e2b32d8b092
- cite: plugins/ok/families/ok-planner/scripts/ok-planner-gitignore :: "browser/"
- cite-node: .claude/skills/release/SKILL.md#release-cut-an-ok-plugins-suite-release.procedure.5a-build-the-corpus-view-s-frontend-do-not-skip @ sha256:65f45c50bf1c
- cite: .claude/skills/release/SKILL.md :: "(cd plugins/ok/families/ok-planner/browser && npm ci --silent --no-audit --no-fund && npm run build)"
- cite-node: plugins/ok/families/ok-planner/scripts/corpus-view @ sha256:c985b50ad376
- cite-span: plugins/ok/families/ok-planner/scripts/corpus-view :: "def find_bundle(root, override):" +10 sha256:9851185cbd73
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "if cand and os.path.isfile(os.path.join(cand, "index.html")):"
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "out.append("note: no build in this project's estate — serving the ""
- cite-file: .ok-planner/design/concepts/estate.md @ sha256:afc2da6d39e9
- cite: .ok-planner/design/concepts/estate.md :: "the machine-local content a family's own ignore file excludes from the repository (a build its administration placed, a measurement one of its runs left)"
