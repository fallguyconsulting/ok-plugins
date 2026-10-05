# Project dashboard: issue tracker — Design Sketch

**Date:** 2026-10-04
**Status:** Sketch (not a sprint; not authorization to build)

## Idea

An owner reviews the issue intake today by opening markdown files one
at a time, reading each narrative, and typing a ruling under
`## Ruling`. Nothing shows the whole intake at once, and nothing lets
the owner say "explain this better" except a hand-written note the next
reader may miss. This sketch proposes a standard dashboard that ships
with ok-planner: a Svelte app over a stdlib-only Python service, run
locally against the project's estate. Its first view is an issue
tracker. The owner reads each issue, then rules on it or comments. A
later `/triage-issues` run reads every owner comment it has not seen,
marks each one seen, and decides what the comment calls for: a reply,
an update to the issue, both, or nothing more. The page marks triage's
replies and updates unread until the owner opens the issue. The
discussion can run many rounds.

The tracker needs structured issues. `/triage-issues` gains two jobs:
it converts each markdown issue into a record in a JSONL file the
dashboard reads, and it works through the owner's unseen messages.

The suite built a dashboard once. Commit `116281f` added the corpus
browser, a Svelte 4 app under `plugins/ok/families/ok-planner/browser/`
and a stdlib-only Python service at `.ok-planner/bin/corpus-view`.
Commit `52425a8` removed it because its data model was citations, and
the audit redesign removed citations. This dashboard keeps that
browser's shape and replaces its data model with the issue file.

## Shape

### The issue file

One file, `.ok-planner/issues.jsonl`, with one line per issue. Each
line is the issue's whole current record. A writer changes an issue by
rewriting its line. Every writer takes an exclusive lock on the file,
reads it, changes the lines it means to change, writes the whole file
to a temp path, renames the temp path over the original, and releases
the lock. The service and `/triage-issues` are the writers.

```json
{
  "id": "practice-violations-are-a8-defects",
  "title": "...",
  "kind": "human",
  "category": "design",
  "artifacts": ["concept:practice", "concept:subject"],
  "route": "question",
  "state": "needs-ruling",
  "problem": "...",
  "options": [{"label": "A", "text": "..."}, {"label": "B", "text": "..."}],
  "recommendation": {"form": "recommended", "text": "..."},
  "ruling": {"text": "...", "at": "2026-10-04T18:30:00Z"},
  "messages": [
    {"n": 1, "by": "owner", "at": "2026-10-04T18:02:00Z", "type": "comment",
     "text": "...", "seen": "2026-10-04T19:40:00Z"},
    {"n": 2, "by": "owner", "at": "2026-10-04T18:30:00Z", "type": "ruling",
     "text": "...", "seen": "2026-10-04T19:40:00Z"},
    {"n": 3, "by": "triage-issues", "at": "2026-10-04T19:40:00Z", "type": "reply",
     "replies_to": [1], "text": "...", "read": null},
    {"n": 4, "by": "triage-issues", "at": "2026-10-04T19:40:00Z", "type": "update",
     "changed": ["options", "recommendation"], "text": "Added option C; recommended C.",
     "read": null}
  ],
  "source": ".ok-planner/history/issues/2026-10-04-052500-practice-violations-are-a8-defects.md",
  "opened": "2026-10-04T05:25:00Z",
  "updated": "2026-10-04T19:40:00Z"
}
```

`messages` is the discussion, oldest first, numbered by `n`. Each
round adds messages; no writer removes one. A message's `type` is one
of:

| `type` | Written by | Effect |
|---|---|---|
| `comment` | the owner | Triage reads it and decides what it calls for: a `reply`, an `update`, both, or nothing beyond the seen mark |
| `ruling` | the owner | Sets `state: ruled` and `ruling` to `{text, at}`. Triage reads it like a comment |
| `reply` | `/triage-issues` | `replies_to` lists the owner messages it answers |
| `update` | `/triage-issues` | `changed` lists the fields the same write rewrote, and `text` says what changed |

The owner has no separate question type. The owner writes a comment,
and triage judges from its text whether it asks something.

**Seen, for triage.** Every owner message starts with `seen: null`.
The `/triage-issues` run that reads it sets `seen` to the time, in the
same write that adds its reply or update. Triage marks a message seen
only after it has acted on it, so a run that dies midway leaves the
message unseen for the next run. An issue with any unseen owner
message is **waiting on triage**. That is a flag beside `state`, not a
value of it: an owner can comment on a ruled issue, and the issue stays
ruled while triage reads the comment.

**Read, for the owner.** Every triage message starts with `read: null`.
When the owner opens an issue, the page calls the service, which sets
`read` to the time on every triage message in that issue. The issue
list shows a count of unread triage messages per issue, and a tab
lists every issue with any.

**The ruling and the recommendation are separate fields.**
`recommendation` is triage's: the generated or recommended ruling, which
triage may rewrite in any `update`. `ruling` is the owner's, set only by
a `ruling` message, and triage never rewrites it. When triage rewrites
`recommendation` on a ruled issue, the issue stays `ruled`. The
`update` message that records the rewrite is unread like any other, so
the owner sees the change the next time they look.

`state` is one of:

- **`needs-ruling`:** triage gave a recommendation, and the owner has
  not ruled.
- **`ruled`:** the owner ruled. `/plan-sprint` reads `ruling.text` as
  the owner's ruling, as it reads unmarked `## Ruling` text today. A
  later ruling message replaces `ruling`.
- **`closed`:** `/plan-sprint` promoted or retired the issue, or
  `/converge`'s owner list fixed or answered it. A `closed_as` field
  names which, with the sprint or run. An owner message on a closed
  issue is refused.

### Markdown stays the filing format

Every writer that files an issue today keeps writing a markdown file
under `.ok-planner/issues/`: `/converge`'s owner list, the audit's
judge, `/discover-design`, `/plan-sprint`, and humans. `/triage-issues`
converts each file it triages into one line of `issues.jsonl`, then
moves the file to `history/issues/`. The JSONL file is the record of
every triaged issue; the markdown directory holds only files no triage
has read.

### `/triage-issues` changes

1. **Convert.** After phase 2, the run writes one line per file it
   triaged and still open (routes `defect`, `corpus`, `question`),
   with `state: needs-ruling` and an empty `messages`, then moves each
   file to `history/issues/`. `answered` and `retired` files close as
   today; the run writes each as a `closed` line, so the dashboard
   shows the veto list.
2. **Respond.** A new phase 3 takes every issue waiting on triage.
   One author task per batch reads the issue, its whole message
   history, and the code and corpus the issue cites. For the issue's
   unseen owner messages, it judges what each calls for: a `reply`
   where the message asks something, an `update` where it shows the
   issue is wrong or thin, both, or nothing beyond the seen mark. It
   writes in one call the replies, the rewritten fields with their
   `update` message, and `seen` on every owner message it acted on.
   Every triage message it writes starts with `read: null`. It never
   rewrites `ruling`.
3. **Scope.** Today the scope is markdown files with no `triage:`
   stamp and no owner text under `## Ruling`. The new scope is every
   markdown file under `issues/` plus every issue waiting on
   triage.
4. **Agents write through the service's code.** Author agents run
   in parallel, so no agent rewrites the file by hand. Each calls one
   verb, such as `.ok-planner/bin/issues respond <id> --file <json>`,
   which takes the lock and does the atomic replace. The service
   imports the same module.

### The service

A stdlib-only Python program at `.ok-planner/bin/dashboard`, in the
same shape as `bin/tasks` and `bin/review`. It serves the built
Svelte app as static files and answers JSON on loopback.

```
GET  /api/issues?state=needs-ruling|ruled|closed&waiting=1&category=
GET  /api/issue/:id                 the whole record
POST /api/issue/:id/rule            {text}
POST /api/issue/:id/comment         {text}
POST /api/issue/:id/read            marks every triage message read
```

The page posts `read` when the owner opens an issue. A GET changes
nothing, so a reload or a prefetch never marks anything read.

Each POST takes the lock, rereads the file, checks the issue's `state`
allows the action, appends the message with `seen: null`, sets `state`
and `updated`, replaces the file, and releases the lock. It refuses any
message on a `closed` issue, and an empty `text`, with a message the
page shows. A message on an issue already waiting on triage is allowed:
it joins the open round.

### The tracker page

```
┌ needs ruling (7) │ unread (4) │ waiting on triage (2) │ ruled (3) │ closed ┐
│ category: [all ▾]                                            │
├──────────────────────────────────────────────────────────────┤
│ ▸ practice-violations-are-a8-defects  design  ruled  ● 2 new │
│   analytical-subagents-ride-opus       tooling needs ruling   │
│   ...                                                        │
├──────────────────────────────────────────────────────────────┤
│ Problem      ...                                             │
│ Options      A ... / B ...                                   │
│ Recommended  > C, because ...                                │
│ Your ruling  B (18:30)                                       │
│ Thread       owner     comment   18:02   seen 19:40          │
│              owner     ruling    18:30   seen 19:40          │
│            ● triage    reply to 1                    new     │
│            ● triage    update: options, recommendation  new  │
│                                                              │
│ [a] accept recommendation  [r] write ruling  [c] comment     │
└──────────────────────────────────────────────────────────────┘
```

The keys `j`/`k` move through the list, so the owner works the queue
without the mouse. "Accept recommendation" posts a ruling whose text
is the recommendation's text. The thread shows each owner message as
seen, with the time, or not seen yet, and each triage message as new
until the owner opens the issue. The unread tab lists every issue with
an unread triage message, and the waiting-on-triage tab every issue
with an unseen owner message, whatever its `state`.

### What comes back from `52425a8^`

| Old file | Fate |
|---|---|
| `browser/package.json`, `vite.config.js`, `index.html`, `src/main.js`, `src/app.css` | Restore. |
| `src/lib/route.js` | Restore as is. |
| `src/lib/api.js` | Restore the `get` helper, add a `post` helper, replace the endpoints. |
| `src/App.svelte` | Restore the header, nav, and section switch. Keep the version-pin banner. Drop the "Citations resolved by" line. |
| `src/views/ArtifactList.svelte` | Restore as the base of the issue list. |
| `Overview`, `ArtifactDetail`, `SourceList`, `SourceView` views | Leave out. |
| `.ok-planner/bin/corpus-view` | Restore the server loop, static serving, root resolution, and estate-version check. Drop every citation resolver. |
| The release step that built the bundle, and converge's placement of it | Restore. `52425a8` removed both, along with the line "The family no longer needs Node at all, at runtime or build time". |

## Open questions

- **Returning to a JSONL intake.** The suite kept issues in
  `.ok-planner/issues.jsonl`, an append-only event log, until about
  v9–v11 (late July 2026), then moved to one markdown file per issue.
  `/ok` still carries a `legacy-intake` offer that converts an old log
  into files and deletes it. This sketch brings a JSONL file back
  beside the markdown files, as one mutable record per issue rather
  than an event log. I did not find the reason for the move to files. A sprint
  should read it first, and must retire or rename the `legacy-intake`
  offer, which would otherwise delete the new file.
- **Who writes `issues.jsonl`.** I assumed only `/triage-issues` converts
  markdown, so every other writer keeps filing files. The other path
  has every writer add its line through `bin/issues` and drops the
  markdown intake.
- **Silence as acceptance.** Today a generated or recommended ruling
  rides the next `/plan-sprint` unless the owner overrides it. I
  assumed silence still accepts, and the dashboard's "accept" only makes
  acceptance explicit. A sprint may instead require a `ruling` message.
- **Converting answered and retired files.** I assumed `issues.jsonl` records
  them so the veto list shows on the page. Leaving them out keeps the
  file to live issues only. Closed lines also grow without bound; a
  sprint may move them to `history/issues.jsonl`.
- **Svelte 4 or 5.** I assumed a straight restore of Svelte 4.
- **Which artifacts this changes.** `concept:issue`, the issue format in
  `.claude/skills/_shared/artifact-definitions.md`, the planner
  cheatsheet's Defect issues section, `.ok-planner/CLAUDE.md`, and the
  readers in `/plan-sprint`, `/converge`, and `/audit` all describe the
  markdown intake. A sprint carries a delta for each.

## Risks / unknowns

- **Two homes for one issue.** Between a writer filing a file and the
  next triage, the issue lives only in markdown and the dashboard does
  not show it. The page should show the count of untriaged files so
  the owner knows to run `/triage-issues`.
- **Lost writes.** The service and a triage run both rewrite the whole
  file. A writer that skips the lock, or writes from a copy it read
  before taking the lock, erases the other writer's change. Every
  writer goes through the one `bin/issues` module for this reason.
- **Git history per issue.** A rewrite changes one line per issue, so
  `git diff` still shows which issue changed. A long thread makes that
  one line long, and the diff shows the whole line.
- **The build comes back.** Shipping the dashboard restores the
  per-release frontend build and the placement converge does. The
  backout deleted that machinery once.
- **Schema drift.** The service, `/triage-issues`, `/plan-sprint`, and
  `/converge` all read the records. One module in `bin/issues` that
  validates every line on read, and names the line it refuses, keeps
  them in agreement.

## What this is not

- Not an issue filer. The page creates no issue; writers file markdown.
- Not a planner. The page does not promote or retire; `/plan-sprint`
  still closes judgment issues.
- Not a corpus browser. Concepts, stories, decisions, audits, and task
  runs are later views, out of this sketch.
