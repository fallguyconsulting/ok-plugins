---
audit: see-governing-versions
artifact: story:see-governing-versions
determination: satisfied
audited: 2026-07-28T12:00:00Z
artifact-hash: sha256:bb20bb539343
---

# Do the version verbs echo what actually governs this session or project, rather than what is installed?

## Claims

**Why this is a re-audit, and what moved.** The design artifact is unchanged
(hash identical) and nothing here went mechanically stale — every cited node,
span, anchor and file pin still resolves. The audit is open because
certification's change inspector nominated it, and the nomination goes straight
at the weakness the previous cycle's own closing paragraph confessed: the
population of version verbs is enumerated by directory listing, no citation
pinned that listing, and a new version-reporting surface would therefore reach
this audit only by judgment. A new surface duly appeared — the corpus view
prints and renders a running-version-versus-estate-pinned-version echo. Whether
the story's claims reach it is the question this pass has to answer, and it is
adjudicated below (dismissed, with the reasoning stated at length because the
opposite answer would have made this audit violated). Every claim was re-run
against the tree.

**Title / Story (quantified) — "see which plugin version actually governs my
current session or project, alongside what is installed."** Honored. The
population of version verbs was re-enumerated from reality: every `skills/*/`
directory under all three family directories and the front-door plugin was
listed — **twenty-five** verb directories plus the planner's `_shared/` (the
planner's eleven, plumbline's nine, ok-workspaces' four, the front door's one)
— and exactly **two** are version verbs, one per surface the Story names: the
planner family's `ok-version` for the session surface, and the plumbline
family's `version` for the project surface. Neither `ok-workspaces` nor the
`/ok` administrator carries one. The count is unchanged from the previous cycle
even though its composition moved (`browse` added, `slug` removed).

The enumeration is now pinned rather than merely stated. Both verb files carry
whole-file pins, so a rewrite of either forces a re-audit; and the three
families' vendored-skill registries are pinned too — a verb that does not appear
in the planner's `SKILLS` map, plumbline's `VENDORED_SKILLS`, or ok-workspaces'
`SKILLS` never reaches a consumer, and the front door carries exactly one skill,
pinned whole. A third version verb therefore moves a hash here instead of
depending on a judged nomination.

**Acceptance 1a — "it echoes the governing numbers — what this session was
injected with and the conduct actually loaded."** Honored, and "actually" is
load-bearing in both halves. The plugin number is read from the SessionStart
hook's injected context line, with `unknown` when that line is absent — never
from the installed manifest. The conduct number is read from the active output
style — "This is the conduct **actually governing the session**, which is why it
comes from the output style rather than the session-start line" — with
`unstamped` as the fallback. Both verb bodies are byte-unchanged this cycle.

**Acceptance 1b — "or what this project's pinned copy reports versus the
installed plugin's."** Honored by the project-surface verb. It runs the
project's vendored binary if present (and prints
`project (vendored): none — /ok pins one to this project` if not), prints the
carried payload's number beside it, and guards the payload invocation on the
payload binary's executability — printing
`carried payload: none — the ok front door is not installed on this machine`
rather than dying when nothing is installed, so the project's pinned number is
reported even on a machine with no front door, the case where "what governs" and
"what is installed" differ most sharply. The pinned copy is real rather than
notional: the plumbline converge core writes the binary into `.ok-plumbline/bin/`,
substituting the real suite version for the source's `0.0.0-unvendored`
placeholder, and the payload's own copy deliberately keeps that placeholder —
which the verb's closing paragraph names as expected.

**Acceptance 2 — "with no verdict, no comparison beyond the echo, and no
writes."** Honored across the population as enumerated. The planner verb's
opening states "No disk read, no comparison, no verdict", its report step prints
exactly two labelled lines, and it closes "This skill never reads from disk,
never edits files, and never chains to another skill. Report and stop." The
project-surface verb's whole body is a read-only shell block printing two
labelled lines and nothing else; its two branches are presence tests on a file
(`[ -x "$payload" ]`), not version comparisons — no branch compares the two
numbers and neither emits a judgement about which is newer.

This is the clause the nomination puts under strain and it deserves the strain
stated plainly rather than waved past. The corpus view's announcement *does*
compute a comparison — it derives a `version_agrees` boolean from the running
version and the estate's stamp, and on disagreement emits a directive line
("reading an older corpus with a newer view. Run /ok to converge"), which the
frontend renders as a warning banner. If that surface belonged to this story's
population, this clause would fail and the determination would be violated. It
does not belong: the Acceptance is a conditional whose antecedent is *the
consumer invokes a version verb*, and the corpus view is invoked to browse the
corpus. Its version line is a provenance disclosure that
`decision:per-project-pinning` requires of every read-only verb that can fall
back to the front door's carried payload — the same requirement `audit`,
`budget`, `patterns`, `suggest`, `explain`, `ci`, `port` and `starter` each
satisfy in their own words, none of which is a version verb either. What is
distinctive about the corpus view is only that its answers are corpus-version
dependent, so its disclosure names the estate's stamp as well as its own; that
widens the disclosure, not the verb's purpose. The project's own conformance
check agrees on where the obligation comes from: it asserts the corpus view's
two version strings under `per-project-pinning`, alongside the other advisory
verbs, and not under this story.

**Acceptance 3 — "a gap between governing and installed is the signal that
convergence is available."** Honored as text rather than as a computed verdict,
which is what the previous clause requires: "They differ whenever the installed
front door has moved ahead of the project's last converge, and that gap is the
useful signal: the project keeps linting at its pinned version until the owner
converges deliberately."

**Acceptance 4 — "The stamped artifacts and pinned copies the verbs read are
real."** Honored, and re-checked against this checkout at its current version.
The session-start hook template carries the `{{OK_PLANNER_VERSION}}` token, the
planner converge core substitutes the suite version into it at materialization,
and this repository's own materialized hook carries the literal `ok-planner
v11.1.2 is materialized in this project.` — matching the front-door manifest's
`11.1.2`, with the estate's `CLAUDE.md` and cheatsheet stamped to the same
version and no artifact left at a prior stamp. On the plumbline side the
vendored binary is written and stamped by its converge core, verified by that
core running `plumbline version` against the freshly written file.

Carried forward, since it still applies: the citation on the estate hook's
banner line does not pin the *number*. Release-mutable metadata — including any
`vX.Y.Z` on a line naming a suite family — is masked before anchor comparison,
so that `cite:` survives a version bump by design. The in-step-ness of the estate
is guarded by the harness's run-time assertion (this project's stamp equals the
manifest's version, recomputed on every run), not by a citation.

**Falsifier — "The verb reports the installed version as if it governed the
context; the numbers require manually opening files to learn; or the echo mutates
state or chains into other actions."** Each is negated: the read sources are the
session-injected line and the active output style rather than the manifest; the
verbs are one-shot recitals invoked by a slash command; and the no-write /
no-chain rule is explicit in both.

**Proof — "on a project deliberately converged at an older version than the
installed plugin, the verb shows the two numbers disagreeing, and a third party
can confirm the governing number matches the project's stamped artifacts."** The
story is annotated in the planner's `proofs.sh`, and both conjuncts are
exercised against reality rather than modelled: the harness converges a real
fixture project through the family's own converge core, rewrites that project's
stamped hook to a deliberately-behind version, runs the hook and reads the
governing number back out of its output, then asserts (a) that it equals the
project's own stamp rather than the carried manifest, and (b) that it disagrees
with the carried manifest. It additionally asserts the verb still reads the
conduct number from the active output style, and that on this project the
stamped artifact and the manifest agree. Re-run this cycle: all four assertions
pass, with the disagreement exhibited as `9.0.0-behind` against the carried
`v11.1.2`.

**Proof coverage of the project surface.** Partial, as recorded before. The
plumbline family's clone case runs the vendored `version` verb's own Run block
from a converged fixture with nothing installed and asserts it exits clean
without reaching for the payload — so the project-surface verb is executed by a
deterministic case. What no case asserts is the *content* of its two lines
against the fixture's stamp, so the disagreement conjunct of the Proof field
remains exercised only on the session surface. Recorded as a partial; the Proof
field asks for one exhibit of disagreeing numbers, which the planner harness
delivers.

## Determination

**satisfied.** Every Acceptance clause and every Falsifier condition has a
citable enforcement point across the two verbs the population enumerates: the
planner verb reads the session-injected line and the active output style rather
than the installed plugin, refuses to compare or write, and stops; the plumbline
verb echoes the vendored binary's number beside the payload's — degrading to
`none` rather than failing when no front door is installed — and names the gap
as the converge signal without computing it; and the artifacts both verbs read
are genuinely stamped, as this checkout's materialized hook, at v11.1.2 and in
step with the manifest, shows. The story's proof exhibits its central claim from
a real converge run and passes on the tree as it stands.

The cycle's new version-reporting surface does not change this, and the reason
is a boundary rather than an oversight: the corpus view is not a version verb,
so the Acceptance's antecedent never fires over it. That boundary is now the
determination's load-bearing hinge, and it is a narrow one — a surface whose
*purpose* becomes reporting versions would inherit clauses this one deliberately
does not honor, because the corpus view computes a comparison and recommends an
action where the Acceptance forbids both.

Two non-determinative notes for a later reader, one of the previous cycle's
three having been closed by the population pins added here. First, the Story
clause's "alongside what is installed" is delivered by the project surface only:
the session verb prints the governing plugin number and the governing conduct
number, and prints no installed number to compare against. That is not a
violation — the Acceptance's disjunction assigns the installed comparison
explicitly to the project surface, and the same Acceptance forbids the session
verb from comparing anything — but a reader should not expect drift to be
visible from `/ok-version` alone. Second, version literals are masked out of
citation anchors, so no citation here detects a stale stamp — only the harness
does.

This stops holding if: `ok-version` starts reading the plugin number from disk or
from the installed manifest instead of the injected line; the conduct number
stops coming from the active output style; either verb gains a verdict, a
comparison, a write, or a chained action (the span pin on the plumbline verb's
whole Run block breaks on any new branch); a family registers a third verb whose
purpose is reporting versions (the span pins on the three vendored-skill
registries break, forcing the population to be re-derived and the no-comparison
clause re-checked over the new member); the session-start template stops
carrying the version stamp, or the converge core stops substituting it (the
`cite:` on the template's `{{OK_PLANNER_VERSION}}` line breaks — that token is
not masked); the estate's stamped hook falls out of step with the carried
manifest (the harness's stamp-versus-manifest assertion turns red); the plumbline
converge stops vendoring and stamping the project binary; or the planner's
`proofs.sh` loses its `see-governing-versions` block or its `@story:` annotation
(both pinned below).

## Citations

- cite-node: plugins/ok/families/ok-planner/skills/ok-version/SKILL.md @ sha256:163265bfea1d
- cite-node: plugins/ok/families/ok-plumbline/skills/version/SKILL.md @ sha256:9c66146b4532
- cite-span: plugins/ok/families/ok-planner/skills/ok-version/SKILL.md :: "### 1. Plugin version" +4 sha256:fa64ed7ea9dc
- cite: plugins/ok/families/ok-planner/skills/ok-version/SKILL.md :: "find the line that begins `Conduct version:`"
- cite-span: plugins/ok/families/ok-planner/skills/ok-version/SKILL.md :: "Print exactly these two lines, filling in the values:" +5 sha256:88389b91b1c3
- cite: plugins/ok/families/ok-planner/skills/ok-version/SKILL.md :: "This skill never reads from disk, never edits files, and never chains to another skill."
- cite-span: plugins/ok/families/ok-plumbline/skills/version/SKILL.md :: "## Run" +14 sha256:addcfd9378bc
- cite: plugins/ok/families/ok-plumbline/skills/version/SKILL.md :: "They differ whenever the installed front door has moved ahead of the project's last converge"
- cite: plugins/ok/families/ok-plumbline/skills/version/SKILL.md :: "project (vendored): none"
- cite-span: plugins/ok/families/ok-planner/admin/converge :: "SKILLS = {" +13 sha256:19e4a08de7f5
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "const VENDORED_SKILLS = {" +11 sha256:59d445edacbf
- cite-span: plugins/ok/families/ok-workspaces/scripts/vendored-skills.js :: "const SKILLS = {" +6 sha256:c060ac5bd063
- cite-node: plugins/ok/skills/ok/SKILL.md @ sha256:c2b1f0e2e951
- cite: plugins/ok/families/ok-plumbline/admin/converge :: ""$BIN" > .ok-plumbline/bin/plumbline"
- cite: plugins/ok/families/ok-planner/scripts/hooks/session-start :: "ok-planner v{{OK_PLANNER_VERSION}} is materialized in this project."
- cite: .ok-planner/hooks/session-start :: "ok-planner v11.1.2 is materialized in this project."
- cite: plugins/ok/families/ok-planner/test/proofs.sh :: "# @story: see-governing-versions"
- cite-span: plugins/ok/families/ok-planner/test/proofs.sh :: "# see-governing-versions: a project deliberately converged behind the" +20 sha256:8d41c8919269
- cite-span: plugins/ok/families/ok-plumbline/test/run.sh :: "run_clone_self_containment_case() {" +32 sha256:00252415793d

## Notes

- note: the new corpus view (`plugins/ok/families/ok-planner/scripts/corpus-view`, `plugins/ok/families/ok-planner/browser/src/App.svelte`, story:trace-corpus-to-code) prints and renders a running-version-versus-estate-pinned-version echo (`corpus view: running v%s, ...`/`Running v{m.running_version}, ...`) on every response — the same "governing number alongside installed/pinned" shape this audit's population claim describes for the two verbs it enumerates, and the audit's own closing paragraph names an undetected third version verb as exactly the gap a change-inspection nomination would need to catch. No citation here spot-checked it, and the work item that added it frames it under decision:per-project-pinning rather than this story.
  adjudication: dismissed — the corpus view is not a version verb, and this story's Acceptance is a conditional whose antecedent is the consumer invoking one. `/browse` is invoked to trace the corpus; its version line is the payload-fallback provenance disclosure `decision:per-project-pinning` requires of every read-only verb that can fall back to the front door's carried copy (`audit`, `budget`, `patterns`, `suggest`, `explain`, `ci`, `port`, `starter` all carry one), widened to name the estate's stamp because its answers are corpus-version dependent. `checks/text-presence` asserts both of its version strings under `per-project-pinning`, not under this story. The dismissal is deliberately narrow, and the reason is recorded so a later reader can re-open it on the right trigger: were the corpus view counted a version verb, this audit would be **violated**, because its announcement computes a comparison (`version_agrees`) and emits a directive ("Run /ok to converge"), both of which Acceptance clause 2 forbids. A surface whose stated purpose becomes reporting versions therefore does bear on this determination and must be re-adjudicated. Separately, and regardless of this dismissal, the enumeration gap the nomination exploited is now closed: the three families' vendored-skill registries and the front door's single skill file are pinned under Citations as the population source, so a genuinely new version verb moves a hash here rather than needing another judged nomination.
