---
name: plan-sprint
description: "ONLY activated by explicit /plan-sprint slash command. Never auto-triggered by conversation content. ok-planner's planning session. It pulls in the ruled issues and the defect issues the owner picks, reconciles work done out of band since the last close, drafts final-form corpus deltas and flat work items with the owner, and resolves the open issues that bear on the work. A code planner then reads the code each work item touches and writes the sprint's implementation notes: the code changes, every existing behavior they alter with its users, and improvements to the code the sprint changes anyway, judged against the project's accept list. The owner is asked only what changes a promise, breaks a user across a declared release boundary with no determined fix, or splits on a ruling's reading. Every other choice, the improvements the sprint takes included, is recorded as a call and listed at approval for veto. A second review checks the notes against the sprint and the code. The session ends at one approved, self-sufficient sprint whose closing step is sprint certification (/converge sprint); execution is a separate act."
---

# Sprint Planning

`/plan-sprint` is ok-planner's planning session: an interactive session with the project owner that produces a **sprint**. A sprint is a change-order against the project's durable corpora. It holds final-form corpus deltas, the work items that realize them, the implementation notes that say what execution builds, and a fixed completion contract.

The session runs planning, the sign-off review, code planning, the owner's judgments, and a review of the implementation notes. The owner approves once, at the end. The implementation notes say what execution builds, which existing behaviors that changes and how each is ruled, and which improvements the sprint makes in the code it touches. A sprint planned this way breaks nothing its rulings do not allow, and leaves the code it touches better against the project's accept list.

**The artifact is a sprint, not a theme.** A sprint holds potentially disparate changes — a concept clarified, a new story, an unrelated decision retired — with no required unifying focus. Get the right items into the sprint, each stated well enough to be picked up cold. Leave staging and ordering to execution: the work items stay a flat, unordered list, and no narrative holds unrelated items together.

The machinery lives beside this body and in `.claude/skills/_sprint/shared.md`. `core.md` holds the release boundaries format, the implementation notes form, and the four subagent prompts. `sprint-document.md` holds the sprint template. `skills/_shared/artifact-definitions.md` defines the corpus artifacts, the delta form, and the issue file format. A `{{TOKEN}}` names the block of that name in one of these files, and resolves only where the token stands alone on its line.

## Estate

The project root is the nearest ancestor of the working directory (itself included) holding the estate directory, never derived from `.git`. The estate is a filesystem check there:

| estate | what this session does with it |
|---|---|
| `.ok-planner/` | Required. It owns the sprint, the design corpus, the coding standards (the subject and practice collections at `.ok-planner/subjects/` and `.ok-planner/practices/`), and the issue intake. Without it, say so and stop. Where either collection is missing, say in one line that `/ok` materializes it, and skip the subject and practice steps below. |

`.ok-planner/design/` must exist before a sprint can carry corpus deltas. Where it does not, say so and point at `/discover-design`; the session may still go on to work items alone.

## Vocabulary

Read `skills/_shared/artifact-definitions.md` before authoring anything. Every delta drafted here must already comply with the artifact rules; the sign-off review checks exactly that. `{{CORPUS-DELTA-FORM}}` is the authority on a delta's parts.

Read `.ok-planner/practice-definitions.md` before authoring a subject or a practice. It defines what a **subject** and a **practice** are, what each body carries, and how gaps, collisions, and violations differ.

Keep two things apart: the **intake** (`.ok-planner/issues/`, one markdown file per issue) holds questions; the **sprint** holds what the session commits to. Issues move from the first to the second by promotion, one-way. The defect-issue rules are in the "Defect issues" section of `.claude/rules/ok-planner-cheatsheet.md`.

## 1. Layout

`mkdir -p .ok-planner/sprints .ok-planner/issues .ok-planner/history/sprints .ok-planner/history/issues .ok-planner/history/sketches`. Estate convergence is the front door's administration (`/ok`).

Where a legacy `.ok-planner/issues.jsonl` is present, say so and stop: a sprint promotes from a file-per-issue intake only. Tell the owner to run `/ok`, whose `legacy-intake` cleanup offer converts the log into issue files, then to run `/plan-sprint` again.

## 2. Frame

Read the intake. Every file under `.ok-planner/issues/` with `status: open` or `status: verified` is an open issue; `promoted` and `retired` files are closed, whatever directory they sit in. Set the `category: defect` issues apart, then split the rest by the `## Ruling` section: **ruled** (non-empty Ruling text) and **unruled**. Hold the unruled ones until Resolve.

**Pull in the ruled issues first.** A ruling is the owner's decision, already made. For each ruled issue, carry the ruling's substance into the draft in final form — corpus delta, work item, or both — exactly as if the owner had just decided it live. Discuss a ruled issue with the owner only when the ruling cannot be understood; then ask about that one ruling, in prose, and transcribe the clarification. A ruling that amounts to "drop it" is a retirement: record the reason under Ruling, set `status: retired`, and move the file to `.ok-planner/history/issues/` now.

**Generated and recommended rulings ride in the same sweep.** A `> Generated ruling (/triage-issues): …` was written because the rules determine the resolution. A `> Recommended ruling (…): …` is the triage's judgment call the owner accepted by silence; older files attribute it to `/verify-issues` or `/recommend-rulings`. Carry both like any ruling, and name each batch once, at Approval. Re-discuss one only when the owner asks.

**Offer the defect issues.** List every open or verified `category: defect` issue, one line each with its site and harm. The owner picks which join the sprint; pull each picked issue in as a ruled issue, its generated ruling becoming a work item. The rest stay in the intake for the next `/converge`. Walk none of them at Resolve.

Then establish the session kind from the owner's opening ask; where it is unclear, ask in one prose question:

- **Intake-drain sprint** — the owner's purpose is working the intake: all of it, or a batch they name. Run the issue walk (under Resolve) over that scope now, then the dialogue (thin — the resolutions largely are the intake) and the draft.
- **Feature-work sprint** — the default. The owner brings work. The intake is not the agenda beyond the ruled sweep: go to the dialogue and the draft, then consult the unruled issues at Resolve against the drafted work.

Tell the owner the counts either way ("3 ruled issues pulled into this sprint; 2 of 4 defect issues picked; 7 unruled open — I'll check which bear on this work once we've drafted it"). The count is information, not a gate; the owner may widen scope to the whole intake.

## 3. Reconcile

Work sometimes lands outside any sprint — a hotfix, an experiment that stuck, a redesign in a session that never ran `/plan-sprint`. The corpus catches up with such work here, before anything is drafted on top of it. This session is the one place the corpus moves: sprint certification cannot do it, because its fixers hold the corpus fixed and would bend new code back toward stale docs.

1. **Resolve the baseline.** Every sprint whose archive-and-commit step ran carries `closed: <sha>` in its frontmatter. The baseline is the `closed:` stamp of the newest file under `.ok-planner/history/sprints/` that has one. Where none has one, say so and ask the owner, once, in prose, whether to name a baseline ref or skip the walk.
2. **Compute the window.** `git log --oneline <closed>..HEAD` plus the uncommitted tree. An empty window passes the phase silently.
3. **Filter for bearing changes.** Most of the window is ambient change touching no corpus commitment. Dispatch `{{OUT-OF-BAND-REVIEWER-PROMPT}}` from `core.md`, and walk only what it returns as bearing.
4. **Walk the bearing set with the owner, one change at a time**, before the dialogue builds on it. Per change the owner picks one of three outcomes, and the pick lands in this sprint:
   - **Corpus catches up** — the out-of-band work is intended reality; draft the deltas that bring the affected artifacts into agreement with it. The approved delta is the work's missing authorization, granted retroactively.
   - **Code catches up** — the corpus's commitment stands; add a work item restoring it.
   - **Record and defer** — the owner wants to think; file an issue per `{{ISSUE-FILE-FORMAT}}` (kind `human`, the divergence as the Problem). The sprint then leaves the artifacts that divergence bears on untouched.

An empty window or an all-ambient review passes in one line ("no out-of-band work since <sprint>").

## 4. Dialogue

Discuss what this sprint takes on. The owner brings goals; you bring the corpus (read `.ok-planner/design/` freely — it is the source of truth). A sketch under `.ok-planner/sketches/` the owner names as the work's source is an input to the dialogue, read in full; note which sketches the draft takes up, since Terminal archives them.

Ask questions in prose. Surface every tradeoff explicitly, and put each one to the owner to resolve. When work implies a story- or decision-intent change, put the three options to the owner — preserve the intent, shift the intent, remove the artifact — and the owner picks.

Draft a story as a need, never a design: the capability reads `I want a way to <do something>`, and the benefit is an outcome a reader can settle by observing it. Concreteness is about the outcome, never about the surface. A draft that names a page, a screen, a control, an interaction, or what a screen contains is an interface specification; it fails the three tests in `{{STORY-DEFINITION}}` — need, one need, invariance — and the interface detail belongs in the work item that builds it. A draft that bundles several capabilities is factored, never trimmed: one story per need, each with the benefit it serves, and a decision for each choice the draft prescribed that has an alternative. Reaching for correct, clear, or helpful means the need is not yet named: say what the user can now do instead, per `{{STORY-DEFINITION}}`. Where a promise rests on a human discipline's judgment, `{{DECIDABILITY-BOUNDARY}}` makes it a referral in the story's audit.

Draft a concept only when it passes the two tests in `{{CONCEPT-DEFINITION}}`: existence — the project narrows the noun, and the body states the narrowing — and invariance — every sentence under What it is and Boundaries holds for every product that meets the same stories, whatever decisions it makes. A noun that names a part of the product (a page, a screen, a module) is not a concept; ask what kind of thing the part embodies and draft that, or draft nothing.

## 5. Draft

Write the sprint to `.ok-planner/sprints/YYYY-MM-DD-<slug>.md` from `{{SPRINT-DOCUMENT-TEMPLATE}}` in `sprint-document.md`. Write the `## Implementation notes` section's body as the one word `pending`; code planning fills it. Where `.ok-planner/config.json` sets `sprint_execution` to `inline`, write the sprint's How to execute this sprint and Completion contract sections from `{{INLINE-EXECUTION-SECTIONS}}` in `sprint-document.md` instead; the session never proposes or sets the flag. Where a work item changes files outside the project root at a path the owner named, list each such folder under `## Paths outside the project root`.

The corpus deltas are the substantive body, each authored per `{{CORPUS-DELTA-FORM}}`: a complete final-form body, resolved in this session's dialogue. Edit the artifact surgically with the owner and carry the whole result. A retirement carries only its heading. Where bodies run long, put them in the sidecar folder beside the sprint (`<sprint-name>-deltas/<kind>s/<slug>.md`) and point each heading there. Applying a delta is updating the corpus.

**The sprint is self-sufficient.** Once written, it is the source of truth for execution. An executing agent reads the sprint, never an issue file, to learn what a promoted issue meant: a resolution whose substance is not in the deltas or work items is not in the sprint.

**The predictive classification test.** Where `.ok-planner/surface/surface.md` exists, check each piece of new user-facing surface the work introduces — a new command, route, exported module, env var — against the surface intent: does it already classify the surface, by rule or exception? A claimed surface passes silently. An unclaimed one is one prose question to the owner — public or internal, and under what rule — and on the answer add a work item that edits the intent. The sprint's execution edits the intent, and the audit's next run reads it. Stories carry the public-by-construction prior: a story's capability is something a user reaches, so its surface is public unless the owner says otherwise, and only genuine ambiguity reaches the owner.

**Subjects and practices.** Subjects and practices are corpus deltas of the same shape as any other — new, amend, or retire, each a complete final-form body, with the sidecar available. Surface two authoring rules to the owner while drafting:

- **A subject is admissible only if its members can be enumerated.** Where the owner cannot say how a reader would list them, the artifact is not ready: say so and work out the enumeration together.
- **A departure is a competing practice, never an exemption.** Draft an exception the owner describes as a second practice over the same subject, with its own condition and its own benefit. An exception that cannot be written affirmatively is not understood yet.

The cheatsheet's universal conventions are not corpus artifacts and are never drafted as deltas.

A subject drafted without practices covering its whole population ships a gap. Name that to the owner while drafting, so the covering practices land in the same sprint or the gap is a deliberate choice. The owner decides which policies the codebase follows; draft only the subjects and practices the owner states. A delta that adds, amends, or retires a subject or practice makes its catalog TOC (`.ok-planner/subjects.md` or `.ok-planner/practices.md`) stale, and applying the delta includes regenerating it with `python3 .ok-planner/bin/catalog-toc`. A TOC is generated: a hand edit is discarded by the next run.

## 6. Resolve

This session is the only place a judgment issue closes: **promoted** into this sprint, or **retired** at the owner's word. The ruled ones were pulled in at Frame; this phase is the **unruled** remainder, defect issues excluded.

Building over an open issue decides it silently. An issue whose answer the drafted work would encode by default goes to the owner first. An issue the work neither touches nor presumes stays in the intake.

The walk is scoped:

- **Intake-drain sprint** — every unruled open issue (or the named batch). Go straight to the walk.
- **Feature-work sprint** — dispatch `{{RELEVANCE-PASS-PROMPT}}` from `core.md` over the draft and the unruled open issues, then walk only the issues it returns as bearing. Report the split to the owner in one line (`4 of 7 open issues bear on this work; walking those now`). The owner may pull an independent one into scope.

**Coverage questions.** Coverage runs file two kinds of open question: **gaps** (a member of a subject no practice claims) and **collisions** (a member two equally specific practices claim under conflicting conditions). Both are ordinary intake issues, walked like any other. A **violation** is a defect: it reaches the intake as a `category: defect` issue, offered at Frame like any other.

### The issue walk

Before presenting each issue, surface the corpus that bears on it:

```bash
OK_PLANNER_PROJECT_ROOT="$(pwd)" \
  python3 .ok-planner/scripts/surface-corpus .ok-planner/issues/<file>.md
```

The script prints, one per line, the concept, story, and decision files cited in the issue's frontmatter `artifacts:` list or matching distinctive rare tokens from its slug and body. Read each surfaced artifact in full: its Boundaries, a Choice, or a story's statement may already resolve the question, retire the issue, or reshape the framing. Where the script prints nothing, the issue is either about pure code with no corpus commitment or about a concept the file failed to name: flag it to the owner.

Walk the in-scope issues with the owner **one at a time**: present the issue's title, Problem, and Candidates — leaning on its triage-written narrative — plus a one-sentence note on what the surfaced corpus says (`concept:X draws its boundary so the answer is Y — likely a retire`). The owner picks one of two outcomes.

**Promote** — the owner decides the answer (a candidate, or a shape of their own). Transcribe the decision verbatim into the file's `## Ruling`, and carry the substance into the sprint now, in final form: corpus delta, work item, or both. On a feature-work sprint that means amending the draft, including where the resolution collides with a delta already drafted; on an intake-drain sprint these resolutions are the material the draft is built from. The sprint carries the whole resolution; the issue file is a receipt.

**Retire** — the owner drops the question ("won't fix", "not real anymore", "already answered"). Record it at once: the reason under `## Ruling`, `status: retired`, and move the file to `.ok-planner/history/issues/`.

Every file mutation follows `{{ISSUE-FILE-FORMAT}}`. Retirements happen during the walk; `promoted` stamps go in at Terminal, after approval. A promotion is true only once its sprint exists in approved final form, so a session that dies before approval leaves the promoted-in-spirit issues open with their rulings preserved — the correct state. Leave every issue outside the walk's scope unstamped and unmentioned in the sprint. A question the owner postpones is filed per `{{ISSUE-FILE-FORMAT}}` with `kind: "sprint"`. A problem with an earlier sprint's decision is a new issue in a new file.

An empty intake, or a relevance pass returning nothing bearing, passes silently.

## 7. Sign-off

Dispatch the compliance reviewer from `skills/_shared/design-doc-compliance-reviewer.md` in draft mode, scoped to the sprint's corpus deltas plus any live artifacts they amend. Fix mechanical findings in the draft directly. Walk with the owner only a judgment finding that meets `{{OWNER-QUESTION-TEST}}`; settle every other one as a call the rules decide, and list it at Approval. Re-dispatch until clean.

This review is the only point at which a delta's claims are checked for truth; every later gate measures the repository against the approved sprint. A grounding finding stands even when the artifact is otherwise well-formed: a claim the repository contradicts is the finding, and the fix is to correct it. Rationale and Alternatives reasoning is the owner's a priori record — verified where it asserts repository facts, accepted otherwise, never flagged for being unverifiable.

Tell the owner in one line that the outcomes are reviewed and code planning starts.

## 8. Release boundaries

Code planning reads the project's boundaries from `.ok-planner/release-boundaries.md`, in the format `{{RELEASE-BOUNDARIES-FILE}}` in `core.md` gives. `{{RELEASE-BOUNDARIES}}` says what a boundary is.

Where the file does not exist, draft it before code planning. Read the design corpus's decisions, and the surface intent at `.ok-planner/surface/surface.md` where it exists, and propose the boundaries they imply: who uses the project from outside it, and when each of those users updates. Put the draft to the owner in prose and write the file from the answer.

## 9. Code planning

1. Record the commit: `git rev-parse HEAD`. Where `git status --porcelain` lists a path outside `.ok-planner/`, name it to the owner in one line; the planner reads the working tree as it stands.
2. Group the work items. A sprint of ten or fewer work items is one group. Split a larger sprint into groups of up to ten, keeping work items that name the same corpus artifacts in one group; the notes review checks conflicts across groups.
3. Dispatch one code planner per group, all in one message, from `{{CODE-PLANNER-PROMPT}}` in `core.md`, with `[SPRINT PATH]`, `[WORK ITEMS]`, and `[COMMIT]` filled, and `[NEXT B]` and `[NEXT I]` set so the groups' ids do not collide.
4. Write the returned notes into the sprint's `## Implementation notes` section in the form `{{IMPLEMENTATION-NOTES-FORM}}` gives, one subsection per work item in the sprint's order.

## 10. The owner's judgments

Put every question code planning raised through `{{OWNER-QUESTION-TEST}}`. Walk with the owner, one per turn, only the questions it sends there. Settle every other one as a call: write it under the work item's **Calls** with what decides it, and move on. Where nothing needs the owner, say so in one line and go on.

- **A kickback** is a work item the code shows cannot be built as drafted. Where the corpus, the rules, or an owner ruling decides the amendment, make it as a call. Otherwise present the code fact and the part of the draft it contradicts. The owner amends the work item or delta, or keeps it with a stated reading; write a kept reading on the work item's `Reading:` line. An amended delta goes back through the compliance review. Re-run code planning for every work item an amendment touched, numbering new ids after the highest the sprint holds, replace those items' notes, and put the questions they raise through the test.
- **A behavior change marked `owner (<boundary>)`** gets a ruling from `{{BEHAVIOR-RULINGS}}` from the owner. Transcribe it into its `Ruling` line. Changes that share a boundary and a ruling go to the owner as one question.
- **The proposed improvements** are calls: the sprint takes each one. List them at Approval, where the owner may drop any. Each dropped improvement that names an accept-list harm is a known defect: file it in the intake as a `category: defect` issue, per the "Defect issues" section of `.claude/rules/ok-planner-cheatsheet.md`, so the next `/converge` fixes it. A dropped structure improvement is dropped. A taken improvement's behavior changes get rulings like any other.

Behavior changes whose users all ship in the same release carry the planner's `rewrite` ruling, and those whose ruling is a `(call)` carry the planner's; neither is walked. Name their counts in one line.

## 11. The implementation notes review

Dispatch `{{IMPLEMENTATION-NOTES-REVIEWER-PROMPT}}` from `core.md` once, with `[SPRINT PATH]` and `[COMMIT]` filled, `[SCOPE]` set to `every work item`, and `[SETTLED]` listing every kept reading, owner ruling, and call by work item and id, or `none`. It looks for unexpected behavior changes and compatibility breaks, nothing else. Fix each mechanical finding in the notes as a call. Walk each judgment finding with the owner as the judgments above are walked. Add the review's build notes to the work items they name, under **Calls**, for the builders. The review runs again only when the owner changes a delta or a work item at Approval.

## 12. Approval

Name the generated and recommended ruling batches Frame pulled in, one line each ("3 pulled rulings are generated: <slugs>; 5 are accepted recommendations: <slugs> — say the word to drop any"). List the calls the session and the planners made, one line each with what decides it, and the improvements the sprint takes, for the owner's veto. Present the whole sprint for approval. It is not final until the owner approves. An owner's change at approval re-runs the steps it touches: a delta goes through the compliance review, and a work item goes through code planning and the notes review.

## 13. Terminal

1. **Record the promotions.** For every issue this sprint resolved — the ruled and defect issues pulled in at Frame and the issues promoted during the walk — stamp the file: `status: promoted`, `sprint: <this sprint's filename>`. The file stays in `.ok-planner/issues/` until the sprint's archive-and-commit step moves it to `.ok-planner/history/issues/`. Every promoted slug also appears in the sprint's `## Intent` list.
2. **Archive the sketches the sprint took up.** For every sketch under `.ok-planner/sketches/` the owner brought into the dialogue as the work's source, move the file to `.ok-planner/history/sketches/`, per file, and name each moved sketch in one line. A sketch the sprint takes up only in part stays where it is unless the owner says to move it; a sketch nobody brought in is left alone.
3. **Hand over the goal line.** Hand the owner the line that starts execution under the native `goal` mechanism, with this sprint's filename stamped in, whole:

       /goal .ok-planner/sprints/<sprint-name>.md — see the goal
       resolution criteria in that file's completion contract; read the
       file from disk and apply them

   The line is for the owner; the sprint document does not carry it.

Then stop. The approved sprint is this skill's terminal artifact, and its own execution boilerplate describes how execution works. The session writes only the sprint, its delta sidecar, `.ok-planner/release-boundaries.md`, and the issue files and sketches it stamps, files, or moves. Implementers apply the corpus deltas and write the code.
