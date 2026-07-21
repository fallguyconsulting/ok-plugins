---
name: review-cleanup
description: "Invoked by review skills after a reviewer reports issues. Not user-facing. Dispatches a fixer subagent and re-reviews until clean."
---

# Review Cleanup

**Purpose:** Remove the orchestrator's discretion from the fix cycle. When a reviewer reports issues, this skill takes the list and drives it to zero through subagent dispatch — no triage, no deferral, no "acceptable" bucket.

**Why this exists:** The orchestrating agent has a persistent failure mode: after receiving a reviewer's issue list, it categorizes issues by perceived severity and defers "low priority" ones. This happens despite explicit instructions to fix everything. This skill removes that decision point by handing the issue list directly to a fixer subagent and looping until clean.

## What this skill expects as input

The orchestrator passes review findings that should be auto-fixed mechanically. The fixer treats every input item as something to fix, with no triage. Two consequences:

1. **Findings that need human judgment must NOT be in the input.** Some review skills produce a "Questions" / "judgment-call" / "plausibly intentional" class (e.g., `review-holistic`'s class 5). Those findings need user input on whether to fix, defer, or document — they MUST be relayed to the user separately, not piped here. If you pass them to this skill, the fixer will mechanically apply changes the user didn't authorize.

2. **The orchestrator MUST NOT pre-process the input.** Don't summarize, don't filter, don't reorder, don't omit "minor" items. Pass the raw issue list verbatim. The point of this skill is to remove the orchestrator's discretion — pre-processing reintroduces it.

If the calling review skill emits a multi-class output (e.g., review-holistic with classes 1-4 plus class 5), the calling skill is responsible for splitting before invoking this one.

## When to invoke

Called by the orchestrator after receiving a reviewer's output that contains auto-fixable issues. The orchestrator MUST NOT process, filter, summarize, or triage the reviewer's output before invoking this skill. Pass the raw output.

## Process

1. Dispatch a **fixer subagent** with the reviewer's full output
2. When the fixer reports done, dispatch the **same reviewer prompt** to verify
3. If the reviewer finds new issues, go to step 1
4. Only report clean to the user when the reviewer returns zero issues

## Fixer Subagent Prompt

```
Agent (general-purpose):
  ## Fix Every Issue

  A code reviewer found the following issues. Fix ALL of them. Do not skip any.
  Do not assess priority. Do not defer any issue. Do not mark any issue as
  "acceptable", "cosmetic", "pre-existing", "out of scope", or "not blocking".

  If an issue is in code you didn't write, fix it anyway.
  If an issue predates the current work, fix it anyway.
  If an issue seems minor, fix it anyway.
  If fixing an issue requires reading additional files, read them.
  If fixing an issue requires changing the architecture, change it.

  ### Issues to fix

  [PASTE THE REVIEWER'S FULL OUTPUT HERE — do not summarize or filter]

  ### Rules
  - Read files before editing
  - Run type checks and tests after fixes: the appropriate verification commands
    for whatever packages you modified
  - Do NOT commit
  - If genuinely blocked on an issue (e.g., requires credentials you don't have),
    explain why — but "low priority" is never a valid reason to skip
  - **Missing `@concept:` annotations:** if any input issue includes
    a "consulted concept: <slug> (annotation missing at
    <file:line>)" marker, add the `@concept: <slug>` annotation at
    that file:line as part of fixing the related issue. The
    annotation is a small inline comment marking the load-bearing
    site so future agents don't have to re-do the concept lookup.

  ### Completion check
  Before reporting done, re-read the issue list and confirm:
  - Every numbered issue has a corresponding fix
  - No issues were skipped, deferred, or noted-for-later

  Report: DONE (with a numbered list mapping each issue to what you did)
  | BLOCKED (with specific explanation of what's blocking and which issues)
```

## Re-review Prompt

After the fixer reports done, dispatch the reviewer again with the same scope as the original review. Compare the reviewer's new output:

- **Zero issues:** Report clean to the orchestrator. Done.
- **New issues found:** Loop — dispatch the fixer again with the new issues.
- **Same issues reappearing:** The fixer failed to actually fix them. Re-dispatch with more specific instructions about what went wrong.

## Guard rails

- Maximum 3 fix-review cycles. If issues persist after 3 cycles, report to the user with the remaining issues and ask for guidance.
- The orchestrator MUST NOT add its own "acceptable issues" commentary when reporting results from this skill to the user. If this skill reports clean, say "clean." If it reports remaining issues, list them without editorializing.
