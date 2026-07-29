---
audit: slash-only-activation
artifact: decision:slash-only-activation
determination: satisfied
audited: 2026-07-28T18:00:00Z
artifact-hash: sha256:baeae13d8ac4
---

# Does every user-facing skill declare the explicit-activation guard, with the plumbing class limited to skills another suite surface is documented to drive through the skill tool?

## Claims

**Why this is a re-audit, and what moved.** The decision is unchanged (hash
identical) and nothing here went mechanically stale — the whole-file pin on the
check and every anchor still resolve. The audit is open because certification's
change inspector nominated it, and the nomination is the canonical shape this
audit is most exposed to: the population gained a member (`skills/browse/`) and
lost one (`ok-plumbline/skills/slug/`), and neither event moves any hash a
citation here holds. A membership claim whose enumeration source is a directory
listing is exactly the "every, enforced on the members someone remembered"
failure this audit exists to catch, so the population was re-derived from the
filesystem and the enumeration is now pinned. Adjudicated below (promoted).

**Title + Choice clause 1 — "Every user-facing skill declares in its
description that it is activated only by its explicit slash command and never
auto-triggered by conversation content."** The population is every `SKILL.md`
the suite carries, re-enumerated from reality this cycle by walking the tree
rather than by trusting the previous count: the front door's one skill
(`plugins/ok/skills/ok/`), ok-planner's eleven, ok-plumbline's nine,
ok-workspaces' four, and this repo's own vendored layer plus the repo-local
release skill (eleven under `.claude/skills/`) — **thirty-six** files. The
composition moved even though the total did not: ok-planner gained `browse` and
ok-plumbline lost `slug`.

Reading the `description:` frontmatter of all thirty-six, the guard sentence
appears in every one except ok-planner's `verify-issues` and its vendored copy,
which are the declared plumbing class. The new member is compliant on its own
terms and was read rather than assumed: `browse`'s description opens "ONLY
activated by explicit /browse slash command. Never auto-triggered by
conversation content." The departed member is gone without residue — no
`SKILL.md`, no vendored copy under `.claude/skills/`, and no surviving
`ok-plumbline:slug` or `/slug` reference anywhere in the plugin tree, the
vendored layer, the checks or the README — so no dangling driver claim is left
behind for the membership rule to trip over. The check `activation-guard`
derives the same population from the same globs and fails on any user-facing
description missing the guard; it was run for this audit and exits 0. Honored.

**Choice clause 2 — "some naming one additional legitimate non-human activator,
such as whoever executes a sprint's completion contract."** Read from the
descriptions: `prove` names "whoever is executing a sprint's completion
contract"; `certify-work` names "the terminal step named in the sprint
document's execution boilerplate"; ok-planner's `audit` names the
`/certify-all` gate as a producer. Each keeps the guard sentence alongside the
named caller. The new member names no additional activator, which is correct
rather than a gap: nothing in the suite drives `browse` — a search of every
skill body for a qualified invocation of it returns nothing. Honored.

**Choice clause 3 — "while plumbing skills deliberately drop the restriction so
the suite's own machinery, sibling skills and the certification gates, can
drive them through the skill tool."** Exactly one skill is in the class:
`verify-issues`, whose description opens with the slash command *or* invocation
by a certify gate after its architect promotes issues, *or* by `plan-sprint`
for a legacy log conversion — and carries no guard sentence. The check enforces
the exclusivity in both directions: an allowlisted skill whose description
carries the guard is a finding, and an allowlist entry with no file on disk is
a finding. This cycle's deletion is the second direction's live test — had
`slug` been allowlisted, its removal would now be reported as a stale entry;
it was not allowlisted, and the allowlist still names only `verify-issues`.
Honored.

**Choice clause 4 — the membership rule: "a skill belongs to the plumbing class
only while another suite surface is documented to drive it through the
skill-invocation tool, and absence of a documented machine driver settles it —
the guard belongs."** This is applied, not assumed: the check searches every
*other* skill source in the suite for the qualified invocation form
`ok-planner:verify-issues` and treats a guard-less skill with no such driver as
a finding worded "the guard belongs". Read from reality this cycle, the drivers
exist — `certify-work` and `certify-all` each direct "Invoke
`ok-planner:verify-issues`" after their architect promotes, and `plan-sprint`
directs the same for a legacy `issues.jsonl`. The check's own comment states
that the driver is derived from the suite's text rather than trusted from the
allowlist. Honored.

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
every run, so a newly added skill is covered without editing the check, and
this cycle is the claim's own demonstration: `browse` was added, no line of the
check changed, and the check covers it. Honored.

## Determination

**satisfied.** Thirty-six skill files, thirty-four carrying the guard, and the
two that do not are the same skill in source and vendored form — the one
declared plumbing member, whose machine drivers are documented in three other
skill bodies and verified by search rather than assumed. The membership rule is
implemented as a derivation, not a hand-kept list, so it holds as skills are
added; this cycle's new member arrived guarded and the departed member left no
residue. The consequential machine-driven verbs keep their guard and name their
single extra activator.

One honest limitation is now closed rather than merely recorded. The check's
enforcement is complete — it re-globs the tree on every run — but the *audit's*
tripwire was not: until this cycle nothing here moved when the population gained
or lost a member, which is why the new skill reached this audit only through a
judged nomination. The three families' vendored-skill registries are now pinned
as the enumeration source. Every verb that reaches a consumer must be registered
in one of them (the planner's `SKILLS` map in its converge core, plumbline's
`VENDORED_SKILLS` in its binary, ok-workspaces' `SKILLS` in its vendoring
module), and the front door carries exactly one skill, whose file is pinned
whole. A future member therefore moves a hash here.

This stops holding if: any user-facing skill's description loses the guard
sentence; a skill is added to the plumbing allowlist without another suite
surface documenting the qualified invocation; `verify-issues` gains the guard
while staying allowlisted (or loses its documented drivers); a guarded verb is
silently un-guarded because machinery began invoking it; the check's population
globs stop covering a directory where skills live (the `cite-node` pin breaks on
any edit to the check, forcing the population to be re-derived); or a family
registers a new verb, which moves the span pin on that family's registry — the
guard the new verb must then declare being what this audit re-checks.

## Citations

- cite-node: checks/activation-guard @ sha256:6ae9a2ca82fd
- cite: checks/activation-guard :: "# @decision: slash-only-activation"
- cite: checks/activation-guard :: "GUARD = "
- cite-span: checks/activation-guard :: "def check_skill(name, path, plumbing, seen):" +30 sha256:bf2fb39fe673
- cite: checks/activation-guard :: "ok-planner:verify-issues"
- cite-span: plugins/ok/families/ok-planner/admin/converge :: "SKILLS = {" +13 sha256:19e4a08de7f5
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "const VENDORED_SKILLS = {" +11 sha256:59d445edacbf
- cite-span: plugins/ok/families/ok-workspaces/scripts/vendored-skills.js :: "const SKILLS = {" +6 sha256:c060ac5bd063
- cite-node: plugins/ok/families/ok-planner/skills/browse/SKILL.md @ sha256:772c8b604d8a
- cite: plugins/ok/families/ok-planner/skills/browse/SKILL.md :: "description: "ONLY activated by explicit /browse slash command. Never auto-triggered by conversation content. Starts the corpus view: a read-only local web page showing which code each live story and decision claims, which regions of a source file nothing claims, and the sources no artifact reaches at all. Read-only — it starts a server and writes nothing.""
- cite: plugins/ok/families/ok-planner/skills/verify-issues/SKILL.md :: "or invoked by a certify gate after its architect promotes issues"
- cite: plugins/ok/families/ok-planner/skills/prove/SKILL.md :: "or by whoever is executing a sprint"
- cite: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md :: "Invoke `ok-planner:verify-issues`"
- cite: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "Invoke `ok-planner:verify-issues`"
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "invoke `ok-planner:verify-issues` before framing anything"
- cite-node: plugins/ok/skills/ok/SKILL.md @ sha256:c2b1f0e2e951
- cite: plugins/ok/skills/ok/SKILL.md :: "ONLY activated by explicit /ok slash command"

## Notes

- note: `plugins/ok/families/ok-planner/skills/browse/SKILL.md` is a new user-facing skill (the corpus-view verb, story:trace-corpus-to-code) — it is a new member of the population `checks/activation-guard`'s glob enumerates and this audit's population-membership claim covers, and no citation here spot-checked it. (Separately, `plugins/ok/families/ok-plumbline/skills/slug/SKILL.md` was deleted in the same change — a population member leaving, not a compliance risk, noted for completeness.)
  adjudication: promoted — the nomination is correct on both halves and the audit's tripwire was the gap, not the enforcement. The new member is now spot-checked directly (`cite-node: plugins/ok/families/ok-planner/skills/browse/SKILL.md @ sha256:4a8f94a82b50` plus a `cite:` on its guard-carrying description line), and the enumeration source is now pinned so a *future* member re-triggers rather than needing another judged nomination: `cite-span: plugins/ok/families/ok-planner/admin/converge :: "SKILLS = {" +13`, `cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "const VENDORED_SKILLS = {" +11`, `cite-span: plugins/ok/families/ok-workspaces/scripts/vendored-skills.js :: "const SKILLS = {" +6`, and `cite-node: plugins/ok/skills/ok/SKILL.md` for the front door's single verb. Findings: `browse` carries the guard verbatim and names no additional activator (nothing in the suite documents driving it), and the departed `slug` leaves no residue — no vendored copy and no surviving reference — so the allowlist stays at one member and the determination is unchanged.
