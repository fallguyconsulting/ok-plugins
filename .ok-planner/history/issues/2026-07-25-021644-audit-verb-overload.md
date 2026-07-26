---
issue: audit-verb-overload
kind: discover
category: overloaded
artifacts:
  - concept:skill
  - story:corpus-audit
  - story:rules-compliance-report
status: promoted
opened: 2026-07-25T02:16:44Z
sprint: 2026-07-25-ruled-intake-drain.md
---

# Three plugins ship a verb named `audit`; nothing addresses the collision

ok-planner, ok-plumbline, and ok-workspaces each ship a skill literally named `audit`, each telling users to type `/audit`, and the three do unrelated things: whole-corpus design review, lint-violation report, and workspace-discipline sweep. In a project integrating more than one of them (this repo integrates all three), no prose in the suite says what bare `/audit` runs or should run.

The collision is a product of the suite's own convention: `concept:integration-contract`'s invariant says every rules-bearing plugin exposes a read-only compliance verb, and all three plugins conventionally named theirs `audit` — the same deliberate uniformity that gives every plugin a `true-up`. Nothing in the suite can arbitrate the name even in principle: plugins are deliberately ignorant of each other (`concept:plugin`: "a plugin that would need the front door to special-case it has integrated wrong"), and `/ok` never drives work verbs. Machine invocation is always plugin-qualified (`ok-planner:audit`); how a *human's* bare `/audit` resolves is harness behavior the suite neither controls nor documents. The corpus is silent, not conflicted — no artifact takes a position on same-named verbs across plugins.

One concretely broken thing surfaced during verification, tracked as its own sibling issue (`activation-class-rule-unstated`): `ok-plumbline:audit` lacks the slash-only activation guard the other two carry.

## Options

- **Record the shared verb as deliberate convention** — one sentence in `concept:skill` Boundaries (or the integration contract): compliance verbs share the conventional name `audit`; invocation in multi-plugin projects is plugin-qualified. No renames, no fiction about harness behavior, and it makes the uniformity citable instead of accidental-looking.
- **Namespacing rule by corpus assertion** — mandate that slash names are always understood as plugin-qualified. Only correct if that is actually the harness's resolution behavior, which is unverified; the corpus would risk describing a fiction.
- **Rename one or more `audit` verbs** — removes the collision at the source, independent of harness behavior, but costs renames across SKILL.md files, cheatsheets, and docs, breaks user muscle memory, and abandons the uniform-compliance-verb convention that `true-up` already establishes for the lifecycle verb.

The ruling decides: is the three-way `audit` name accepted, load-bearing convention to record, or a defect to rename away?

## Ruling

> Recommended ruling (/verify-issues): accept the shared name as the integration contract's compliance-verb convention and record it — amend `concept:skill` Boundaries with one sentence stating that the contract's uniform verbs (`true-up`, `audit`) intentionally share names across plugins and are plugin-qualified at invocation when more than one is integrated. No renames.
>
> Rationale: the collision is the same uniformity nobody objects to in `true-up` — the contract's whole point is that verbs are uniform across plugins. Renaming would trade a documented convention for three bespoke names, cutting against the contract's grain. The one genuine defect in the neighborhood (the missing activation guard) is carried by `activation-class-rule-unstated` and should be ruled with this issue.

<!-- Owner: this is a recommendation, not your decision. Leave it
as-is to accept — the next /plan-sprint carries it, naming the
generated/recommended batches at sign-off. Edit the text to
redirect, empty the section to discuss live, or delete this note
to adopt the ruling as your own. -->
