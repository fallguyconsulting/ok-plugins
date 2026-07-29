---
audit: sketch-an-idea
artifact: story:sketch-an-idea
determination: satisfied
audited: 2026-07-28T22:40:00Z
artifact-hash: sha256:ca2b58005c0f
---

# Can an idea be captured in one pass without touching the corpus, the intake, or any authorization path?

## Claims

**Title / Story — "capture a speculative idea in one pass, without triggering
planning or authorizing implementation, so that thinking is externalized and
revisitable at no ceremony cost."** Honored. The verb is declared single-pass
in its frontmatter and again in a dedicated section; the one permitted question
is the topic itself when the invocation did not carry it, and everything else
is an assumption recorded in the document rather than a stop ("Make reasonable
assumptions as you write, and record them in the **Open questions** section
rather than stopping to ask").

**Acceptance 1 — "The owner names a topic → a single dated sketch document
lands among the project's live records."** Honored: one output at one dated
path, `.ok-planner/sketches/YYYY-MM-DD-<topic>-sketch.md`, stated at the head of
the skill and again at the write step, with today's date taken from `date
+%Y-%m-%d`. `sketches/` is a live records directory in the estate, created by
converge and by the skill's own `mkdir -p`.

**Acceptance 2 — "containing the idea, its shape, open questions, and risks."**
The population is four named sections, and the template carries exactly them:
`## Idea`, `## Shape`, `## Open questions`, `## Risks / unknowns` — plus an
optional `## What this is not`, which adds nothing the clause forbids. Honored.

**Acceptance 3 — "stamped as not a sprint and not authorization to build."**
Honored verbatim: the template's status line is "**Status:** Sketch (not a
sprint; not authorization to build)", and the skill carries a whole section
titled "A sketch is not a sprint" restating it in prose.

**Acceptance 4 — "the durable corpus and the intake queue are untouched."**
Honored twice, once as a rule inside the context step ("Open questions about a
concept's boundary go in the sketch's `## Open questions` section, not as
silent assumptions — and not into the issue intake … a sketch is speculative;
it does not file design issues") and once as a flat prohibition in the NOT-do
list ("Does not write to `design/` or file into `.ok-planner/issues/`"). The
write surface was re-enumerated from the five-step procedure rather than
trusted: the only writes are the sketch file itself and the layout `mkdir -p
.ok-planner/sketches`, which touches neither `design/` nor `issues/`. The
context step reads `design/` but does not write it.

**Acceptance 5 — "the session ends at the sketch without chaining into
planning."** Honored at three points: the upgrade rule ("finish the sketch
first, then suggest `/plan-sprint` … Do not silently upgrade"), the report step
("Then end the turn. Do not chain into other skills"), and the NOT-do list
("Does not invoke `/plan-sprint` or any implementation skill").

**Acceptance 6 — "The sketch skill is the real producing component."**
Honored: it is a real skill with a full body and template, and it appears in
the converge core's `SKILLS` map (re-checked this cycle; the core is unchanged
and its pinned span still verifies), so it is vendored into consumer projects
rather than existing only as payload.

**Falsifier — capture mutating the corpus or queue; a silent upgrade into
planning or implementation; the capture demanding dialogue and review.** Each
is the negation of a stated rule above; the third is met by the single-pass
declaration and by the absence of any review loop anywhere in the five-step
process.

**Proof — "a sketch produced from a one-line topic that a third party can read
as a thinking record, verifiably absent from the durable corpus, the queue, and
any authorization path."** The story is annotated in `test/proofs.sh`. The
harness instantiates the verb's own template from a one-line topic into a
fixture estate, then asserts: the dated sketch exists at the documented path;
it carries the not-authorization stamp verbatim; it carries all four mandated
sections; and — by a before/after file listing that excludes only `sketches/` —
that `design/`, `issues/`, and `sprints/` are byte-for-byte untouched. It
closes by asserting the verb still states the prohibition the fixture exhibits,
so the model and the modelled text cannot drift apart.

Re-run this cycle against the current bytes: all five assertions pass and the
harness exits 0. The `sketch-an-idea` block is byte-identical to the one the
prior audit cited — its span hash is unchanged — so the harness edit this cycle
(a sharpening of another story's heredoc fixture, two seeded body lines and the
comment above them) did not touch it. The authoring itself is
prompt-realized — a template instantiation is not a written sketch — and the
harness says so at that assertion; what remains checkable is the shape that
makes a sketch readable as a thinking record, and the three absences, which are
the story's real promise.

Refreshed yet again this cycle, citation-only: `test/proofs.sh` moved once
more, from the owner-ratified cap-rewording exhibitions added to the
`certify-completion` story's section elsewhere in the file. The cited
`sketch-an-idea` span is byte-identical and still resolves.

## Determination

**satisfied.** Every Acceptance clause and every Falsifier condition has a
specific, citable enforcement point in the sketch verb — the dated path, the
four mandated sections, the verbatim status stamp, the double-stated
prohibition on writing the corpus or the intake, and the no-chaining rule with
its explicit "do not silently upgrade" — and the verb is vendored to consumers.
The annotated proof exercises the deterministic core of the `Proof:` field
against a real fixture, including the three-way absence, rather than asserting
it as text.

Re-derived, not carried: this audit went stale for exactly one mechanical
reason — the whole-file pin on `test/proofs.sh` moved when another story's
heredoc fixture was sharpened elsewhere in the file. The harness was re-read and
re-run rather than assumed; the block this audit rests on is unchanged
byte-for-byte and every assertion passes. The sketch verb itself was untouched
this cycle — its whole-file pin still verifies, as does the converge core's — so
every Acceptance finding above stands on the same evidence as before.

Refreshed again this cycle, for two further reasons, both outside this
claim's territory. `test/proofs.sh` gained per-story timing instrumentation
(a `section`/`emit_timing` helper pair) whose only touch inside the cited
`sketch-an-idea` span is one inserted `section sketch-an-idea` marker line
right after the header — the other 37 lines are byte-identical and both
assertions still run. `admin/converge`'s `SKILLS = {` dict gained one new
unrelated entry (`"browse": "browse",`, for the sprint's new corpus-view
skill) inserted ahead of `"sketch": "sketch",` — the sketch entry this claim
rests on is still present, still maps to itself, and the span still spans
it. Citations re-pinned; both re-run clean.

The limit, non-determinative: the sketch the harness produces is the template
instantiated, not a sketch an agent wrote, so "a third party can read it as a
thinking record" is exhibited as structural shape rather than as authored
content. That conjunct is inherently agentic, and the harness names it as such
at the assertion.

Refreshed once more this cycle, citation-only: `test/proofs.sh` gained a
new `trace-corpus-to-code` section elsewhere in the file (a decision
fixture with its own audit and new assertions), moving only the whole-file
pin. The cited `sketch-an-idea` span is byte-identical and still resolves;
both assertions re-run clean.

Refreshed yet again this cycle, citation-only: `test/proofs.sh` moved once
more from unrelated conjunct growth elsewhere in the file. The cited
`sketch-an-idea` span and the converge core's `SKILLS` span are both
byte-identical and re-verify; both assertions re-run clean.

This determination stops holding if: the documented save path or the date
component changes without the harness following; the status stamp is reworded
(the grep breaks first); a template section is dropped or renamed; the
prohibition on writing `design/` or the intake is softened, or the verb gains
any write outside `sketches/`; the no-chaining rule or the single-pass
declaration is removed, so the capture can upgrade itself; the verb leaves the
converge `SKILLS` map; or `test/proofs.sh` loses its `sketch-an-idea` block or
its `@story:` annotation — in particular the before/after listing, without
which the three absences are asserted by nothing.

## Citations

- cite: plugins/ok/families/ok-planner/skills/sketch/SKILL.md :: "**Save sketches to:** `.ok-planner/sketches/YYYY-MM-DD-<topic>-sketch.md`"
- cite-span: plugins/ok/families/ok-planner/skills/sketch/SKILL.md :: "## Sketch template" +28 sha256:94545cace9c3
- cite: plugins/ok/families/ok-planner/skills/sketch/SKILL.md :: "**Status:** Sketch (not a sprint; not authorization to build)"
- cite: plugins/ok/families/ok-planner/skills/sketch/SKILL.md :: "- Does not write to `design/` or file into `.ok-planner/issues/`"
- cite: plugins/ok/families/ok-planner/skills/sketch/SKILL.md :: "- Does not invoke `/plan-sprint` or any implementation skill"
- cite-span: plugins/ok/families/ok-planner/skills/sketch/SKILL.md :: "5. **Report.** Tell the user the path" +3 sha256:ce1ae1875d80
- cite: plugins/ok/families/ok-planner/skills/sketch/SKILL.md :: "This skill runs single-pass."
- cite-span: plugins/ok/families/ok-planner/admin/converge :: "SKILLS = {" +12 sha256:8aa7cd5969fb
- cite: plugins/ok/families/ok-planner/test/proofs.sh :: "# @story: sketch-an-idea"
- cite-span: plugins/ok/families/ok-planner/test/proofs.sh :: "# --- sketch-an-idea" +38 sha256:596fd2106a1c
- cite-node: plugins/ok/families/ok-planner/skills/sketch/SKILL.md @ sha256:94e0b079094b
- cite-node: plugins/ok/families/ok-planner/test/proofs.sh @ sha256:10f3b1e855fd
