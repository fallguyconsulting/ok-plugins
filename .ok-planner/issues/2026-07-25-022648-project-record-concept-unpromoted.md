---
issue: project-record-concept-unpromoted
kind: discover
category: other
artifacts:
  - concept:estate
  - concept:sketch
  - concept:sprint
status: verified
opened: 2026-07-25T02:26:48Z
---

# Decide whether out-of-context project records deserve their own concept

## Problem

The three-way context discipline surfaced by discovery — source-of-truth design read freely, operational queue state folded on demand, records out of context by default with the executing sprint as the one exception — is load-bearing in live prose, but the extraction spread it across estate, sketch, and sprint Boundaries; no artifact owns the 'record' noun or the archive rule that rides with it.

## Candidates

- Promote a project-record concept owning the record/context discipline and the archive rule
- Amend concept:estate to own the three content kinds and their context rules explicitly

## Discussion

**The question.** A three-way context discipline — durable design read freely, operational intake state folded on demand, records out of context by default (except the sprint currently being executed) — is load-bearing in live prose but no single artifact owns the "record" noun or the archive rule that travels with it. Should that get its own concept, or should `concept:estate` be amended to own the three-way split explicitly?

**Where the discipline is currently spread, re-verified:**
- `concept:estate`'s Boundaries says only: "Content kinds inside the planner's estate carry distinct context rules — source-of-truth design, operational queue state, and out-of-context records (see also: design-corpus, issue, sprint)" — a one-line pointer, not an owned definition.
- `concept:sketch`'s Boundaries: "Sketches are project records, out of context by default like other records," and its Invariants: "When taken up for real or abandoned, a sketch moves to the archive per file, not wholesale" — a record-specific archive rule stated locally, on the sketch concept, not as a general "record" property.
- `concept:sprint`'s Boundaries: "While being executed it is the one project record allowed in context," and its Invariants: "A sprint archives only once it certifies clean; an uncertified sprint stays in flight" — again, the general "records archive on completion/retirement" rule is stated as a sprint-specific fact.
- `concept:design-corpus` doesn't use "record" at all — it defines the opposite category (source-of-truth, read freely), which is useful as the contrast case but doesn't claim to own the record discipline either.
- The `.ok-planner/CLAUDE.md` project-side estate doc (materialized, not itself a design artifact) spells out the full three-way discipline in prose — "Do not consult these files to understand the project... Do not include them in general repository exploration... Do not edit, rename, move, or delete files here on your own initiative" — which is exactly the kind of durable, general property a concept is supposed to state once so materialized docs and code can cite it, rather than restate it themselves.

So: the *rule* ("out of context by default, with one live exception, with archival on completion/retirement") is stated at least three separate times, once per artifact that happens to have a record kind, with no shared definition any of them cites.

**What the corpus says about whether this is intentional.** Nothing states it. `concept:estate`'s "(see also: design-corpus, issue, sprint)" is a genuine attempt at a fold-pointer, but it names the three *neighbor* concepts without saying "and this is where the shared record discipline canonically lives" — a reader following the pointer finds three separate concepts each stating their own slice, not one place stating the general rule.

**What a promoted `project-record` concept would own, if created.** The general property "out of context by default; read only when a directing goal or an ok-planner skill calls for it; archives on completion/retirement, indefinitely, files moved not rewritten" — stated once, with `sketches/`, `history/`, and the non-executing view of `sprints/` as satisfying instances (named in Boundaries, not enumerated as an instance list, per the self-containment rule's concept-vs-decision line). It would explicitly NOT own: what a sketch is, what a sprint is, or the design corpus's contrasting "read freely" rule — those stay with their own concepts, cross-referencing the new one.

**Candidates and their tradeoffs, undecided:**
- *Promote a project-record concept*, owning the record/context discipline and the archive rule, re-pointed from `estate`, `sketch`, and `sprint`. Gives the discipline one place to change if it ever does (e.g., a future record kind added), and matches the weight the discipline already carries in the materialized `.ok-planner/CLAUDE.md` prose. Is a fourth concept in a cluster (`estate`, `design-corpus`, `sketch`, `sprint`, now `project-record`) that a reader has to hold together to understand the estate's shape — more surface area for a five-piece picture that today reads, if diffusely, from three files.
- *Amend `concept:estate` to own the three content kinds and their context rules explicitly.* `concept:estate` is already the natural single home — it's the concept that says "an estate is rooted here, containing X" — and the Purpose section already frames absence/presence as meaningful state, a kindred idea. But it would make `concept:estate` carry both *what an estate is* (a committed dot-directory) and *the full context-handling discipline for everything inside it*, arguably crossing from "what kind of thing is this" into "how should an agent behave around this," which is closer to conduct/procedural material than most concept bodies carry today.

**What the ruling must decide.** Whether the out-of-context-by-default record discipline (with its one-exception and archive rule) becomes its own `project-record` concept that `estate`, `sketch`, and `sprint` point to, or is folded explicitly into `concept:estate` as the single owning artifact.

## Ruling

<!-- Owner: write your decision here in your own words.
The next /plan-sprint picks it up. Leave empty to discuss
it live in a planning session instead. -->
