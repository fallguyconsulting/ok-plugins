---
issue: revise-writes-no-update-message
kind: audit
category: product-intent
artifacts:
  - story:see-new-analysis
  - decision:triage-answers-owner-messages
status: verified
triage: question
opened: 2026-10-05T12:23:52Z
---

# An agent can rewrite an issue the owner has already read, or ruled, and the owner is never told

The intake marks a change to an issue as new for the owner only when the change arrives as an update message. One verb of the intake module, `issues respond`, writes that message. Another, `issues revise`, rewrites an issue's fields and writes none. `/converge` uses `revise` to turn a stuck defect issue into a judgment issue, and rewrites its problem. Where the owner had ruled that issue, the ruling now stands over a problem the owner never saw, and nothing flags the change. story:see-new-analysis promises "a way to see which issues have new answers or revisions since I last read them, so that I respond to each change without rereading the intake". decision:triage-answers-owner-messages says a revision of a ruled issue "reaches the owner as new analysis", but it speaks of triage alone. Neither says whether a revision by another ceremony counts.

## Mechanism

In `plugins/ok/families/ok-planner/scripts/issues`, `revise` applies the fields and stamps `updated`. `respond` applies fields too, and also appends a triage `update` message with `read` unset. The unread count counts only those unset messages. So a `respond` raises the count, and a `revise` never does.

Triage routes its re-check of an already routed issue through `respond`, so the decision holds for triage. Three callers use `revise`:

- `/converge`'s owner list, which turns a stuck or left-alone defect issue into a judgment issue: it sets `category`, clears `route` and `recommendation`, and appends a `## Stuck in <run>` or `## Left alone in <run>` section to the problem.
- Triage's first routing of a new issue, and its reuse route.
- Triage's defect route.

After the owner list's revise, an unruled issue shows under "waiting on triage", then under "needs ruling" once triage routes it again. A ruled issue stays "ruled": the module never lets an agent change the owner's ruling, and its state reads the ruling first. The drive in run `converge-2026-10-05T045158` (drive failures i7 and i8, question i25) saw this on the command line and on the dashboard: after `issues read`, a `revise` of the problem "exited 0 ... and 'issues list --unread' did not list it", and "the page's unread count stayed 0; the same held for ruled see-new-analysis-three".

## State of play

Triage's revisions of a routed issue reach the owner. Every other revision does not. For an unruled issue the triage queue still surfaces it. For a ruled issue nothing does.

## Options

1. **Widen.** Every agent revision of an issue the owner has been shown reaches the owner as new analysis, whoever writes it. An issue counts as shown once it is routed or ruled. A first routing stays silent, since "needs ruling" already surfaces it. Cost: `revise` writes an update message on those issues, and the message needs an author value for a writer other than triage.
2. **Narrow.** Only triage's revisions reach the owner as new analysis; an issue another ceremony re-files reaches the owner through the triage queue. Cost: a ruled issue whose problem `/converge` rewrites stays "ruled" with no signal, and the owner learns of it only by rereading.
3. **Requeue.** Keep `revise` silent, but have an agent revision of a ruled issue drop it back to "needs ruling". Cost: the state rule changes so that a ruling over a cleared route reads as waiting, which lets an agent's act unsettle the owner's ruling.

The ruling decides whether a revision by a ceremony other than triage reaches the owner as new analysis.

## Ruling

> Recommended ruling (/triage-issues): Option 1. Amend story:see-new-analysis to say that any revision of an issue already routed or ruled reaches the owner as new analysis, whichever ceremony writes it. A first routing stays silent. Then make the intake record every such revision as an update message the owner has not read.
>
> Rationale: the story names no writer, and its purpose, "respond to each change without rereading the intake", fails exactly where option 2 leaves the gap: a ruling standing over a problem the owner never saw. decision:triage-answers-owner-messages already holds that a ruled issue stays ruled and its revision reaches the owner as new analysis; option 1 extends that rule to every writer and leaves the decision true as written. Option 3 lets an agent unsettle the owner's ruling, which the intake forbids everywhere else. Scoping to routed or ruled issues keeps a first routing from inflating the unread count. Rule this with its sibling unread-view-lists-closed-issues, which amends the same story. The flip case: if the owner treats a re-filed issue as a fresh question, to be ruled again from scratch rather than read as a change, option 2 is enough for unruled issues, and only the ruled case needs a signal.

<!-- Owner: this is a recommendation, not your decision. Leave it
as-is to accept; the next /plan-sprint carries it. Edit the text to
redirect, empty the section to discuss live, or delete this note to
adopt the ruling as your own. -->
