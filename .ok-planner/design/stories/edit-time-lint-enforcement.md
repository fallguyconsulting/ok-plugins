---
story: edit-time-lint-enforcement
---

# Violations block the agent at edit time

## Story

As a project owner who has adopted the lint methodology, I want every agent edit checked against the comment and citation rules the moment it lands, blocking the agent in the same turn on violations in the lines it changed, so that residue never accumulates and pre-existing debt never blocks unrelated work.

## Acceptance

An agent edits a file in an integrated project → violations within the changed line ranges block with the violation message in the same turn, so the agent fixes before proceeding; edits clean in their changed ranges pass even when the rest of the file carries older violations; untracked files are checked whole; and every hook failure path degrades to silence — the check never breaks a session. The project's own pinned lint binary, not the installed plugin's, performs the check.

## Falsifier

A violating edit lands silently; pre-existing violations elsewhere in a file block an unrelated edit; the check runs at a version other than the project's pinned one; or a hook malfunction interrupts the session.

## Proof

Demo — in an integrated project, an edit introducing a disallowed comment is blocked in-turn while a clean edit to a file with old violations passes, and disabling the vendored binary shows the session degrade to silence rather than error.
