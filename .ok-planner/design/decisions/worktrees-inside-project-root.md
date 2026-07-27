---
decision: worktrees-inside-project-root
---

# Worktrees default to inside the project root, gitignored by the plugin's own scope

## Choice

Job worktrees are created by default inside the plugin's dot-directory under the project root, and because a checkout inside the repo must never become content of the repo, the lifecycle verb writes a gitignore scoped to the plugin's own dot-directory covering wherever the profile puts them. A profile pointing worktrees elsewhere is a declaration, not drift, and the project's root gitignore is never touched.

## Rationale

A job's checkout should never escape the project it belongs to — keeping worktrees inside the root keeps ownership, cleanup, and discovery local — while the ownership rule forbids editing the human-owned root gitignore, so the plugin carries its own ignore scope instead.

## Alternatives

- Sibling directories outside the repo — checkouts escape the project, ownership and cleanup scatter across the filesystem.
- Ignoring worktrees via the project's root gitignore — requires the plugin to edit a human-owned file, breaching the ownership rule.
