---
issue: readme-describes-the-retired-suite
kind: audit
category: product-intent
artifacts:
  - concept:document-type
status: retired
triage: question
opened: 2026-10-04T23:34:00Z
---

# The root README still describes the three-family suite, and nothing owns keeping it current

`README.md` is the marketplace's entry document: a reader learns from it what to install and what the install gives them. It still describes the three-family suite that sprint 2026-10-04-consolidate-into-ok-planner retired. decision:one-vendored-family now says everything the suite vendors comes from one family, ok-planner. A reader who follows the README expects families and verbs that no project converged by this release carries.

The stale passages:

- `:10-11` the payload's skill families; `:19-22` per-family administration; `:44-49` the ok-plumbline and ok-workspaces rows; `:63-68` the `/patterns`, `/budget`, `/open`, and `/close` verbs; `:70-76` per-family ceremony contributions; `:174-175` `plugins/ok/families/{ok-planner,ok-plumbline,ok-workspaces}`, where `plugins/ok/families/` now holds ok-planner alone; `:190` hub-row single-sourcing among the checks.
- `:9` says "The marketplace distributes exactly two user-scoped plugins", and the plugin table and the Layout list omit ok-web, which `.claude-plugin/marketplace.json` lists as a third plugin. This error predates the sprint (call i82).

## Why nothing fixed it

No work item and no document type claims `README.md`. The file carries no `/document` provenance stamp, and the project declares no document types: `.ok-planner/surface/documents/` does not exist. The README changes only when someone edits it by hand, as recent release commits did.

Sprint certification run converge-2026-10-04T060800 confirmed the stale description (defect i72). Its fixers may not edit prose, so the verifier sent the round-1 rewrite back, the round-2 fixer wrote the file back to base, and `README.md` now matches base 9c7aff7.

## What the corpus says

decision:documents-generated-per-type-and-placed says "Only declared types' targets are written; a project that keeps a hand-written root readme declares no type targeting it." Under that sentence, `README.md` is today a hand-written owner file. decision:placed-documents-are-records governs only a document the ceremony placed with a stamp, so it does not reach this README yet. story:ship-release-documents wants release documents generated from declared types "without anyone maintaining prose by hand". The suite-owned `.ok-planner/CLAUDE.md` goes further: "All documentation is typed: every document the tree carries — the root `README.md`, any `README.md`, everything under `docs/` ... — is one type's product, revised at every release." That sentence disagrees with the decision, which allows a hand-kept README. The decision is the corpus and governs; the suite-owned sentence would go upstream if the owner keeps the README by hand.

## Options

1. The owner revises `README.md` by hand before the next release. Cost: hand-kept prose drifts again at the next consolidation, and nothing notices.
2. Declare a document type that targets `README.md`, so each `/document` release revises it from the tree. Cost: the README becomes a placed record, out of agent context by default, and the owner steers it through the type rather than by editing the file. A type can carry an outline and prose to keep verbatim, so the owner keeps the passages they care about.
3. A follow-up sprint carries a work item that rewrites `README.md` for the one-family suite. Cost: a sprint for a prose fix, and the file stays hand-kept afterward.

Options 1 and 3 can pair with option 2 later.

The ruling decides who keeps the marketplace's entry document current.

## Ruling

Retired by the owner on 2026-10-04: fixed by hand. README.md now describes the one-family suite: three user-scoped plugins (ok, ok-conduct, ok-web) with install lines, the ok-planner family and what it covers, the per-run stack scripts, the audit's subject coverage and lint sweep, one-family layout under plugins/ok/families/ok-planner/, the current checks (no hub-row check), and the conduct version rule as decision:lockstep-suite-version now states it. The README stays hand-kept; no document type targets it.
