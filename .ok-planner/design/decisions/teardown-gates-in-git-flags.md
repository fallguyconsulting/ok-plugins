---
decision: teardown-gates-in-git-flags
---

# Teardown commands are chosen so they only succeed if the gates were honest

## Choice

Workspace close verifies its two gates (clean tree, merged branch) and then tears down using only the non-forcing forms: worktree removal without force, and lowercase branch deletion that refuses unmerged work. Forcing flags and forced deletion are never added; a force "need" means a gate lied, and the response is stop and re-check.

## Rationale

Encoding the gates into the commands themselves converts a prose safety rule into a mechanical one — the teardown physically cannot complete against a dirty tree or unmerged branch, because a worktree is the only record of its uncommitted work. It is the methodology's checks-over-discipline instinct applied inside a prompt-driven verb.

## Alternatives

- Forced removal after prompt-level gate checks — one wrong gate evaluation destroys work irrecoverably.
- Gates alone with no command-level backstop — trusts per-session discipline exactly where the cost of error is total.

## Proof

The non-forcing commands themselves are the check: branch deletion exits nonzero on an unmerged branch and worktree removal exits nonzero on a dirty tree, so a teardown attempted past a lying gate goes red instead of completing.
