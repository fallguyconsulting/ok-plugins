---
audit: ratchet-over-soft-start
artifact: decision:ratchet-over-soft-start
determination: satisfied
audited: 2026-07-28T00:09:44Z
artifact-hash: sha256:e2bac66cc14c
---

# Is adoption eased by a one-way baseline ratchet in the plugin's estate, with the checks strict from day one and no disabling switch anywhere in the config schema?

## Claims

**Title — "Adoption eases by one-way ratchet, never by softened checks."** Both
halves are implemented: the budget command is the only adoption accommodation
the family ships, and the check set is fixed at two with no way to reduce it.
Honored.

**Choice clause 1 — "records a baseline count in a budget file inside the
plugin's estate."** The budget command's `save` action writes the total count
and a per-check breakdown to the canonical estate path
`.ok-plumbline/budget.json`, creating the estate directory if needed. I read the
whole command to check whether any branch can record elsewhere: the read path
resolves to a pre-migration root location when only that one exists, but the
*write* is unconditionally to the canonical estate path — the variable holding
the legacy location is never a write target. "Records … inside the estate" is
therefore true without qualification. Honored.

**What this cycle removed.** The Choice previously also claimed the baseline was
"migrated there from any earlier root-level location by the lifecycle verb"; the
repair deleted that clause as a historical migration statement. The mechanism
still exists — the family's converge core moves a root `.plumbline-budget.json`
into the estate, preferring `git mv`, and stops with a conflict message when both
locations exist — and the binary still reads the legacy location so a
not-yet-migrated project keeps working. That behaviour is now unclaimed rather
than removed, so nothing that was verified last cycle became false; it simply
stops being an obligation this audit tests. Cited below so a later reader can
find it.

**Choice clause 2 — "CI fails any change that increases it while accepting any
that holds or decreases it."** The check re-lints, compares against the recorded
count, and exits with the failing status only when the current count is greater,
printing the per-check deltas that grew; equal prints "at baseline" and exits
clean; lower prints how far below and exits clean. The GitHub and GitLab
templates the family emits both add the budget check as a step guarded on the
baseline file's existence. (The third emitted template is a pre-commit hook —
a local commit gate, not CI — and carries only the lint; the CI claim's subject
is unaffected.) The proof drives all three directions against a seeded
repository. Honored.

**Choice clause 3 — "a one-way ratchet."** The save action refuses with the
failing status when the current count exceeds the recorded one, naming the
excess per check, and directs the owner to a deliberate hand edit if they really
mean it. So no verb in the family can move the baseline up; only a reviewable
edit to a committed file can, which is the intended escape rather than a hole.
The proof asserts the refusal directly. Honored.

**Choice clause 4 — "The checks themselves stay strict from day one; there is no
soft start."** The lint runs both checks unconditionally on every invocation:
comment hygiene per file, then citation resolution over the collected set. There
is no phase-in, no severity level, and no first-run leniency; a fresh project
with no config gets the full comment rule immediately — which I re-exhibited
this cycle by converging a bare repository with no config and watching a single
stray comment come back as a blocking violation. Honored.

**Choice clause 5 (quantified) — "the config schema exposes no switch that
disables a check."** The population is every config key the binary honors,
enumerated from the sole config reader and cross-checked against the binary read
whole (pinned below) for any second reader. There are two: the citation entry
list and the ignore path list. Neither disables a check — the first adds
exemptions and obligations, the second scopes which files are walked, which is
path selection rather than check selection. A third key, the retired per-check
selector, is deliberately *not* honored: the reader records only that it is
present so diagnose can warn the owner to delete it, and both checks run
regardless. No command-line flag disables a check either; the only flag is the
line-range filter the edit hook uses. Honored.

**Rationale — "work continues immediately, regression is mechanically
impossible, and the baseline only ever moves down."** Regression is caught by the
check's exit status in CI; the baseline's downward-only movement is enforced by
save's refusal. "Mechanically impossible" is accurate for the tool surface: no
verb can raise it. Honored.

**Rationale — "which is also why no disabling switch ships at all."** Equivalent
to clause 5, confirmed over the enumerated key set. Honored.

## Determination

**satisfied.** The baseline is recorded only into the estate — the legacy root
location is a read fallback, never a write target — it fails CI on any increase
and passes on hold-or-decrease, and it cannot be raised by any verb the family
ships. Both checks run unconditionally, and the only two honored config keys
govern citation exemptions and path scope; the retired per-check selector is
read solely to warn about it. This cycle's repair dropped the migration clause
from the Choice, so the converge core's root-to-estate move is now unclaimed
behaviour rather than an audited obligation; it remains in place. Decisions carry
no proof obligation; the family's harness nevertheless drives save, the increase
failure, the hold, the decrease, the raise refusal, and the pre-migration read,
and runs green.

This stops holding if: save stops refusing to raise, or the check stops failing
on an increase; a config key is added that turns a check off, or the retired
per-check selector starts being honored (the whole-file pin catches any edit to
the binary); the budget write target moves out of the estate; or the emitted CI
templates drop the budget step.

## Citations

- cite-file: plugins/ok/families/ok-plumbline/bin/plumbline @ sha256:4f181feaed30
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function budgetCmd(action, target) {" +73 sha256:bc1df8e3883d
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function loadConfig(repoRoot) {" +26 sha256:32307f1ddbbc
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "const CI_TEMPLATES = {" +44 sha256:ffb2c2cbc05b
- cite-span: plugins/ok/families/ok-plumbline/admin/converge :: "if [ -f .plumbline-budget.json ] && [ ! -f .ok-plumbline/budget.json ]; then" +6 sha256:7a87d6b59498
- cite: plugins/ok/families/ok-plumbline/skills/budget/SKILL.md :: "Without args, the skill checks current usage against the saved baseline. Pass `save` to record a lower baseline: the ratchet is one-way in code, so `save` refuses (exit 2) when the current count is above the recorded one — raising a baseline is not something this verb can do."
- cite-span: plugins/ok/families/ok-plumbline/test/run.sh :: "run_ratchet_case() {" +35 sha256:796b9295ae88
- cite-span: plugins/ok/families/ok-plumbline/test/run.sh :: "run_adoption_proof() {" +98 sha256:9dbae600c267
