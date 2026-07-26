---
issue: plumbline-discovery-marker-undocumented
kind: discover
category: conflicting
artifacts:
  - decision:filesystem-discovery-markers
  - concept:integration-contract
status: verified
opened: 2026-07-25T02:16:44Z
---

# The dispatcher honors a discovery marker the contract doesn't document

`/ok` decides whether a project integrates ok-plumbline by checking the filesystem, and its skill text honors two signals: the pre-migration config `.plumbline.json` at the root, or the materialized cheatsheet at `.claude/rules/plumbline-cheatsheet.md`. The dispatcher claims both come "from the contract's current-conformance section" — but `docs/integration-contract.md` documents only the first. The dispatcher is carrying per-plugin knowledge the contract doesn't back, and its own citation of its source is inaccurate. The corpus knows: `decision:filesystem-discovery-markers`' Proof section says "one such undocumented marker already circulates" and defers the fix to the intake — this issue is that deferral.

The two signals aren't functionally equivalent. `.plumbline.json` is a real fallback path the plugin's binary still reads and true-up still migrates — a working pre-migration marker in the decision's own sense. The cheatsheet is inert: nothing in ok-plumbline reads it back; true-up only writes it. Under current true-up ordering a project can't reach "cheatsheet present, estate absent" on its own — that state requires a hand-copied cheatsheet, a manually deleted estate, or a layout old enough to predate the config (plausible given the plugin's ok-standards history, but unevidenced in the repo). Against that, `story:one-command-suite-upkeep`'s falsifier — "an integrated plugin goes undiscovered" — argues for keeping the net wide.

## Options

- **Document the marker and close the general gap** — add the cheatsheet path to the contract's ok-plumbline entry, and add an invariant to `concept:integration-contract`: every marker the dispatcher honors is contract-documented. No code change (the dispatcher already matches); the decision's Proof note resolves. Cost: the contract codifies a signal the plugin's own binary treats as non-load-bearing.
- **Drop the marker from discovery** — scope pre-migration markers to paths a plugin's own logic still reads; edit the dispatcher to drop the cheatsheet clause. Tighter, but risks the undiscovered-plugin falsifier in the one edge case, with no evidence for how real that case is.
- **Document narrowly, skip the invariant** — fixes this citation gap only; the next undocumented marker recreates the problem.

The ruling decides: does the cheatsheet stay an honored marker (documented, narrowly or with the general invariant), or does discovery narrow to `.plumbline.json` only?

## Ruling

> Recommended ruling (/verify-issues): document the cheatsheet marker in the contract's ok-plumbline current-conformance entry, and add the general invariant to `concept:integration-contract` — every discovery marker the dispatcher honors must be contract-documented.
>
> Rationale: the existing invariant ("the contract, not the dispatcher, is where per-plugin knowledge is documented") already implies the general rule — this makes it enforceable instead of aspirational, and the next plugin's undocumented marker becomes a findable violation rather than a repeat of this issue. Keeping the marker itself honors the discovery story's falsifier: a false "not integrated" costs a wrong bootstrap offer, while the marker's inertness costs nothing. Close call versus dropping the marker; evidence of a real cheatsheet-only project would flip it.

<!-- Owner: this is a recommendation, not your decision. Leave it
as-is to accept — the next /plan-sprint carries it, naming the
generated/recommended batches at sign-off. Edit the text to
redirect, empty the section to discuss live, or delete this note
to adopt the ruling as your own. -->
