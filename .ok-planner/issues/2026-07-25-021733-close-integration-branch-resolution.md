---
issue: close-integration-branch-resolution
kind: discover
category: unspecified
artifacts:
  - story:safe-workspace-teardown
status: verified
opened: 2026-07-25T02:17:33Z
---

# No recipe for resolving the default integration branch at close

## Problem

The merged-branch gate defaults to the repo's default branch unless the user names another, but nothing specifies how the default branch is resolved — in contrast to the release tooling's explicit remote-symref recipe.

## Candidates

- Amend story:safe-workspace-teardown Acceptance to state the canonical default-branch resolution

## Discussion

The question: how is "the repo's default branch" determined when `/close`'s merged-branch gate needs it and the user hasn't named an explicit integration branch?

Where it comes from: filed against story:safe-workspace-teardown. Re-verified against current code: `plugins/ok-workspaces/skills/close/SKILL.md` line 15 states the gate as "The job branch must be fully contained in the integration branch (the repo's default branch unless the user names another)" and gives the two verification commands (`git branch --merged <integration>`, `git cherry <integration> <branch>`) — but nowhere states how `<integration>` is resolved when it is the default branch, i.e., no command or recipe for turning "the repo's default branch" into an actual branch name. By contrast, this repo's own `/release` skill (`.claude/skills/release/SKILL.md` lines 35-38) states the equivalent problem explicitly and gives a concrete recipe: "Determine the default branch from the remote itself — never assume `main`" followed by `default_branch=$(git ls-remote --symref origin HEAD | awk '/^ref:/ {sub("refs/heads/","",$2); print $2}')`, with a following check that the remote actually reported one. The contrast the issue draws is confirmed: one ceremony in the suite's own tooling has a named, remote-authoritative resolution recipe; `/close` has none.

What the corpus says: story:safe-workspace-teardown's Acceptance states the merged-branch gate checks containment in "the integration branch (defaulting to the repository's default branch unless the owner names another)" — matching the code's phrasing almost verbatim — but says nothing about how that default is determined (local `HEAD` symref, remote symref, a hardcoded guess, or an interactive question). decision:teardown-gates-in-git-flags (a bearing artifact for this batch) is specific about the teardown commands' flags (non-forcing worktree removal, lowercase branch delete) but is entirely about what happens after the gate has already been evaluated — it has nothing to say about how the gate's own integration-branch input is resolved. concept:workspace's Invariants govern uniqueness, worktree-as-only-record, and untracked-file carryover — again nothing about branch-name resolution. None of the three bearing artifacts addresses the question; all three are simply silent on it.

What the code does today: `/close` never resolves a name for "the repo's default branch" — the gate's condition as written can't literally execute without some resolution step existing somewhere, so either it is done ad hoc by whichever agent runs `/close` (with no canonical recipe to fall back on, unlike `/release`), or the local `HEAD`/remote-tracking symref is assumed to already be correct without ever being refreshed against the remote (which can silently go stale — exactly the failure mode `/release`'s "never assume `main`" comment is guarding against).

Candidates as filed: amend story:safe-workspace-teardown's Acceptance to state the canonical default-branch resolution. A second, narrower shape: rather than duplicating `/release`'s remote-symref recipe wholesale (which is release-specific tooling, arguably decision-level detail, not a story-level Acceptance detail), the Acceptance could simply require some remote-authoritative resolution ("resolved from the remote, not assumed") without prescribing the exact command, leaving the literal recipe to a decision or to the skill body — keeping the story at story altitude while still closing the current total silence.

What the ruling must decide: whether the default-branch resolution mechanism belongs at story-Acceptance altitude (a canonical recipe, possibly the same one `/release` uses) or should be specified elsewhere (a decision, or just the skill body) with the story only requiring that resolution be remote-authoritative rather than assumed.

## Ruling

<!-- Owner: write your decision here in your own words.
The next /plan-sprint picks it up. Leave empty to discuss
it live in a planning session instead. -->
