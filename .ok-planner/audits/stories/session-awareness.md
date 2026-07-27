---
audit: session-awareness
artifact: story:session-awareness
determination: satisfied
audited: 2026-07-27T13:45:00Z
artifact-hash: sha256:4c0ea55fd98f
---

# Does a session in a converged project open with the governing versions named, the concept TOC injected with its read-before-you-define framing, verbs discovered from the vendored skills alone, and nothing injected where there is no estate?

## Claims

**Title + Story — "every session in my project starts already briefed on the
governing versions and on my project's concept vocabulary."** Two real,
materialized surfaces deliver this: the planner's session-start hook, executed
from the project's own estate through the consented `SessionStart` entry, and —
for the user who installed it — the conduct plugin's own session-start hook.
Honored.

**Acceptance conjunct 1 — "a banner names the governing versions."** The
planner hook's context string opens `ok-planner v{{OK_PLANNER_VERSION}} is
materialized in this project`, the placeholder filled at converge time with the
suite version the project was converged to; the conduct's hook announces
`ok-conduct <CONDUCT_VERSION> is installed for this user`, reading the stamp
from the output-style body actually loaded. Exercised: the harness converges a
fresh project, runs the materialized hook for real, and asserts the banner
names the carried version; the companion see-governing-versions assertions
prove the number comes from the project's own stamp by rewriting it to
`9.0.0-behind` and observing the hook report that instead of the carried
version. Honored.

**Acceptance conjunct 2 — "and, where a corpus exists, the concept catalog's
table of contents is injected, directing agents to read a term's full
definition before using it."** The hook injects the catalog only when
`design/concepts.md` is present, prefixed by a framing sentence naming the file
and instructing the reader to open the concept's own file before defining or
invoking a term and not to paraphrase from prior context. Exercised: the
harness seeds a one-entry catalog in the converged fixture, runs the hook, and
asserts both the framing sentence and the fixture's own TOC entry appear in the
payload. Honored.

**Acceptance conjunct 3 — "the suite's verbs are discovered from the vendored
skills' own descriptions … with no separate skills briefing injected beside
them."** The hook says exactly that in its payload and injects no verb table;
its header comment states it injects exactly two things. The converge core
retires the skills-index context payload earlier versions materialized, so no
stale briefing survives a converge. Honored.

**Acceptance conjunct 4 — "each user-facing verb carrying its activation guard
and the plumbing class its documented machine driver."** The payload states the
split in those terms — user-facing verbs activate only on their explicit slash
command, some naming one non-human caller, and the plumbing verbs the suite's
machinery drives say so in their own descriptions. That statement is true of
the vendored set on disk (thirty-four of thirty-six skill files carry the
guard; the two that do not are `verify-issues` in source and vendored form,
whose description names its machine drivers). Exercised negatively: the harness
asserts the payload does *not* claim every vendored skill carries the guard,
which is the overclaim this wording replaced. Honored.

**Acceptance conjunct 5 — "when the user has the conduct installed, the
conduct's own per-turn reminder re-anchors delivery rules."** The conduct
plugin declares a `UserPromptSubmit` hook in its own `hooks.json` and its
implementation emits a delivery-rules reminder at a per-turn cadence
(`REMINDER_EVERY=1`), no-oping silently when it cannot read the transcript.
Scoped by the story to the conduct-installed case, which is a user-scoped
choice outside any project. Honored.

**Acceptance conjunct 6 — "The materialized session hook and context payload
are real."** The harness asserts the hook is materialized into the estate and
executable, runs it, checks the exit status, and checks that the output is a
`SessionStart` payload with `additionalContext`. Honored.

**Falsifier — "cannot name the governing versions … the injection reflects the
installed plugin rather than what this project was converged to … sessions in
projects without the estate are disturbed at all … session start injects a
briefing that duplicates what the vendored skill set already carries."** None
obtains. The second is directly refuted by the deliberately-behind fixture: the
hook reports the project's own stamp, not the carried version. The third is
asserted directly — an unintegrated project has neither the estate hook nor any
settings wiring, so nothing fires. The fourth is refuted by the retirement of
the skills-index payload and by the payload's own text.

**Proof-field span.** The Proof names a demo in which a fresh session in a
converged project names the governing versions and defines a project concept by
reading its catalog file unprompted, while the same questions in an
unintegrated project show no injection. The deterministic half — the
materialized hook's actual output on a real converged fixture, and the absence
of hook and wiring on an unintegrated one — is exercised. The agent's
subsequent *behaviour* on receiving the injection (reading the file rather than
paraphrasing) is prompt-realized and is carried by the framing sentence the
harness asserts verbatim.

## Determination

**Satisfied.** The hook is a real materialized executable, run for real by the
harness on a project converged by the actual converge core; its payload names
the version the project was converged to (proved distinct from the carried
version by the behind-fixture), injects the project's own concept catalog with
its read-before-you-define framing when a corpus exists, and describes the verb
surface without duplicating it or overclaiming the activation guard over the
plumbing class. An unintegrated project has neither hook nor wiring. The
conduct's per-turn reminder exists as a declared user-scoped hook.

This stops holding if: the banner string stops carrying the version placeholder
or the hook stops being materialized project-side (both `cite-span`s break); the
concept-TOC block stops being conditional on the catalog's presence or loses
its framing sentence; a separate skills briefing is reintroduced into the
payload, or the retired skills-index payload stops being swept; the payload
reverts to claiming every vendored verb carries the guard; the conduct's
`UserPromptSubmit` declaration is removed (the `cite-file` pin on its
`hooks.json` breaks); or a hook or wiring begins appearing in projects with no
estate.

## Citations

- cite: plugins/ok/families/ok-planner/scripts/hooks/session-start :: "# @story: session-awareness"
- cite: plugins/ok/families/ok-planner/scripts/hooks/session-start :: "context="ok-planner v{{OK_PLANNER_VERSION}} is materialized in this project."
- cite-span: plugins/ok/families/ok-planner/scripts/hooks/session-start :: "if [ -f "${OK_DIR}/design/concepts.md" ]; then" +7 sha256:317d2bb2d23a
- cite: plugins/ok/families/ok-planner/scripts/hooks/session-start :: "hookSpecificOutput"
- cite: plugins/ok/families/ok-planner/admin/converge :: "for retired in context/skills-index.md hooks/user-prompt-submit; do"
- cite-span: plugins/ok/families/ok-planner/test/proofs.sh :: "# --- session-awareness + see-governing-versions" +30 sha256:4ccd8fc8ca97
- cite: plugins/ok/families/ok-planner/test/proofs.sh :: "session-awareness: an unintegrated project has neither hook nor wiring"
- cite: plugins/ok-conduct/hooks/session-start :: "context="ok-conduct ${CONDUCT_VERSION} is installed for this user."
- cite: plugins/ok-conduct/hooks/user-prompt-submit :: "reminder="ok-conduct active."
- cite-file: plugins/ok-conduct/hooks/hooks.json @ sha256:3a1d67b6d421
