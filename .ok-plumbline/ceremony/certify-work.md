# ok-plumbline — certification ceremony contribution

What the suite's certification gate does about this family's estate.
Materialized into consumer projects at
`.ok-plumbline/ceremony/certify-work.md`; the ceremony reads it there
when `.ok-plumbline/` exists.

## Requires

`.ok-plumbline/` at the project root. The lint binary is at
`.ok-plumbline/bin/plumbline`; the corpus, where the project has one,
is at `.ok-plumbline/subjects/` and `.ok-plumbline/practices/`.

## Producers

Three, each at change scope.

### The lint, over the changed files

```bash
node .ok-plumbline/bin/plumbline <changed paths>
```

Exit 0 clean, 2 violations, 1 internal error. Every violation is an
ordinary finding for the ceremony's loop. The edit hook already blocks
most of these in the turn that wrote them, so a violation reaching here
is one that arrived some other way — a file written outside the hook's
reach, or a config change that widened what the lint sees.

### Practice citation, over the constructs the change touched

This is the producer that keeps the practice corpus honest as code is
written, and it is why the corpus is coupled to review rather than to a
periodic sweep alone: **when new code is written, the agent knows what
it is writing.** Ten minutes later nobody does, and a coverage run has
to trace for it.

For each construct the change introduced or touched, ask whether a live
subject's population claims it — read the subjects' **How to find them**
sections and apply them to the change. For each construct a subject
claims:

- **It carries a `@practice:` citation, and the cited practice's
  condition covers it** → nothing to report.
- **It carries no citation** → a finding. The fix is part of the same
  change: pick the practice whose condition covers this construct and
  cite it. Citing is not paperwork — it is the assertion that this
  construct is governed by that policy, and it is what a later reader
  and a later coverage run both read.
- **It carries a citation whose practice does not cover it** → a
  finding: either the citation is wrong or the construct is, and the
  change is where that is cheap to settle.
- **No practice's condition covers it** → a **gap**, and gaps are the
  owner's question. The fixer does not invent a practice to close one;
  it is a genuine fork, and the ceremony's architect routes it.

Citation lines follow the strict grammar the lint enforces:
`@practice: <slug>` on its own comment line, tag and slug and nothing
else. The tag resolves only where the project has declared it in
`.ok-plumbline/config.json`; a project that has not made that
declaration has no practice citations to check, and this producer says
so in one line and contributes nothing.

A project with no subjects contributes nothing here either. That is an
ordinary state — the corpus is opt-in and grows as the owner authors
it — and never a finding.

### The mechanical floor (inline, no subagent)

Each collection's catalog table of contents matches the collection it
indexes:

```bash
python3 .ok-plumbline/bin/catalog-toc --check
```

Exit 2 names the stale TOC. The fix is to regenerate it, which is
mechanical by construction — the TOC is derived from the artifacts, so
nothing the project commits to changes by bringing it current.

## Routing

This family holds no intake. Gaps and collisions its producers surface
route through the ceremony's loop like every other finding, and reach
the owner's agenda only through the paths the ceremony's architect and
cap escalation use. **Violations never become issues**: a practice that
has been ruled poses no question, so a departure from it is remediation
work the loop's fixer takes, or a work item for a later sprint.

## Boundaries

- Offers nothing at close-out: it has no artifact to archive.
- Never edits `.ok-plumbline/config.json`. Citation tags are
  owner-declared configuration, transcribed by the front door's
  administration on an explicit yes.
- Never sweeps the repository. Whether the corpus's practices reached
  the whole of their subjects is the periodic `/audit` run's question.

<!-- Materialized by ok-plumbline v18.4.1 — suite-owned; overwritten on converge; do not hand-edit. -->
