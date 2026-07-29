---
audit: session-awareness
artifact: story:session-awareness
determination: satisfied
audited: 2026-07-27T23:45:00Z
artifact-hash: sha256:4c0ea55fd98f
---

# Does a session in a converged project open with the governing versions named, the concept TOC injected with its read-before-you-define framing, verbs discovered from the vendored skills alone, and nothing injected where there is no estate?

Refreshed only: the design artifact's hash is unchanged and no nomination
implicates this audit. `test/proofs.sh` gained per-story timing
instrumentation across the whole harness; inside this story's cited span the
only change is one inserted `section session-awareness see-governing-versions`
marker line immediately after the section header, ahead of the converged-
project fixture setup — the other 29 lines are byte-identical and every
assertion the span vouches for still runs. Citation re-pinned; the
determination and every claim below stand on the same evidence as the prior
audit.

## Claims

**Title + Story — "every session in my project starts already briefed on the
governing versions and on my project's concept vocabulary, so that agents use
my terms correctly and discover my verbs without me pasting context or
repeating rules."** Two real, materialized surfaces deliver this: the planner's
session-start hook, executed from the project's own estate through a consented
`SessionStart` entry in `.claude/settings.json`, and — for the user who
installed it — the conduct plugin's own session-start hook, declared in its
`hooks.json`. Honored.

**Acceptance conjunct 1 — "a banner names the governing versions."** The
planner hook's context string opens `ok-planner v{{OK_PLANNER_VERSION}} is
materialized in this project`, the placeholder filled at converge time with the
suite version the project was converged to; the conduct's hook announces
`ok-conduct <CONDUCT_VERSION> is installed for this user`, reading the stamp
from the output-style body actually loaded. Exercised: the harness converges a
fresh project through the real converge core, runs the materialized hook for
real, and asserts the banner names the carried version; the companion
`see-governing-versions` assertions prove the number comes from the project's
own stamp by rewriting it to `9.0.0-behind` and observing the hook report that
instead of the carried version. Honored.

**Acceptance conjunct 2 — "and, where a corpus exists, the concept catalog's
table of contents is injected, directing agents to read a term's full
definition before using it."** The hook injects the catalog only when
`design/concepts.md` is present — the conditional is the file test, so a
project without a corpus gets the banner alone — prefixed by a framing sentence
that names the file and instructs the reader to open the concept's own file
before defining or invoking a term and not to paraphrase from prior context.
Exercised: the harness seeds a one-entry catalog in the converged fixture, runs
the hook, and asserts both the framing sentence and the fixture's own TOC entry
appear in the payload. Honored.

**Acceptance conjunct 3 — "the suite's verbs are discovered from the vendored
skills' own descriptions … with no separate skills briefing injected beside
them."** The hook's payload says exactly that ("Its verbs are the vendored
skills under .claude/skills/"), injects no verb table, and its header comment
states it injects exactly two things. The converge core retires the
skills-index context payload earlier versions materialized, deleting it on
converge rather than merely no longer writing it, so no stale briefing survives
a converge. Honored.

**Acceptance conjunct 4 — "each user-facing verb carrying its activation guard
and the plumbing class its documented machine driver."** Honored, and the
quantifier was enumerated from reality rather than from the payload's own
wording. The population is the vendored skill set the converge core writes —
ten planner verbs under `.claude/skills/` — and every description was read
this cycle. Nine carry the guard sentence "Never auto-triggered by conversation
content" verbatim; the tenth, `verify-issues`, does not carry it (checked: zero
occurrences) and is the plumbing class, its description naming its machine
drivers ("invoked by a certify gate after its architect promotes issues, or by
plan-sprint when a legacy issues.jsonl needs converting"). The split is not
taken on trust: a repository maintenance check registered under
`decision:slash-only-activation` enumerates every skill file in the payload
*and* in this repo's vendored directory, requires the guard on everything not
allowlisted as plumbing, requires its absence on everything that is, and
derives each plumbing member's driver from the suite's other skill bodies
rather than from the allowlist comment — so a guard-less skill nothing drives
is a finding. Run here this cycle: exit 0. The harness additionally asserts
negatively that the payload does *not* claim every vendored skill carries the
guard, which is the overclaim this wording replaced.

**Acceptance conjunct 5 — "when the user has the conduct installed, the
conduct's own per-turn reminder re-anchors delivery rules."** The conduct
plugin declares a `UserPromptSubmit` hook in its own `hooks.json` (read here:
the declaration is present beside the `SessionStart` one) and its
implementation emits a delivery-rules reminder at a per-turn cadence
(`REMINDER_EVERY=1`), no-oping silently when `jq` is absent or the transcript
cannot be read. Scoped by the story to the conduct-installed case, which is a
user-scoped choice outside any project. Honored.

**Acceptance conjunct 6 — "The materialized session hook and context payload
are real."** The harness asserts the hook is materialized into the estate and
executable, runs it, checks the exit status, and checks that the output is a
`SessionStart` payload with `additionalContext`. Honored.

**Falsifier — "A fresh session cannot name the governing versions or defines
corpus terms by paraphrase instead of reading the catalog; the injection
reflects the installed plugin rather than what this project was converged to;
sessions in projects without the estate are disturbed at all; or session start
injects a briefing that duplicates what the vendored skill set already
carries."** None obtains. The second is directly refuted by the
deliberately-behind fixture: the hook reports the project's own stamp, not the
carried version. The third is asserted directly — an unintegrated fixture has
neither the estate hook nor any settings wiring, so nothing fires; and the
wiring is a consented `.claude/settings.json` entry, never a machine-global
hook, so there is no path by which an unintegrated project could be reached.
The fourth is refuted by the retirement of the skills-index payload and by the
payload's own text.

**Proof-field span.** The Proof names a demo in which a fresh session in a
converged project names the governing versions and defines a project concept by
reading its catalog file unprompted, while the same questions in an
unintegrated project show no injection. The deterministic half — the
materialized hook's actual output on a real converged fixture, and the absence
of hook and wiring on an unintegrated one — is exercised for real, not
modelled; all eight assertions pass on the current tree. The agent's subsequent
*behaviour* on receiving the injection (reading the file rather than
paraphrasing) is prompt-realized and is carried by the framing sentence the
harness asserts verbatim.

## Determination

**Satisfied.** The hook is a real materialized executable, run for real by the
harness on a project converged by the actual converge core; its payload names
the version the project was converged to (proved distinct from the carried
version by the behind-fixture), injects the project's own concept catalog with
its read-before-you-define framing when and only when a corpus exists, and
describes the verb surface without duplicating it and without overclaiming the
activation guard over the plumbing class — a claim checked here against the
enumerated vendored set and independently enforced by a repository check that
exits 0 on this tree. An unintegrated project has neither hook nor wiring. The
conduct's per-turn reminder exists as a declared user-scoped hook with a real
implementation.

This stops holding if: the banner string stops carrying the version placeholder
or the hook stops being materialized project-side (both `cite-span`s break);
the concept-TOC block stops being conditional on the catalog's presence or
loses its framing sentence; a separate skills briefing is reintroduced into the
payload, or the retired skills-index payload stops being swept; the payload
reverts to claiming every vendored verb carries the guard; a vendored verb
loses its guard without joining the plumbing allowlist, or joins it with no
documented driver (the `activation-guard` check is the population source and
breaks first); the conduct's `UserPromptSubmit` declaration is removed (the
`cite-file` pin on its `hooks.json` breaks); or a hook or wiring begins
appearing in projects with no estate.

## Citations

- cite: plugins/ok/families/ok-planner/scripts/hooks/session-start :: "# @story: session-awareness"
- cite-span: plugins/ok/families/ok-planner/scripts/hooks/session-start :: "context="ok-planner v{{OK_PLANNER_VERSION}} is materialized in this project." +1 sha256:03ae4cb9255c
- cite-span: plugins/ok/families/ok-planner/scripts/hooks/session-start :: "if [ -f "${OK_DIR}/design/concepts.md" ]; then" +7 sha256:317d2bb2d23a
- cite: plugins/ok/families/ok-planner/scripts/hooks/session-start :: "hookSpecificOutput"
- cite: .ok-planner/hooks/session-start :: "the plumbing verbs the suite's own machinery drives say so in their own descriptions"
- cite: plugins/ok/families/ok-planner/admin/converge :: "for retired in context/skills-index.md hooks/user-prompt-submit; do"
- cite: checks/activation-guard :: "# @decision: slash-only-activation"
- cite-span: plugins/ok/families/ok-planner/test/proofs.sh :: "# --- session-awareness + see-governing-versions" +30 sha256:bb12b1e0ed14
- cite: plugins/ok/families/ok-planner/test/proofs.sh :: "session-awareness: an unintegrated project has neither hook nor wiring"
- cite: plugins/ok-conduct/hooks/session-start :: "context="ok-conduct ${CONDUCT_VERSION} is installed for this user."
- cite: plugins/ok-conduct/hooks/user-prompt-submit :: "reminder="ok-conduct active."
- cite-node: plugins/ok-conduct/hooks/hooks.json @ sha256:3a1d67b6d421
- cite-node: checks/activation-guard @ sha256:6ae9a2ca82fd
- cite-node: .claude/skills/verify-issues/SKILL.md @ sha256:52a57cb4e226
- cite-node: plugins/ok/families/ok-planner/scripts/hooks/session-start @ sha256:36c37d8090fb
