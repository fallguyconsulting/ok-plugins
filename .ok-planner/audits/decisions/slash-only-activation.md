---
audit: slash-only-activation
artifact: decision:slash-only-activation
determination: satisfied
audited: 2026-07-27T13:20:00Z
artifact-hash: sha256:baeae13d8ac4
---

# Does every user-facing skill declare the explicit-activation guard, with the plumbing class limited to skills another suite surface is documented to drive through the skill tool?

## Claims

**Title + Choice clause 1 — "Every user-facing skill declares in its
description that it is activated only by its explicit slash command and never
auto-triggered by conversation content."** The population is every `SKILL.md`
the suite carries, enumerated from reality: the front door's one skill
(`plugins/ok/skills/ok/`), ok-planner's ten, ok-plumbline's ten,
ok-workspaces' four, and this repo's own vendored layer plus the repo-local
release skill (eleven under `.claude/skills/`) — thirty-six files. Grepping the
guard sentence across all thirty-six returns a hit in every one except
ok-planner's `verify-issues` and its vendored copy, which are the declared
plumbing class. The check `activation-guard` derives the same population from
the same globs and fails on any user-facing description missing the guard.
Honored.

**Choice clause 2 — "some naming one additional legitimate non-human activator,
such as whoever executes a sprint's completion contract."** Read from the
descriptions: `prove` names "whoever is executing a sprint's completion
contract"; `certify-work` names "the terminal step named in the sprint
document's execution boilerplate"; ok-planner's `audit` names the
`/certify-all` gate as a producer. Each keeps the guard sentence alongside the
named caller. Honored.

**Choice clause 3 — "while plumbing skills deliberately drop the restriction so
the suite's own machinery, sibling skills and the certification gates, can
drive them through the skill tool."** Exactly one skill is in the class:
`verify-issues`, whose description opens with the slash command *or* invocation
by a certify gate after its architect promotes issues, *or* by `plan-sprint`
for a legacy log conversion — and carries no guard sentence. The check enforces
the exclusivity in both directions: an allowlisted skill whose description
carries the guard is a finding, and an allowlist entry with no file on disk is
a finding. Honored.

**Choice clause 4 — the membership rule: "a skill belongs to the plumbing class
only while another suite surface is documented to drive it through the
skill-invocation tool, and absence of a documented machine driver settles it —
the guard belongs."** This is applied, not assumed: the check searches every
*other* skill source in the suite for the qualified invocation form
`ok-planner:verify-issues` and treats a guard-less skill with no such driver as
a finding worded "the guard belongs". Read from reality, the drivers exist —
`certify-work` and `certify-all` each direct "Invoke `ok-planner:verify-issues`"
after their architect promotes, and `plan-sprint` directs the same for a legacy
`issues.jsonl`. The check's own comment states that the driver is derived from
the suite's text rather than trusted from the allowlist. Honored.

**Choice clause 5 — "Being machine-driven does not by itself move a user verb
out of the guarded class: a consequential verb machinery also invokes keeps the
guard and names that caller as its one additional activator."** The three verbs
under clause 2 are exactly this case — machinery-invoked and still guarded,
each naming its one extra caller. The check enforces the direction that
matters: it never removes the guard requirement from a skill merely because it
is referenced elsewhere; only the explicit allowlist can, and only when a
documented driver is found. Honored.

**Rationale capability claims — "the activation phrase is load-bearing prompt
engineering", "the two-class split preserves composability", "the membership
rule keeps the split testable as skills are added."** The first is unprovable
prompt behavior and is asserted as presence, which is what the guard's
falsifier (deleting the phrase) tests. The second holds: the machinery's
documented invocations of `verify-issues` are live in three skill bodies. The
third is the check itself — the split is recomputed from the filesystem on
every run, so a newly added skill is covered without editing the check.
Honored.

## Determination

**Satisfied.** Thirty-six skill files, thirty-four carrying the guard, and the
two that do not are the same skill in source and vendored form — the one
declared plumbing member, whose machine drivers are documented in three other
skill bodies and verified by search rather than assumed. The membership rule is
implemented as a derivation, not a hand-kept list, so it holds as skills are
added. The consequential machine-driven verbs keep their guard and name their
single extra activator.

This stops holding if: any user-facing skill's description loses the guard
sentence; a skill is added to the plumbing allowlist without another suite
surface documenting the qualified invocation; `verify-issues` gains the guard
while staying allowlisted (or loses its documented drivers); a guarded verb is
silently un-guarded because machinery began invoking it; or the check's
population globs stop covering a directory where skills live — the `cite-file`
pin breaks on any edit to the check, forcing the population to be re-derived.

## Citations

- cite-file: checks/activation-guard @ sha256:6ae9a2ca82fd
- cite: checks/activation-guard :: "# @decision: slash-only-activation"
- cite: checks/activation-guard :: "GUARD = "
- cite-span: checks/activation-guard :: "def check_skill(name, path, plumbing, seen):" +30 sha256:bf2fb39fe673
- cite: checks/activation-guard :: "ok-planner:verify-issues"
- cite: plugins/ok/families/ok-planner/skills/verify-issues/SKILL.md :: "or invoked by a certify gate after its architect promotes issues"
- cite: plugins/ok/families/ok-planner/skills/prove/SKILL.md :: "or by whoever is executing a sprint"
- cite: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md :: "Invoke `ok-planner:verify-issues`"
- cite: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "Invoke `ok-planner:verify-issues`"
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "invoke `ok-planner:verify-issues` before framing anything"
- cite: plugins/ok/skills/ok/SKILL.md :: "ONLY activated by explicit /ok slash command"
