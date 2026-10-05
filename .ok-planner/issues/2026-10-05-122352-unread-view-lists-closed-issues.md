---
issue: unread-view-lists-closed-issues
kind: audit
category: product-intent
artifacts:
  - story:see-new-analysis
status: verified
triage: question
opened: 2026-10-05T12:23:52Z
---

# The unread view now lists closed issues that hold an unread answer, and the corpus does not say whether it should

Triage may answer an owner's comment and then close the issue in the same run, so the answer can land on a record that is already closed. A fixer in sprint certification of `2026-10-05-issue-dashboard.md` (run `converge-2026-10-05T045158`, defect i23) chose to show such answers in the unread view: `issues list --unread`, `GET /api/issues?unread=1`, and the dashboard's unread tab now list closed issues beside open ones. story:see-new-analysis promises "a way to see which issues have new answers or revisions since I last read them, so that I respond to each change without rereading the intake". It says nothing about closed issues. The fixer recorded the choice as question i39 and built the inclusive reading.

## Mechanism

A triage reply or update on an issue is stored unread. A later close, by triage's answered route, `/converge`'s owner list, or a sprint promotion, moves the record to the archive file with that message still unread. decision:closed-issues-leave-the-live-file sets where the record sits, not what the unread view lists.

In `plugins/ok/families/ok-planner/scripts/issues`, `select` builds the unread pool from the live records plus the archived ones. The dashboard's unread route calls the same function. `issues read` and the dashboard's read route mark a closed record's answers read through a lookup that searches the archive too. Before the fix, the answer stood only in the archive: the unread view never named it, `issues read` refused the closed record, and the closed tab showed it as new forever. The drive that confirmed the fix found "answered-then-closed issues listed by 'issues list --unread', GET /api/issues?unread=1, and the page's unread tab".

## State of play

The stuck read state is fixed. An owner can read a closed answer and clear it. What remains open is only whether the unread view is the place that answer shows.

## Options

1. **Closed answers count.** An answer on a closed issue counts as new until the owner reads it, wherever the owner looks for new answers (the code as built). Cost: the unread view mixes closed issues with open ones, so it must mark each closed one as closed.
2. **Open issues only.** The unread view covers open issues, and a closed issue's answer is found on the closed list. Cost: an answer written just before a close is seen only by an owner who browses the closed list, unless that list carries its own unread mark.
3. **Closing settles the answer.** Closing an issue marks its answers read, or a closer may not close an issue with an unread answer. Cost: the owner never sees the last answer as new, or every close waits on the owner.

The ruling decides whether the unread view lists closed issues.

## Ruling

> Recommended ruling (/triage-issues): Option 1. Amend story:see-new-analysis to say that an answer on a closed issue counts as new until the owner reads it, and that the place the owner looks for new answers shows it, marked closed.
>
> Rationale: the answer that lands just before a close is often the one that explains the close: why triage answered or retired the issue, or why a run fixed it. The owner acts on that by vetoing or reopening, and decision:closed-issues-leave-the-live-file names the archive as where the veto list lives. Option 2 sends the owner to browse the closed list, the rereading the story exists to spare. Option 3 hides that answer or holds every close on the owner. Rule this with its sibling revise-writes-no-update-message, which amends the same story. The flip case: if the owner never acts on a closed issue, a closed answer is history rather than news, and option 2 keeps the unread view short.

<!-- Owner: this is a recommendation, not your decision. Leave it
as-is to accept; the next /plan-sprint carries it. Edit the text to
redirect, empty the section to discuss live, or delete this note to
adopt the ruling as your own. -->
