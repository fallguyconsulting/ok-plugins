---
audit: prove-audit-audience-split
artifact: decision:prove-audit-audience-split
determination: violated
audited: 2026-07-27T12:26:54Z
artifact-hash: sha256:183e13ed8f4b
issue: audit-verb-intake-channel
---

# Does the proof run report to the agent while the audit files to the human?

## Claims

**Title — "Prove reports to the agent; audit files to the human."** The first
half is true; the second is false. The audit verb files nothing to anyone: its
frontmatter description reads "A pure reporter: findings return in-context,
nothing is written."

**Choice clause 1 — "The two corpus-checking verbs have disjoint audiences and
channels."** The population is two verbs, `prove` and `audit`, enumerated from
the family's skill directories and from the converge core's map of what a
consumer receives. Audiences are indeed distinct — prove's report is consumed
by the executing agent, audit's by its caller — but the *channels* are not
disjoint: both return in-context to their caller and neither writes.

**Choice clause 2 — "the proof run produces work items for an agent — a
structured in-context report the executing agent triages, never writing the
issue intake."** Honored, and doubly so: the never-writes sentence stands in
the prove verb's body and its frontmatter, the report's shape is fixed, and a
repository maintenance assertion registered under this decision's own
`@decision:` annotation keeps the sentence from being quietly deleted.

**Choice clause 3 — "while the audit produces work items for a human, filing
judgment findings to the intake and handing mechanical ones back to the
caller."** Not honored. The audit is a declared pure reporter: its process
begins "Create nothing. This verb is read-only against the project", its
`mechanical`/`judgment` class is explicitly "advisory context for whoever
consumes the report, never routing", its report step says "The caller decides
what happens next; the audit routes nothing", and its NOT-do list closes "Does
not touch the issue intake — no filing, no editing, no closing." Only the
second half of the clause — mechanical findings handed back to the caller — is
true, and it is true of the judgment findings equally.

**Choice clause 4 — "A proof finding that turns out to need owner judgment
reaches the owner via the next audit catching the underlying corpus problem."**
Not honored: it describes a transport that does not exist. The audit catching
the corpus problem produces a report, not an intake entry. The path that does
exist runs through certification — a fixer kickback surviving the architect's
adversarial check — or through a human filing directly.

**Rationale — "an executing agent needs findings now, in context, at machine
tempo; an owner needs a durable, deduplicated agenda at calibration tempo.
Giving each verb one channel also makes the intake's meaning crisp."** The
first half holds for prove. The second is a property the audit does not
deliver: the durable, deduplicated agenda is assembled by the certification
loop's dedup step and by the architect's fingerprint check against the slugs
already in the intake, not by the audit. The conclusion the Rationale draws —
that the intake means "owner question, never agent chatter" — is true of the
project as it stands, but it is true because *no* reviewer files, which is a
different mechanism from the one the Choice records.

**Alternatives — "one verb doing both" and "both verbs writing the intake."**
Neither describes what shipped. The shipped shape is a third option the
artifact does not record: neither corpus-checking verb writes the intake, and
a single gated actor — certification's architect, or a human — is its only
writer.

**The sharpest evidence that this is stale text rather than an ambiguity.** The
maintenance check registered under this decision's own `@decision:` annotation
asserts the audit-side sentence "only the architect's confirmed forks are
promoted to `.ok-planner/issues/`" — the check that exists to guard the
decision guards the statement that refutes it.

## Determination

**violated.** The Choice is a two-sided claim and one side is contradicted by
the code as it stands. Prove's side is fully implemented and mechanically
asserted; the audit's side is not implemented at all. Consequently the title's
"audit files to the human" is false, "disjoint audiences and channels" is false
as to channels, "filing judgment findings to the intake" is false, the
proof-finding transport described in the last Choice sentence does not exist,
and the Rationale's "durable, deduplicated agenda" is delivered by the
certification loop rather than by this verb. The `mechanical`/`judgment`
classification the decision leans on survives, but the audit's own text demotes
it to advisory context that never routes — the opposite of the routing role the
Choice assigns it.

To flip this determination the Choice and Rationale must be brought to the
shape that ships: both corpus-checking verbs are pure in-context reporters with
different audiences (the executing agent for prove; the caller — human or
certification gate — for audit), and the intake has exactly one gated writer,
certification's architect after an adversarial check, with humans filing
directly. The alternative — implementing the decision as written by making the
audit file — would contradict the audit verb's declared pure-reporter posture,
`story:corpus-proof`'s counterpart clause, and the certification core's
"promotion is the loop's only path to the intake". Which way to resolve it
changes what the project commits to, so it is the owner's call, not this
audit's.

This violation is linked to intake issue `audit-verb-intake-channel`, which
puts exactly that fork to the owner; it stands until a ruling lands and a
re-audit flips it.

## Citations

- cite: plugins/ok/families/ok-planner/skills/prove/SKILL.md :: "never writes to the issue intake"
- cite-span: plugins/ok/families/ok-planner/skills/prove/SKILL.md :: "4. **Report** in-context, structured, one entry per in-scope story:" +26 sha256:830d6426400d
- cite: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "Audit is a **pure reporter**"
- cite: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "1. Create nothing. This verb is read-only against the project"
- cite: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "Does not touch the issue intake — no filing, no editing, no closing"
- cite: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "The caller decides what happens next; the audit routes nothing."
- cite: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "only the architect's confirmed forks are promoted to"
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "1. **Dedup.** Subtract findings already promoted"
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "**Promotion is the loop's only path to the intake, and the owner is never asked live.**"
- cite-span: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "3. **Architect.** If there are kickbacks" +3 sha256:e0451454796d
- cite: checks/text-presence :: "# @decision: prove-audit-audience-split"
- cite: checks/text-presence :: "only the architect's confirmed forks are promoted to"
- cite-file: plugins/ok/families/ok-planner/skills/audit/SKILL.md @ sha256:28563955e674
- cite-file: plugins/ok/families/ok-planner/skills/prove/SKILL.md @ sha256:3780a5429f89
