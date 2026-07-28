---
audit: see-governing-versions
artifact: story:see-governing-versions
determination: satisfied
audited: 2026-07-28T00:00:00Z
artifact-hash: sha256:bb20bb539343
---

# Do the version verbs echo what actually governs this session or project, rather than what is installed?

## Claims

**Why this is a re-audit, and what moved.** The design artifact is unchanged
(hash identical); the staleness came from the whole-file pin on the planner's
`proofs.sh`, which this cycle's work extended with an unrelated proof block. The
`see-governing-versions` block itself is byte-unchanged — its span pin hashes
identically — so nothing this audit rests on moved. Every claim below was
nevertheless re-run against the tree.

**Title / Story (quantified) — "see which plugin version actually governs my
current session or project, alongside what is installed."** Honored. The
population of version verbs was re-enumerated from reality: every `skills/*/`
directory under all three family directories and the front-door plugin was
listed — twenty-five verb directories plus the planner's `_shared/` — and
exactly two are version verbs, one per surface the Story names: the planner
family's `ok-version` for the session surface, and the plumbline family's
`version` for the project surface. Neither `ok-workspaces` nor the `/ok`
administrator carries one. Both verb files are pinned whole below, so a rewrite
of either forces a re-audit.

**Acceptance 1a — "it echoes the governing numbers — what this session was
injected with and the conduct actually loaded."** Honored, and "actually" is
load-bearing in both halves. The plugin number is read from the SessionStart
hook's injected context line, with `unknown` when that line is absent — never
from the installed manifest. The conduct number is read from the active output
style — "This is the conduct **actually governing the session**, which is why it
comes from the output style rather than the session-start line" — with
`unstamped` as the fallback. Unchanged this cycle.

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
writes."** Honored. The planner verb's opening states "No disk read, no
comparison, no verdict", its report step prints exactly two labelled lines, and
it closes "This skill never reads from disk, never edits files, and never chains
to another skill. Report and stop." The project-surface verb's whole body is a
read-only shell block printing two labelled lines and nothing else; its two
branches are presence tests on a file (`[ -x "$payload" ]`), not version
comparisons — no branch compares the two numbers and neither emits a judgement
about which is newer.

**Acceptance 3 — "a gap between governing and installed is the signal that
convergence is available."** Honored as text rather than as a computed verdict,
which is what the previous clause requires: "They differ whenever the installed
front door has moved ahead of the project's last converge, and that gap is the
useful signal: the project keeps linting at its pinned version until the owner
converges deliberately."

**Acceptance 4 — "The stamped artifacts and pinned copies the verbs read are
real."** Honored, and re-checked against this checkout. The session-start hook
template carries the `{{OK_PLANNER_VERSION}}` token, the planner converge core
substitutes the suite version into it at materialization, and this repository's
own materialized hook carries the literal `ok-planner v11.0.0 is materialized in
this project.` — matching the front-door manifest's `11.0.0`, with no artifact
in the estate left at a prior stamp (the cycle's newly materialized
`bin/source-graph` reads `11.0.0` like the rest). On the plumbline side the
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
`v11.0.0`.

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
are genuinely stamped, as this checkout's materialized hook, at v11.0.0 and in
step with the manifest, shows. The story's proof exhibits its central claim from
a real converge run and passes on the tree as it stands.

Three non-determinative notes for a later reader. First, the Story clause's
"alongside what is installed" is delivered by the project surface only: the
session verb prints the governing plugin number and the governing conduct
number, and prints no installed number to compare against. That is not a
violation — the Acceptance's disjunction assigns the installed comparison
explicitly to the project surface, and the same Acceptance forbids the session
verb from comparing anything — but a reader should not expect drift to be
visible from `/ok-version` alone. Second, version literals are masked out of
citation anchors, so no citation here detects a stale stamp — only the harness
does. Third, the population of version verbs is enumerated by directory listing,
and no citation pins that listing: the two whole-file pins catch a *rewrite* of
either verb but not the *appearance of a third*, which would reach this audit
only through a judged change-inspection nomination.

This stops holding if: `ok-version` starts reading the plugin number from disk or
from the installed manifest instead of the injected line; the conduct number
stops coming from the active output style; either verb gains a verdict, a
comparison, a write, or a chained action (the span pin on the plumbline verb's
whole Run block breaks on any new branch); the session-start template stops
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
- cite: plugins/ok/families/ok-plumbline/admin/converge :: ""$BIN" > .ok-plumbline/bin/plumbline"
- cite: plugins/ok/families/ok-planner/scripts/hooks/session-start :: "ok-planner v{{OK_PLANNER_VERSION}} is materialized in this project."
- cite: .ok-planner/hooks/session-start :: "ok-planner v11.0.0 is materialized in this project."
- cite: plugins/ok/families/ok-planner/test/proofs.sh :: "# @story: see-governing-versions"
- cite-span: plugins/ok/families/ok-planner/test/proofs.sh :: "# see-governing-versions: a project deliberately converged behind the" +20 sha256:8d41c8919269
- cite-span: plugins/ok/families/ok-plumbline/test/run.sh :: "run_clone_self_containment_case() {" +32 sha256:00252415793d
