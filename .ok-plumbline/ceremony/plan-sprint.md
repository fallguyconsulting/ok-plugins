# ok-plumbline — planning ceremony contribution

What the suite's planning ceremony does about this family's estate.
Materialized into consumer projects at
`.ok-plumbline/ceremony/plan-sprint.md`; the ceremony reads it there
when `.ok-plumbline/` exists.

## Requires

`.ok-plumbline/` at the project root. The subject and practice
collections live at `.ok-plumbline/subjects/` and
`.ok-plumbline/practices/`; the front door's administration (`/ok`)
materializes them.

## Vocabulary

Read `.ok-plumbline/practice-definitions.md` before authoring anything
in this family's corpus. It is the single source of truth for what a
**subject** and a **practice** are, what each body must carry, and how
gaps, collisions, and violations differ. This contribution never restates
it.

## Draft

This family's corpus deltas are subjects and practices, and they take
the same shape as any other corpus delta — new, amend, or retire, each
carrying the complete final-form body, resolved fully during planning,
with the sprint's sidecar folder available where bodies run long.

Two authoring rules bear on drafting and are worth surfacing to the
owner in the session rather than at review:

- **A subject is admissible only if its members can be enumerated.** If
  the owner cannot say how a reader would list them, the artifact is
  not ready — say so and work the enumeration out together, rather than
  drafting a population nothing can count.
- **A departure is a competing practice, never an exemption.** When the
  owner describes an exception, draft it as a second practice over the
  same subject with its own condition and its own benefit. If that
  cannot be written affirmatively, the exception is not understood yet.

New subjects and practices are also, always, a coverage question: a
subject drafted without practices covering its whole population ships a
gap by construction. Name that to the owner while drafting, so the
covering practices land in the same sprint or the gap is a deliberate
choice rather than an oversight.

Each collection carries a generated catalog table of contents beside
it — `.ok-plumbline/subjects.md` and `.ok-plumbline/practices.md` — and
a delta that adds, amends, or retires an artifact makes its catalog's
TOC stale. Regenerating it is part of applying the delta, never a
separate chore, and it is one command:

```bash
python3 .ok-plumbline/bin/catalog-toc
```

A TOC is generated, never hand-written: editing one by hand is a change
the next run silently discards.

## Resolve

Two kinds of open question from this family's coverage runs reach the
intake and may bear on the drafted work: **gaps** (a member of a
subject no practice claims) and **collisions** (a member two equally
specific practices claim under conflicting conditions). Both are
ordinary intake issues and are walked exactly like any other.

A **violation** is never an issue and never appears here; it is
remediation work, and the way it enters a sprint is as a work item like
any other.

## Boundaries

- Contributes no lint rules and no methodology opinions. The
  cheatsheet's universal conventions are not corpus artifacts and are
  never drafted as deltas.
- Never authors a subject or practice on the owner's behalf: which
  policies this codebase follows is exactly what the ceremony is for.

<!-- Materialized by ok-plumbline v18.6.1 — suite-owned; overwritten on converge; do not hand-edit. -->
