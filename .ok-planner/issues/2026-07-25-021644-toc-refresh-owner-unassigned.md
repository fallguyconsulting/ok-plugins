---
issue: toc-refresh-owner-unassigned
kind: discover
category: unspecified
artifacts:
  - concept:catalog-toc
status: verified
opened: 2026-07-25T02:16:44Z
---

# Nothing owns regenerating the catalog TOCs after a sprint's deltas

Each design catalog (concepts, stories, decisions) has a generated one-file table of contents whose header claims it is "refreshed whenever a sprint's deltas touch the catalog." No skill actually does that. `discover-design` generates the TOCs once at bootstrap; the compliance reviewer *checks* TOC-vs-directory consistency after the fact; but no step of applying a sprint delta regenerates anything. A delta that adds, amends, or retires an artifact leaves its TOC stale until some later audit happens to flag the mismatch — and the TOCs are what other skills read to know the corpus without reading every file, so a stale one quietly misinforms every downstream consumer.

`concept:catalog-toc` assigns only the checking ("TOC consistency is checked by the corpus audit") and names no regeneration owner or trigger. The estate's sprint-execution text says "apply each corpus delta as part of the work that realizes it" — arguably broad enough to cover the TOC as part of "applying," but nothing says so.

## Options

- **Name delta application as the trigger** — one sentence in `concept:catalog-toc`'s Invariants: applying a delta that touches a catalog regenerates that catalog's TOC in the same act. The executor owns it; audit remains the backstop. Minimal change, matches where the knowledge already almost lives.
- **Fold it into the sprint boilerplate** — amend the "How to execute" text every sprint carries. Reaches executors directly but adds a line to every future sprint for a rule the corpus could state once.
- **Read the existing "apply the delta" text as already covering it** — no change; leaves the ambiguity that produced this issue.

The ruling decides: who regenerates a touched catalog's TOC, stated where.

## Ruling

> Recommended ruling (/verify-issues): name delta application as the trigger — a sprint delta adds the invariant to `concept:catalog-toc` (a delta touching a catalog regenerates that catalog's TOC as part of applying the delta), leaving audit as the consistency backstop.
>
> Rationale: the regeneration belongs to the act that invalidates the TOC — any later owner reintroduces a stale window by construction. One corpus sentence closes the gap without growing the sprint boilerplate, and the header's existing "refreshed whenever a sprint's deltas touch the catalog" claim becomes true instead of aspirational.

<!-- Owner: this is a recommendation, not your decision. Leave it
as-is to accept — the next /plan-sprint carries it, naming the
generated/recommended batches at sign-off. Edit the text to
redirect, empty the section to discuss live, or delete this note
to adopt the ruling as your own. -->
