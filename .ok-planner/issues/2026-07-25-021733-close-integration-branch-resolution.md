---
issue: close-integration-branch-resolution
kind: discover
category: unspecified
artifacts:
  - story:safe-workspace-teardown
status: verified
opened: 2026-07-25T02:17:33Z
---

# The close gate checks "the repo's default branch" without saying how to find it

ok-workspaces' `/close` refuses to tear down a worktree until its branch is merged into "the integration branch (the repo's default branch unless the user names another)" — but nothing states how "the repo's default branch" is resolved. That resolution is a known trap: the local `HEAD` guess and the remote's actual default can disagree (this very repo's default is `develop`, not `main`), and the suite's own release skill learned the lesson explicitly — it carries the canonical recipe (`git ls-remote --symref origin HEAD`) with a warning to never assume. The close gate is the suite's most safety-critical check — a worktree is the only record of its uncommitted work — and it currently leaves its reference point to whatever the executing agent assumes.

All three bearing artifacts (`story:safe-workspace-teardown`, `decision:teardown-gates-in-git-flags`, `concept:workspace`) are silent on branch resolution. The question is one of altitude: does the resolution recipe belong in the story's acceptance, or does the story state only the property ("resolved from the remote, never assumed") with the literal command living in the skill body?

## Options

- **Property in the story, recipe in the skill** — amend `story:safe-workspace-teardown`'s acceptance with "the integration branch is resolved from the remote, never assumed," and add the release skill's `ls-remote` recipe to `close/SKILL.md`. Story stays at story altitude; the skill gets the deterministic command.
- **Recipe in the story's acceptance** — concrete and unambiguous, but bakes one git incantation into a durable artifact that shouldn't care how the property is achieved.

The ruling decides: where the resolution rule lives, and at what altitude.

## Ruling

> Recommended ruling (/verify-issues): property in the story, recipe in the skill — the sprint amends the story's acceptance with the resolved-from-the-remote-never-assumed property and adds the `git ls-remote --symref origin HEAD` recipe to the close skill, mirroring the release skill's existing pattern.
>
> Rationale: stories record durable expectations, not git commands — but the expectation that a destructive gate checks against the *remote's* truth rather than a local guess is durable, and the suite already standardized the recipe once; the close skill should use the same one rather than a second variant.

<!-- Owner: this is a recommendation, not your decision. Leave it
as-is to accept — the next /plan-sprint carries it, naming the
generated/recommended batches at sign-off. Edit the text to
redirect, empty the section to discuss live, or delete this note
to adopt the ruling as your own. -->
