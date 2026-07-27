---
audit: sketch-an-idea
artifact: story:sketch-an-idea
determination: satisfied
audited: 2026-07-27T12:26:54Z
artifact-hash: sha256:ca2b58005c0f
---

# Can an idea be captured in one pass without touching the corpus, the intake, or any authorization path?

## Claims

**Title / Story — "capture a speculative idea in one pass, without triggering
planning or authorizing implementation, so that thinking is externalized and
revisitable at no ceremony cost."** Honored. The verb is declared single-pass
in its frontmatter and again in a dedicated section; the one permitted question
is the topic itself when the invocation did not carry it, and everything else is
an assumption recorded in the document rather than a stop.

**Acceptance 1 — "The owner names a topic → a single dated sketch document
lands among the project's live records."** Honored: one output at one dated
path, `.ok-planner/sketches/YYYY-MM-DD-<topic>-sketch.md`, stated at the head of
the skill and again at the write step, with today's date taken from `date`.
`sketches/` is a live records directory in the estate.

**Acceptance 2 — "containing the idea, its shape, open questions, and risks."**
The population is four named sections and the template carries exactly them:
`## Idea`, `## Shape`, `## Open questions`, `## Risks / unknowns` (plus an
optional `## What this is not`). Honored.

**Acceptance 3 — "stamped as not a sprint and not authorization to build."**
Honored verbatim: the template's status line is "**Status:** Sketch (not a
sprint; not authorization to build)".

**Acceptance 4 — "the durable corpus and the intake queue are untouched."**
Honored twice, once as a rule inside the context step ("Open questions about a
concept's boundary go in the sketch's `## Open questions` section, not as
silent assumptions — and not into the issue intake … a sketch is speculative;
it does not file design issues") and once as a flat prohibition in the NOT-do
list ("Does not write to `design/` or file into `.ok-planner/issues/`"). The
only write outside `sketches/` is the layout `mkdir -p .ok-planner/sketches`,
which touches neither.

**Acceptance 5 — "the session ends at the sketch without chaining into
planning."** Honored at three points: the upgrade rule ("finish the sketch
first, then suggest `/plan-sprint` … Do not silently upgrade"), the report step
("Then end the turn. Do not chain into other skills"), and the NOT-do list
("Does not invoke `/plan-sprint` or any implementation skill").

**Acceptance 6 — "The sketch skill is the real producing component."** Honored:
it is a real skill with a full body and template, carried into consumer
projects by the converge core's `SKILLS` map.

**Falsifier — capture mutating the corpus or queue; a silent upgrade into
planning or implementation; the capture demanding dialogue and review.** Each
is the negation of a stated rule above; the third is met by the single-pass
declaration and the absence of any review loop in the process.

**Proof — "a sketch produced from a one-line topic that a third party can read
as a thinking record, verifiably absent from the durable corpus, the queue, and
any authorization path."** The story is annotated in `test/proofs.sh`. The
harness instantiates the verb's own template from a one-line topic into a
fixture estate, then asserts: the dated sketch exists at the documented path;
it carries the not-authorization stamp verbatim; it carries all four mandated
sections; and — by a before/after file listing that excludes only
`sketches/` — that `design/`, `issues/`, and `sprints/` are byte-for-byte
untouched. It closes by asserting the verb still states the prohibition the
fixture exhibits, so the model and the modelled text cannot drift apart. All
assertions pass on the current tree. The authoring itself is prompt-realized —
a template instantiation is not a written sketch — and the harness says so at
that assertion; what remains checkable is the shape that makes a sketch
readable as a thinking record, and the three absences.

## Determination

**satisfied.** Every Acceptance clause and every Falsifier condition has a
specific, citable enforcement point in the sketch verb — the dated path, the
four mandated sections, the verbatim status stamp, the double-stated
prohibition on writing the corpus or the intake, and the no-chaining rule with
its explicit "do not silently upgrade" — and the verb is vendored to consumers.
The story now carries an annotated proof that exercises the deterministic core
of its `Proof:` field, including the three-way absence that is the story's real
promise.

The limit, non-determinative: the sketch the harness produces is the template
instantiated, not a sketch an agent wrote, so "a third party can read it as a
thinking record" is exhibited as structural shape rather than as authored
content. That conjunct is inherently agentic, and the harness names it as such
at the assertion.

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
- cite-span: plugins/ok/families/ok-planner/admin/converge :: "SKILLS = {" +12 sha256:e48536a36db6
- cite-span: plugins/ok/families/ok-planner/test/proofs.sh :: "# --- sketch-an-idea" +38 sha256:e7f922789c0f
- cite-file: plugins/ok/families/ok-planner/skills/sketch/SKILL.md @ sha256:94e0b079094b
- cite-file: plugins/ok/families/ok-planner/test/proofs.sh @ sha256:f96535bcf843
