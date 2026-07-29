---
audit: slash-only-activation
artifact: decision:slash-only-activation
determination: satisfied
audited: 2026-07-29T07:15:00Z
artifact-hash: sha256:baeae13d8ac4
---

# Does every user-facing skill declare the explicit-activation guard, with the plumbing class limited to skills another suite surface is documented to drive through the skill tool?

Refreshed again. The design artifact's hash is unchanged, and no new nomination
arrived. The one stale citation is the pinned `certify-work` producers span
(clause 5's evidence): the fix cycle following this run's own repairs reworded
the "Implementation audit, two layers" bullet inside it to add
`--inspection=<base>` support for a commit-range subject — territory the
`audit-check --inspection` floor and `two-layer-invalidation` claim, not
anything clause 5 asserts. The bullet list clause 5 actually rests on — the
`ok-planner:prove` invocation, the guard-preserving descriptions — is untouched
inside that same span. Citation regenerated; nothing else re-litigated.

## Claims

**Why this is a re-audit, and what moved.** The decision is unchanged (hash identical) and
nothing here went mechanically stale — `audit-check` reports no finding against this file,
so the whole-file pin on the check, the three registry spans, the front door's node pin and
every text anchor all still resolve. The audit is open because certification's change
inspector nominated it a second time: the four skills this audit anchors driver sentences
in (`certify-all`, `certify-work`, `plan-sprint`, `verify-issues`) drifted structurally at
HEAD beside those anchors, and a one-phrase text-presence match cannot see a rewrite around
it. Adjudicated below (promoted in part, dismissed in part), and the population was
re-derived from the filesystem rather than carried.

**Title + Choice clause 1 — "Every user-facing skill declares in its description that it is
activated only by its explicit slash command and never auto-triggered by conversation
content."** The population is every `SKILL.md` the suite carries, re-enumerated from reality
this cycle by walking the tree: the front door's one skill (`plugins/ok/skills/ok/`),
ok-planner's eleven, ok-plumbline's nine, ok-workspaces' four, and this repo's own vendored
layer plus the repo-local release skill (**twelve** under `.claude/skills/`) —
**thirty-seven** files. The previous pass counted thirty-six; the difference is one real new
member, not a miscount corrected: the vendored copy of `browse` landed in the v11.2.0
release commit (`git log` on `.claude/skills/browse/SKILL.md` names `53f6718`, the current
HEAD), after the last audit was written.

Reading the `description:` frontmatter of all thirty-seven, the guard sentence appears in
every one except ok-planner's `verify-issues` and its vendored copy, which are the declared
plumbing class — thirty-five guarded, two not. The new member was read rather than assumed:
`.claude/skills/browse/SKILL.md`'s description opens "ONLY activated by explicit /browse
slash command. Never auto-triggered by conversation content." — identical in that clause to
its family-side source. The check `activation-guard` derives the same population from three
globs (`plugins/*/skills/*/SKILL.md`, `plugins/ok/families/*/skills/*/SKILL.md`,
`.claude/skills/*/SKILL.md`), which I confirmed cover all thirty-seven files with none left
out, and it fails on any user-facing description missing the guard; it was run for this
audit and exits 0. One narrow enforcement limit, verified rather than assumed: the check
reads the description with a single-line regex (`^description: (.*)$`), so a folded
multi-line description could evade it — no skill in the suite has one (checked: every file
carries exactly one `description:` line and every guard sentence sits on it). Honored.

**Choice clause 2 — "some naming one additional legitimate non-human activator, such as
whoever executes a sprint's completion contract."** Read from the descriptions: `prove` names
"whoever is executing a sprint's completion contract — an inline session or an orchestrator";
`certify-work` names "the terminal step named in the sprint document's execution
boilerplate"; ok-planner's `audit` names "the /certify-all gate, which runs it as a
producer", as does its vendored `ok-planner-audit` copy. Each keeps the guard sentence
alongside the named caller. `browse` names no additional activator, which is correct rather
than a gap: nothing in the suite drives it — a search of every skill body and support script
for a qualified or bare invocation of `browse` returns only its own file and the router
table's row. Honored.

**Choice clause 3 — "while plumbing skills deliberately drop the restriction so the suite's
own machinery, sibling skills and the certification gates, can drive them through the skill
tool."** Exactly one skill is in the class: `verify-issues`, whose description opens with the
slash command *or* invocation by a certify gate after its architect promotes issues, *or* by
`plan-sprint` for a legacy log conversion — and carries no guard sentence, in both source and
vendored form. The check enforces the exclusivity in both directions: an allowlisted skill
whose description carries the guard is a finding, and an allowlist entry with no file on disk
is a finding. Honored.

**Choice clause 4 — the membership rule: "a skill belongs to the plumbing class only while
another suite surface is documented to drive it through the skill-invocation tool, and absence
of a documented machine driver settles it — the guard belongs."** This is applied, not assumed:
the check searches every *other* skill source in the suite (plus the `_shared/` transclusion
sources) for the qualified form `ok-planner:verify-issues` and treats a guard-less skill with
no such driver as a finding worded "the guard belongs". Read from reality this cycle through
the drift the nomination flags, the drivers survive it: `certify-all` §4 and `certify-work` §4
each direct "Invoke `ok-planner:verify-issues`" after their architect promotes, and
`plan-sprint` §0 directs the same for a legacy `issues.jsonl`. Honored.

**Choice clause 5 — "Being machine-driven does not by itself move a user verb out of the
guarded class: a consequential verb machinery also invokes keeps the guard and names that
caller as its one additional activator."** This is the clause the nominated drift actually
exposes, so the population it quantifies over was enumerated from reality: every qualified
skill-tool invocation the suite's text makes of a guarded verb. There are exactly three
sites, all in the two gates' producer lists — `certify-all` invokes `ok-planner:prove` and
`ok-planner:audit`; `certify-work` invokes `ok-planner:prove` — plus the three plumbing
invocations of `verify-issues` already covered by clause 4. Both driven verbs keep the guard
and each names its machine caller: `audit` names `/certify-all` explicitly, and `prove` names
"whoever is executing a sprint's completion contract", which covers both gates on their own
words — `certify-work` "discharges the sprint's completion contract" and `certify-all` says of
itself that it "discharges the completion contract (`/prove` clean, `/audit` last)".
`certify-work` does **not** invoke `ok-planner:audit` (it runs the implementation auditor as a
subagent instead), which is why `audit`'s description naming only `/certify-all` is accurate
rather than under-inclusive. The check enforces the direction that matters: it never removes
the guard requirement from a skill merely because it is referenced elsewhere; only the explicit
allowlist can, and only when a documented driver is found. Honored.

**Rationale capability claims — "the activation phrase is load-bearing prompt engineering",
"the two-class split preserves composability", "the membership rule keeps the split testable
as skills are added."** The first is unprovable prompt behavior and is asserted as presence,
which is what the guard's falsifier (deleting the phrase) tests. The second holds: the
machinery's documented invocations of `verify-issues` are live in three skill bodies and
survived a substantial rewrite of all three. The third is the check itself — the split is
recomputed from the filesystem on every run, so this cycle's new vendored member was covered
without editing a line of the check. Honored.

## Determination

**satisfied.** Thirty-seven skill files, thirty-five carrying the guard, and the two that do
not are the same skill in source and vendored form — the one declared plumbing member, whose
machine drivers are documented in three other skill bodies and verified by search through the
drift rather than assumed. The membership rule is implemented as a derivation, not a hand-kept
list, so it holds as skills are added; this cycle's new member (the vendored `browse` copy)
arrived guarded. Clause 5's population was enumerated from reality for the first time — three
qualified invocations of guarded verbs, both driven verbs guarded and each naming its caller.

The audit's own tripwire is now wider than it was. The previous pass pinned the three families'
vendored-skill registries and the front door's single skill so a future *verb* moves a hash
here. What it did not pin was the surface where a new *machine driver* would appear, which is
what this cycle's nomination is about; the two gates' producer lists are now pinned by span, so
a producer added or a driven verb changed re-triggers this audit mechanically instead of needing
another judged nomination. One residual lag is honestly recorded rather than closed: the
vendored layer materializes from the registries, so a verb already in a registry can acquire its
`.claude/skills/` copy in a later commit without moving any hash here — exactly how this cycle's
thirty-seventh member arrived. The vendored `browse` copy is now pinned by node, but the general
lag remains.

This stops holding if: any user-facing skill's description loses the guard sentence; a skill is
added to the plumbing allowlist without another suite surface documenting the qualified
invocation; `verify-issues` gains the guard while staying allowlisted (or loses its documented
drivers); a gate's producer list gains an invocation of a guarded verb that does not name that
caller (the span pins on both producer lists break on any such edit); a guarded verb's
description drops the caller it names while machinery keeps invoking it; the check's population
globs stop covering a directory where skills live, or its single-line description regex meets a
folded description (the `cite-node` pin breaks on any edit to the check, forcing the population
to be re-derived); or a family registers a new verb, which moves the span pin on that family's
registry.

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
- cite-node: .claude/skills/browse/SKILL.md @ sha256:bbc4d1032020
- cite: .claude/skills/browse/SKILL.md :: "description: "ONLY activated by explicit /browse slash command. Never auto-triggered by conversation content. Starts the corpus view: a read-only local web page showing which code each live story and decision claims, which regions of a source file nothing claims, and the sources no artifact reaches at all. Read-only — it starts a server and writes nothing.""
- cite: plugins/ok/families/ok-planner/skills/verify-issues/SKILL.md :: "or invoked by a certify gate after its architect promotes issues"
- cite: plugins/ok/families/ok-planner/skills/prove/SKILL.md :: "or by whoever is executing a sprint"
- cite-node: plugins/ok/families/ok-planner/skills/prove/SKILL.md @ sha256:c015b0e2ffd7
- cite: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "or by the /certify-all gate, which runs it as a producer"
- cite: .claude/skills/ok-planner-audit/SKILL.md :: "or by the /certify-all gate, which runs it as a producer"
- cite: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md :: "Invoke `ok-planner:verify-issues`"
- cite: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "Invoke `ok-planner:verify-issues`"
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "invoke `ok-planner:verify-issues` before framing anything"
- cite-span: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md :: "3. **The review-fix loop.** Run `{{CERTIFY-REVIEW-FIX-LOOP}}` from `skills/_shared/certification-core.md` — initial review by every producer, then fixer → architect → re-review cycles to clean or the cap. This gate's producers, each at full scope:" +7 sha256:7cba9f6c06dd
- cite: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md :: "   - **Prove, whole-corpus.** Invoke `ok-planner:prove`. Its structured report returns in-context; every non-pass verdict — `missing` / `failing` / `unrunnable` — is a finding for the loop."
- cite: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md :: "   - **Audit, whole-corpus.** Invoke `ok-planner:audit`. It is a pure reporter: its findings — compliance, coverage-and-cardinality, intent-drift, annotation integrity, cross-artifact consistency, with `mechanical`/`judgment` classes as advisory context — all enter the loop; it files nothing."
- cite-span: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "3. **The review-fix loop.** Run `{{CERTIFY-REVIEW-FIX-LOOP}}` from `skills/_shared/certification-core.md` — initial review by every producer, then fixer → architect → re-review cycles to clean or the cap. On each re-review, the implementation-audit producer's scope is recomputed in both layers: the graph is regenerated and `audit-check --list-stale` names every audit the fixer's edits disturbed (the fixes move the hashes of cited nodes and anchors, so the mechanical set after a fix cycle is deterministic, and may include artifacts no earlier cycle audited), and the change inspector re-runs over the then-current diff to nominate what citations cannot see. This gate's producers, each at change scope:" +7 sha256:3159574e1b81
- cite: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "   - **Prove, touched scope.** Invoke `ok-planner:prove` scoped to the touched stories (its caller-scoping is built in). Every non-pass verdict — `missing` / `failing` / `unrunnable` — is a finding for the loop. If the touched set has no stories, this producer passes empty."
- cite-node: plugins/ok/skills/ok/SKILL.md @ sha256:c2b1f0e2e951
- cite: plugins/ok/skills/ok/SKILL.md :: "ONLY activated by explicit /ok slash command"

## Notes

- note: `plugins/ok/families/ok-planner/skills/browse/SKILL.md` is a new user-facing skill (the corpus-view verb, story:trace-corpus-to-code) — it is a new member of the population `checks/activation-guard`'s glob enumerates and this audit's population-membership claim covers, and no citation here spot-checked it. (Separately, `plugins/ok/families/ok-plumbline/skills/slug/SKILL.md` was deleted in the same change — a population member leaving, not a compliance risk, noted for completeness.)
  adjudication: promoted — the nomination is correct on both halves and the audit's tripwire was the gap, not the enforcement. The new member is now spot-checked directly (`cite-node: plugins/ok/families/ok-planner/skills/browse/SKILL.md @ sha256:4a8f94a82b50` plus a `cite:` on its guard-carrying description line), and the enumeration source is now pinned so a *future* member re-triggers rather than needing another judged nomination: `cite-span: plugins/ok/families/ok-planner/admin/converge :: "SKILLS = {" +13`, `cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "const VENDORED_SKILLS = {" +11`, `cite-span: plugins/ok/families/ok-workspaces/scripts/vendored-skills.js :: "const SKILLS = {" +6`, and `cite-node: plugins/ok/skills/ok/SKILL.md` for the front door's single verb. Findings: `browse` carries the guard verbatim and names no additional activator (nothing in the suite documents driving it), and the departed `slug` leaves no residue — no vendored copy and no surviving reference — so the allowlist stays at one member and the determination is unchanged.
- note: `plugins/ok/families/ok-planner/skills/{certify-all,certify-work,plan-sprint,verify-issues}/SKILL.md` each moved substantially (the source-graph-certification sprint's `/audit` rename, the change-inspector/graph-regeneration steps, out-of-band-work reconciliation, the completion-report step) beside this audit's `cite:` anchors on those same files — every anchor here is a text-presence match on one quoted phrase (e.g. "Invoke `ok-planner:verify-issues`"), never a node hash, so unrelated rewrites in the same files cannot trip staleness even when substantial.
  adjudication: promoted in part, dismissed in part. Promoted for `certify-all` and `certify-work`: their producer lists are the enumeration source for clause 5's population — every qualified skill-tool invocation the suite makes of a guarded verb lives there — and the drift did in fact land inside that surface, so a text anchor on one phrase was the wrong instrument. Both lists are now pinned by span (`certify-all` producers +7 sha256:7cba9f6c06dd, `certify-work` producers +7 sha256:d561d6a926d5) together with `cite:` anchors on each `Invoke ok-planner:prove` / `Invoke ok-planner:audit` line and on the description clause each driven verb uses to name that caller (`prove`, family-side `audit`, and the vendored `ok-planner-audit`). Finding on the drifted reality: no violation — the three invocations of guarded verbs are `prove` (both gates) and `audit` (certify-all only); both keep the guard, `audit` names `/certify-all` by name, and `prove`'s "whoever is executing a sprint's completion contract" covers both gates on their own stated words. Dismissed for `plan-sprint` and `verify-issues`: nothing this decision claims rests on their bodies. `plan-sprint`'s only bearing content is its single documented driver sentence for the plumbing member, whose deletion or rewording breaks the `cite:` anchor and trips staleness; `verify-issues`' class rests on its `description:` line (guard-absence, enforced by the node-pinned check in both directions) and on driver sentences that live in *other* files. Pinning either body by node would make this audit stale on ceremony edits that cannot change any claim here.
