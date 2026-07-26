---
issue: activation-class-rule-unstated
kind: discover
category: unspecified
artifacts:
  - decision:slash-only-activation
  - concept:skill
status: verified
opened: 2026-07-25T02:16:44Z
---

# No stated rule decides which activation class a new skill belongs to

## Problem

The split between explicit-activation skills and descriptive plumbing skills is consistent in practice but stated nowhere; the two same-named compliance verbs even sit in different classes (one carries the phrase, the other does not) for no stated reason.

## Candidates

- Amend concept:skill Boundaries with the classification rule for activation classes
- Amend decision:slash-only-activation Choice to enumerate the criteria for dropping the phrase

## Discussion

**The question.** When a new skill is added to the suite, what decides
whether its description carries the "ONLY activated by explicit slash
command... never auto-triggered by conversation content" phrase (the
user-facing class, sometimes naming one additional non-human activator) or
drops it (the plumbing class)? No artifact states a test a skill author
could apply — the Problem observes that the split holds in practice but is
unstated, and that one skill name shipped by more than one plugin,
`audit`, lands in different classes with no stated reason.

**Where this comes from, re-verified.** The corpus predates a layout change
— the issue intake moved from a single `issues.jsonl` to one file per issue
under `.ok-planner/issues/`, and a `/verify-issues` skill was added — but
that migration doesn't touch the evidence here, which is about `SKILL.md`
frontmatter, not the intake format. Re-checked directly against the current
files, the Problem's claims hold exactly as filed:

- `plugins/ok-planner/skills/audit/SKILL.md` — `"ONLY activated by explicit
  /audit slash command or by whoever is executing a sprint's completion
  contract — an inline session or an orchestrator. Never auto-triggered by
  conversation content."`
- `plugins/ok-workspaces/skills/audit/SKILL.md` — `"ONLY activated by
  explicit /audit slash command. Never auto-triggered by conversation
  content."`
- `plugins/ok-plumbline/skills/audit/SKILL.md` — `"Audit the current project
  against the Plumbline lint. Runs the lint across the whole codebase,
  groups violations by check category and by file, and surfaces a
  remediation plan distinguishing mechanical fixes from structural issues.
  Read-only — proposes fixes; does not apply them."` — no activation-
  restriction phrase at all.

`audit` is the only skill name shipped by more than one plugin with
divergent phrasing. `true-up` is also shipped by three plugins (`ok-planner`,
`ok-workspaces`, `ok-plumbline`) and all three consistently omit the phrase,
each self-describing as plumbing "normally driven by /ok" (confirmed by
reading all three `true-up` `SKILL.md` files directly). So the split is not
generally inconsistent — only this one same-named pair diverges, exactly as
the Problem frames it.

**What the corpus says.** `decision:slash-only-activation`'s Choice states
the two-class split exists and gives the plumbing side's rationale:
"plumbing skills deliberately drop the restriction so the front door and
sibling skills can drive them through the skill tool." It does not state a
rule for classifying a *new* skill, and says so itself — its Proof section
reads "the class membership rule itself is stated nowhere. Filed to the
intake queue for owner calibration," i.e. this decision is the one that
generated this very issue and already anticipates it. `concept:skill`'s
Boundaries independently restates the same split ("user-facing skills
declare themselves activated only by their explicit slash command... and
plumbing skills drop that restriction so other machinery can drive them")
with the same gap: it describes that the split exists, not how to place a
new skill on either side of it. Neither artifact is silent by omission —
both describe the split and its consequence — but neither states a testable
criterion. (`concept:true-up`, read for background since `true-up` is the
consistent contrast case above, adds only that true-up "is always a user or
user-directed action — nothing in the suite runs it from a hook"; it doesn't
bear on the classification rule itself.)

**What the code does today.** The corpus's one stated plumbing-rationale —
"so the front door and sibling skills can drive them through the skill
tool" — does not hold for `ok-plumbline:audit`. `plugins/ok/skills/ok/SKILL.md`,
the front door, says twice that it never invokes `audit`: "`/ok` never
invokes work-driving verbs (`audit`, `prove`, `open`, …) — those belong to
humans and implementation orchestrators," and again in its "does NOT do"
list, "Does not run `audit`, `prove`, or any other work-driving verb." A
repo-wide search for `ok-plumbline:audit` turns up no skill invoking it
through the Skill tool anywhere in the suite — the only hits besides the
skill's own frontmatter are two documentation lines
(`plugins/ok-plumbline/docs/plumbline-cheatsheet.md`,
`plugins/ok-plumbline/docs/plumbline-porting-guide.md`) describing it as a
command the user types. So nothing machine-invokes `ok-plumbline:audit`
today — the corpus's only stated justification for dropping the phrase
doesn't apply to this instance. That leaves two readings open, not
resolved by anything in the corpus: either the skill is misclassified (it
should carry the phrase, matching its two same-named siblings that do), or
the plumbing-rationale as written is incomplete and there's a legitimate
reason for `ok-plumbline:audit` to stay plumbing that hasn't been written
down.

**Candidates developed.** The two filed candidates both name *where* the
rule would be written (`concept:skill` Boundaries vs.
`decision:slash-only-activation` Choice) without specifying *what* the rule
says — either could host any criterion the owner picks, including the one
below, so they aren't really competing shapes so much as competing
locations. A third, substantively distinct shape emerges from the evidence
itself: state the criterion as machine-callability — "a skill drops the
phrase iff some other skill or the front door invokes it through the Skill
tool; otherwise it carries the phrase." This is close to, but sharper than,
the decision's existing plumbing-rationale prose. Adopting it has a direct,
checkable consequence: per `ok/SKILL.md`'s explicit "never runs audit"
language and the absence of any in-suite caller, `ok-plumbline:audit` would
reclassify as user-facing and its description would need to gain the
phrase. The alternative is that the owner's actual criterion is something
else, or that "read-only reporting verb" (as opposed to "consequential
ceremony," which is the concern the decision's Rationale names) is itself
sufficient grounds to stay plumbing regardless of caller, or that
`ok-plumbline:audit` is meant to be driven by machinery later even though
nothing does today — in which case the `audit` divergence is not a
misclassification, just an undocumented one, and the rule needs to capture
whatever that reason is instead of caller-testability.

**What the ruling needs to decide.**
1. Which artifact states the classification rule — `concept:skill`
   Boundaries, `decision:slash-only-activation` (amending its Proof from "not
   stated" to the rule itself), or both, one general and one recording it as
   this decision's completed rationale?
2. What is the rule's criterion — machine-callability through the Skill
   tool (as the decision's existing rationale text already implies), or a
   different basis (e.g. "read-only reporting" as its own qualifying
   category, or a forward-looking allowance for skills not yet driven by
   anything)?
3. Given that answer, does `ok-plumbline:audit`'s description need to
   change to add the phrase — since no machinery calls it today — or does
   it stay plumbing for a reason the rule should also state?

## Ruling

<!-- Owner: write your decision here in your own words.
The next /plan-sprint picks it up. Leave empty to discuss
it live in a planning session instead. -->
