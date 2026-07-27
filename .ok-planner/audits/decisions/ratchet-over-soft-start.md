---
audit: ratchet-over-soft-start
artifact: decision:ratchet-over-soft-start
determination: satisfied
audited: 2026-07-27T13:00:38Z
artifact-hash: sha256:ca59690f8099
---

# Is adoption eased by a one-way baseline ratchet in the plugin's estate, with the checks strict from day one and no disabling switch?

## Claims

**1. Title / Choice — "Adoption eases by one-way ratchet, never by softened
checks."** The two halves are separately checkable and both hold: the ratchet
exists as a real mechanism (claims 2-4) and no softening surface exists
(claims 5-6). Honored.

**2. Choice — "records a baseline count in a budget file inside the plugin's
estate."** `budget save` lints the target, counts violations, buckets them by
check code, and writes `{count, by_check}` to
`<repoRoot>/.ok-plumbline/budget.json`, creating the estate directory if
needed. The canonical path is always the estate path — the pre-migration
root-level file is read if it is the one that exists, but a fresh save is
written to the estate. Harness: `budget save` in a scratch project produces
`.ok-plumbline/budget.json`, asserted by path. Honored.
`cite-span: … bin/plumbline "function budgetCmd(action, target) {" +73`,
`cite-span: … test/run.sh "run_ratchet_case() {" +35`.

**3. Choice — "migrated there from any earlier root-level location by the
lifecycle verb."** The family's converge core — the surface the front door's
administration drives — `git mv`s (falling back to `mv`) a root
`.plumbline-budget.json` to `.ok-plumbline/budget.json` when the estate copy is
absent, and prints a `CONFLICT` line for the owner when both exist rather than
silently picking one. Until that migration runs, the budget commands still read
the pre-migration location, so an unconverged project is never told its
baseline vanished; the harness exercises exactly that by moving the saved
baseline back to the root name and confirming the check still reads it.
Honored.
`cite-span: … admin/converge "if [ -f .plumbline-budget.json ] && [ ! -f .ok-plumbline/budget.json ]; then" +6`,
`cite-span: … bin/plumbline "function budgetCmd(action, target) {" +73`,
`cite-span: … test/run.sh "run_ratchet_case() {" +35`.

**4. Choice — "CI fails any change that increases it while accepting any that
holds or decreases it: a one-way ratchet."** Three-way disposition in
`budget check`: `count > baseline` → per-check deltas printed, exit 2;
`count < baseline` → "below baseline" message, exit 0; equal → "at baseline",
exit 0. The CI templates the family emits wire that exit code into the
pipeline as its own step, conditioned on a baseline existing. The ratchet is
one-way in code as well as in policy: `budget save` *refuses* to raise an
existing baseline, exiting 2 with the per-check overage and telling the owner
that raising it is a deliberate, reviewable hand edit. Harness: baseline
recorded, +1 violation → exit 2 "exceeds baseline", holding change → exit 0,
reducing change → exit 0 "below baseline", and a save that would raise →
exit 2 "refusing to raise the baseline". Honored.
`cite-span: … bin/plumbline "function budgetCmd(action, target) {" +73`,
`cite: … bin/plumbline "        run: node .ok-plumbline/bin/plumbline budget check"`,
`cite-span: … test/run.sh "run_adoption_proof() {" +98`.

**5. Choice — "The checks themselves stay strict from day one; there is no
soft start."** The lint driver runs both checks unconditionally on every
invocation — comment hygiene per file, then citation resolution across the
collected set — with no threshold, grace period, warn-only mode, or
first-run leniency anywhere in the path. The two adopter-facing surfaces say
the same thing in prose (the starter verb's own text: both checks always run,
no switch, no soft start). Honored.
`cite-span: … bin/plumbline "function runLint(target) {" +18`,
`cite: … skills/starter/SKILL.md "Both checks — comment hygiene and citation resolution — always run…"`.

**6. Choice — "the config schema exposes no switch that disables a check."**
Quantifier over the config surface; population source is the loader, which is
the sole reader of the config file and therefore the whole schema. It consumes
exactly two keys — `citations` (validated per entry) and `ignore` (path
prefixes appended to the defaults) — and neither can suppress a check: `ignore`
scopes *which files* are walked, not *which rules* apply. A third key,
`checks`, is recognized only to be reported: the loader records its presence
and diagnose emits a warning that it is retired and both checks always run.
Verified adversarially by writing
`{"checks":{"comment_hygiene":false,"citation_resolution":false}}` into a
scratch project's config beside a violating file: the lint still reported the
violation and exited 2. Honored.
`cite-span: … bin/plumbline "function loadConfig(repoRoot) {" +26`,
`cite: … bin/plumbline "        checks.push(['warn', \`config carries the retired "checks" key …"`.

**7. Rationale capability claim — "the baseline only ever moves down."**
Carried by the `budget save` refusal in claim 4: the only in-tool writer of the
baseline declines to write a larger number, so the recorded count is
monotonically non-increasing except by a hand edit the message explicitly
frames as the owner's deliberate act. Honored.
`cite-span: … bin/plumbline "function budgetCmd(action, target) {" +73`.

## Determination

**satisfied.** The ratchet is real and one-way in both directions that matter:
`check` fails an increase and passes a hold or a decrease, and `save` refuses
to raise. The baseline lives in the estate, and the family's converge core
migrates a pre-migration root-level baseline into it while the tool keeps
reading the old location until that happens. On the negative half of the
Choice, the config loader consumes only `citations` and `ignore`, the retired
`checks` key is inert-and-warned, and a hand-written disabling config was
confirmed live to change nothing.

Two honest boundaries. `ignore` does let an adopter exclude paths from the
walk, which shrinks the population a check sees — but it is a scoping key, not
a per-check switch, and the Choice's alternatives list rejects "per-check
config flags that skip a check outright", which is a different thing. And the
budget file is plain JSON on disk: an owner can always edit the count by hand.
The Choice does not claim otherwise — the refusal message names hand-editing
as the deliberate, reviewable escape, which is the point of a ratchet rather
than a lock.

This stops holding if: `budget save` drops the refuse-to-raise guard;
`budget check` stops exiting non-zero on an increase, or the CI templates drop
the budget step; `loadConfig` starts honoring `checks` (or any new key) as a
suppression; `runLint` gains a conditional around either check; or the converge
core stops migrating the root-level baseline while the tool stops reading it,
which would silently reset an unconverged project's ratchet.

## Citations

- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function budgetCmd(action, target) {" +73 sha256:bc1df8e3883d
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function loadConfig(repoRoot) {" +26 sha256:32307f1ddbbc
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function runLint(target) {" +18 sha256:5d204f7417f4
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "        checks.push(['warn', `config carries the retired "checks" key — both checks always run; remove the key`]);"
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "        run: node .ok-plumbline/bin/plumbline budget check"
- cite-span: plugins/ok/families/ok-plumbline/admin/converge :: "if [ -f .plumbline-budget.json ] && [ ! -f .ok-plumbline/budget.json ]; then" +6 sha256:7a87d6b59498
- cite: plugins/ok/families/ok-plumbline/skills/starter/SKILL.md :: "Both checks — comment hygiene and citation resolution — always run; the config exposes no switch that disables one. Plumbline's rule is strict by default (no comments except machine directives, configured citations, or docstrings in opt-in files); there is no "soft start" with checks disabled."
- cite-span: plugins/ok/families/ok-plumbline/test/run.sh :: "run_ratchet_case() {" +35 sha256:796b9295ae88
- cite-span: plugins/ok/families/ok-plumbline/test/run.sh :: "run_adoption_proof() {" +98 sha256:289e348afb4d
