# Subjects and practices — the authoring rules

Canonical definitions of ok-plumbline's two durable artifact kinds:
**subject** and **practice**. This file is the single source of truth
for how they are written; the cheatsheet summarizes it and the ceremony
surfaces reference it. Materialized into consumer projects at
`.ok-plumbline/practice-definitions.md`.

These artifacts record **what a codebase does**, not what ok-plumbline
opines. The methodology's universal opinions live in the cheatsheet; a subject and its practices are this project's own,
authored by its owner through the planning ceremony like any other
durable artifact.

## Subject

A **subject** is a named, enumerable population of constructs in this
codebase that the project has something to say about. Its members share
a need; what the project does about that need is what its practices
state.

**The bar is enumeration.** A subject is admissible only if a reader
can list its members — from the filesystem, from a declaration, from an
interface's implementors, from a grep whose result is exhaustive rather
than indicative. A population nobody can list carries no coverage
claim, and a coverage claim is the only thing a subject is for. If you
cannot say how to enumerate it, you do not yet have a subject; you have
a topic.

**A subject says nothing about policy.** It defines the set. What
should be true of the set is the territory of its practices, and a
subject body that reaches for "should" has crossed into one.

**A subject is not a concept.** A concept says what a kind of thing
*is*, at the altitude of the product's own model. A subject says which
constructs *in this codebase* are to be accounted for. Same word may
appear in both; the altitude differs.

### Subject template

Write each subject to `.ok-plumbline/subjects/<slug>.md`.

```markdown
---
subject: <slug>
---

# <Subject name>

## What it is

<The population, in a sentence or two. What makes a construct a member
and what excludes one. No policy — only membership.>

## How to find them

<How a reader enumerates the members from the codebase as it stands: a
declaration to read, a directory to walk, an interface whose
implementors are the set, a search whose result is exhaustive. Someone
must be able to follow this and arrive at a count.>
```

## Practice

A **practice** is an affirmative statement of what this codebase does
about some members of a subject: what the code is, the condition under
which the practice governs, and the maintenance operation it buys.

**Every practice is affirmative.** There are no prohibitions and no
exemptions. A site that departs from one practice is governed by
another — a different practice whose condition covers it — and citing
that other practice is what a departure looks like. Nothing silences a
check without asserting something in its place, because an exemption
marker asserts nothing and so can never be wrong.

**Every practice names its condition.** A reader meeting a member of
the subject must be able to tell which of its practices applies without
asking the author. Where more than one condition matches, the more
specific one governs. Two equally specific conditions that conflict are
a **collision** — the owner's question, not a precedence puzzle to
settle by ordering or recency.

**Every practice names what it buys**, concretely enough that a reader
can settle whether that operation actually holds: a change that now
happens in one place instead of many, a class of defect a compiler or a
search can now find, a question answerable without reading the
implementation. A practice whose benefit only taste can settle is a
style preference and belongs to formatting, not here.

**Practices are cited from the sites they govern.** The citation is
`@practice: <slug>` on its own comment line, in the strict citation
grammar the lint enforces — tag and slug, nothing else. A reader
meeting a construct then finds the practice that accounts for it
instead of re-deriving the intent, and an agent editing the file knows
which policy it is editing under.

### Practice template

Write each practice to `.ok-plumbline/practices/<slug>.md`.

```markdown
---
practice: <slug>
subject: <subject-slug>
---

# <Short practice title>

## Practice

<What this codebase does about the members it governs. One or two
sentences, affirmative and concrete.>

## When it governs

<The condition that selects the members this practice covers. Written
so a reader can apply it to a member and get a yes or a no.>

## What it buys

<The maintenance operation that gets cheaper, and how a reader would
settle whether it holds.>
```

## Coverage, gaps, and collisions

The practices covering a subject **account for its whole population**.
That is the claim a subject's audit checks, by counting:

- A member **no practice claims** is a **gap**. The subject asserts a
  population and the corpus has nothing to say about part of it. Gaps
  are the owner's question and reach the issue intake.
- A member **two practices claim under conflicting, equally specific
  conditions** is a **collision**. Also the owner's question, also the
  intake.
- A member a practice claims but which **departs from what that
  practice says** is a **violation**. A violation is not a question —
  the owner already ruled when the practice was written — so it is
  **remediation work**, carried by ordinary planning and never filed as
  an issue.

The one exception to that last rule is a site whose governing practice
**could only be established by tracing beyond the point of use**. There
the intent is not legible from the code, and illegibility is precisely
what an owner has to settle: it reaches the intake like a gap. The
escalation flag is the cost of determining the violation, never the
size of the fix.

## What these artifacts are not

- **Not lint rules.** A practice is read and applied by a reviewer with
  judgment. Where a practice happens to have a mechanical check, the
  project writes one and the lint config is authoritative; most will
  not, and that is expected rather than a shortfall.
- **Not a style guide.** Formatting, naming aesthetics, and prose
  quality are somebody else's file.
- **Not universal.** Nothing here is shipped as a default. A subject
  and its practices describe one codebase, authored by its owner.

<!-- Materialized by ok-plumbline v19.1.0 — suite-owned; overwritten on converge; do not hand-edit. -->
