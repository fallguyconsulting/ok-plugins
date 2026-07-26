---
issue: plumbline-estate-dogfood-gap
kind: discover
category: vestigial
artifacts:
  - concept:estate
  - decision:per-project-pinning
status: verified
opened: 2026-07-25T02:17:33Z
---

# The lint plugin's current estate layout has zero in-repo instances

## Problem

Every fixture and the plugin's own self-config use the retired root-level config name; the current estate config layout exists only in prose and in the binary's lookup order, and the plugin self-lints using the layout its own lifecycle verb calls retired.

## Candidates

- Migrate the plugin's own config and fixtures to the current layout via a sprint
- Record the fixture set's use of the legacy layout as deliberate compatibility coverage in decision:per-project-pinning

## Discussion

**The question.** `ok-plumbline`'s own self-config and every one of its test fixtures use root-level `.plumbline.json`, the layout its own `true-up` skill describes as something it migrates *away from* ("migrating a root `.plumbline.json` from an earlier layout into" `.ok-plumbline/`). Should the plugin migrate its own instances to the current estate layout, or is the fixture set's use of the legacy layout deliberate compatibility coverage worth recording rather than fixing?

**Evidence, re-verified — confirmed, and total.** `plugins/ok-plumbline/.plumbline.json` (the plugin's own self-lint config) is a root-level file, not under `.ok-plumbline/`. Every fixture under `plugins/ok-plumbline/test/fixtures/*/` (twelve directories checked — `license-header`, `citation-file-unresolved`, `citation-glob-unresolved`, `disallowed-comment`, `regex-literals`, `comment-after-regex`, `citation-file-resolved`, `clean`, `docstring-opted-in`, `docstring-not-opted-in`, `citation-glob-resolved`, `machine-directives`) carries a root-level `.plumbline.json`, not a `.ok-plumbline/config.json`. There is no `.ok-plumbline/` directory anywhere in the plugin's own tree at all — the current layout genuinely has zero in-repo instances, confirming the Problem's title exactly.

**What the corpus says.** `concept:estate`'s What-it-is section defines an estate as "rooted in one dot-directory at the consumer repo root named for the plugin: declared configuration (including any stack profile)..." — for `ok-plumbline` that's `.ok-plumbline/`, per the plugin's own `true-up` skill description ("create `.ok-plumbline/`... migrating a root `.plumbline.json` from an earlier layout into it"). `concept:estate`'s Invariants don't address a plugin's own self-hosted config or its test fixtures at all — they describe consumer-project semantics (git-tracking is the owner's decision, records preserved indefinitely, bootstrap-by-consent) not the plugin repo's own dogfooding obligations. `decision:per-project-pinning` (bearing) is about a different property entirely — that materialized artifacts run from the project's own copy rather than the installed plugin's, so behavior doesn't shift silently on plugin update. It says nothing about config *location* or about fixtures deliberately covering a legacy format; recording "fixtures use the legacy layout on purpose" inside `per-project-pinning` would be attaching an unrelated claim to a decision about a different tradeoff — the decision's Choice, Rationale, and Alternatives are all about artifact execution source, not config file paths.

**What the code does today.** `bin/plumbline`'s config lookup order (referenced by the Problem as "the binary's lookup order") presumably checks `.ok-plumbline/config.json` before or in addition to root `.plumbline.json` for backward compatibility, but nothing in the plugin's own tree exercises the new path — every self-lint run and every fixture-driven test runs the plugin against the *old* layout exclusively, so the new layout's behavior (including its own migration path) is untested by the plugin's own suite.

**Candidates, and what each means.** Candidate 1 (migrate the plugin's own config and fixtures to the current layout) means moving `plugins/ok-plumbline/.plumbline.json` to `.ok-plumbline/config.json` and updating all twelve fixture directories similarly — this gives the plugin's own test suite actual coverage of the layout it tells consumers is current, but if fixtures are specifically testing lookup/migration behavior for the *legacy* path, blanket migration could silently drop that coverage unless done carefully. Candidate 2 (record it as deliberate compatibility coverage in `decision:per-project-pinning`) keeps the fixtures as legacy-format regression coverage for the migration path itself, framed as intentional — cheaper, no code churn, but doesn't address that the plugin's *own* self-config (not a fixture, not migration-test coverage) is also on the legacy layout, which reads less like deliberate coverage and more like the plugin never adopted its own convergence. A shape not filed: split the two — migrate the plugin's own self-config to `.ok-plumbline/config.json` (dogfooding the current layout for real), while adding one or two fixtures specifically for the root-`.plumbline.json`-migration path (explicit, minimal legacy coverage) and converting the rest to the current layout.

**What the ruling must decide.** Whether the plugin's own self-config and fixture set should be migrated to the current `.ok-plumbline/` layout (and if so, whether any fixtures should be deliberately kept on the legacy layout as migration-path coverage), or whether the current all-legacy state is acceptable as-is and should simply be documented as intentional.

## Ruling

<!-- Owner: write your decision here in your own words.
The next /plan-sprint picks it up. Leave empty to discuss
it live in a planning session instead. -->
