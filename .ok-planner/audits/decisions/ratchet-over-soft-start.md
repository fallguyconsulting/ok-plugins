---
audit: ratchet-over-soft-start
artifact: decision:ratchet-over-soft-start
determination: satisfied
audited: 2026-07-29T12:30:00Z
artifact-hash: sha256:e2bac66cc14c
---

# Adoption is eased by a one-way budget ratchet, and no config key softens a check

## Confirmation

Satisfied. The ratchet is the `budget` verb over a baseline file in the family's
estate, and the config surface has no switch that turns a check off.

- **A baseline in the estate.** `budget save` lints the target, writes
  `{ count, by_check }` to `.ok-plumbline/budget.json` (a pre-migration root
  baseline is still read until administration relocates it), and prints the
  recorded count.
- **CI fails increases, accepts holds and decreases.** `budget check` exits 2
  with a per-check breakdown when the count exceeds the baseline, and exits 0
  when it holds or falls, reporting how far below baseline it now is.
- **One-way.** `save` refuses (exit 2) when the current count is above the
  recorded one, naming the excess and directing the owner to fix or to edit the
  baseline file deliberately; the verb itself cannot raise it.
- **Exercised in both directions** by the harness: a baseline is recorded and
  the file exists; adding one violation fails the check; removing it passes;
  deleting a violation passes and is reported below baseline; adding two and
  running `save` is refused with "refusing to raise the baseline"; and a
  separate case confirms the pre-migration baseline location is still read.
- **No disabling switch.** Config loading recognizes exactly two keys —
  `citations` (validated per entry) and `ignore` (merged onto the default ignore
  list); nothing else it reads affects which checks run, and a lint pass always
  runs comment hygiene and citation resolution over the walked files. The one
  legacy shape a project might carry, a `checks` key, is not honored: it is
  reported by `diagnose` as retired with the statement that both checks always
  run. The strictness commitment is stated in the same terms in the `starter`
  verb's prose.

## Citations

- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "function budgetCmd(action, target) {"
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "          `plumbline budget: refusing to raise the baseline — ${count} violation(s) exceeds the recorded ` +"
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "    console.error(`plumbline budget: ${count} violation(s) exceeds baseline ${baselineCount} (+${count - baselineCount})`);"
- cite-node: plugins/ok/families/ok-plumbline/bin/plumbline#loadConfig @ sha256:02b57f5037c6
- cite-node: plugins/ok/families/ok-plumbline/bin/plumbline#runLint @ sha256:c4fd8a6c4b80
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "        checks.push(['warn', `config carries the retired "checks" key — both checks always run; remove the key`]);"
- cite: plugins/ok/families/ok-plumbline/skills/starter/SKILL.md :: "Both checks — comment hygiene and citation resolution — always run; the config exposes no switch that disables one. Plumbline's rule is strict by default (no comments except machine directives, configured citations, or docstrings in opt-in files); there is no "soft start" with checks disabled."
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#run_ratchet_case @ sha256:a075f0238ab9
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#run_adoption_proof @ sha256:74f88c33a7bd
