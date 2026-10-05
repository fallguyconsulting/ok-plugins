---
issue: backout-exception-to-left-alone-files
kind: audit
category: product-intent
artifacts:
  - decision:runs-fix-what-the-project-owns
status: verified
triage: question
opened: 2026-10-05T10:03:49Z
---

# Converge's skill names one agent that may touch a left-alone file, and the backout prompt names a second

A `/converge` run finds defects and sends fixer agents to fix them. Some files are off limits to every agent of the run. decision:runs-fix-what-the-project-owns lists five kinds: the design corpus and coding standards, a suite-owned file, an owner's declaration, a record, and a document the release regenerates. The run still has to undo its own edit to such a file when a fix fails. The backout prompt allows that, and the skill's own list of exceptions does not mention it. Two texts of the same skill disagree about who may touch a left-alone file.

## Mechanism

Three texts carry the rule:

- The shared rule `{{FIX-LINE-RULE}}` in `plugins/ok/families/ok-planner/skills/_converge/coding-rules.md` says the run "leaves five kinds of file alone, and no agent of the run edits one". Every merge, fix, verify, backout, sprint review, and sprint pass prompt pastes it.
- `plugins/ok/families/ok-planner/skills/converge/SKILL.md`, under "What stays outside this skill", says no agent edits a file of the five kinds, and that "the one exception is the owner-list agent, which writes the intake".
- `plugins/ok/families/ok-planner/skills/converge/prompts/backout.md` pastes the shared rule, then tells the backout agent to back out each file the stuck defect's fixes changed "even where the fix line rule above leaves that file alone: the backout undoes the run's own edit and makes none of its own".

A fixer can edit a left-alone file by mistake. The edit reaches the tree before a verifier sends the fix back. When the defect reaches its limit of send-backs, the orchestrator files a backout for every file the defect's fix tasks staged, and the backout must restore that file. So the backout prompt states a real second exception. The skill's list names only the owner-list agent.

A fixer in run converge-2026-10-05T024119 wrote the exception into the backout prompt alone, because the shared rule lay outside its task's files, and recorded the choice as call i48.

## State of play

No harm has been observed. The backout agent reads its own exception. The risk is another reader: the orchestrator, or a verifier, reads SKILL.md's "the one exception" and treats a backout's restore as a breach. No accept-list entry covers the disagreement today.

The decision itself is not wrong. Restoring the owner's bytes undoes the run's edit and makes no new one, so the file ends as the run found it. The decision's rationale concerns changes a run makes ("the next converge overwrites a local edit"; "changing either is the owner's act"), not undoing them.

## Options

1. Amend decision:runs-fix-what-the-project-owns to say a backout restores a stuck defect's own edit to a left-alone file, and state that exception in the shared rule and in SKILL.md too. Cost: a corpus delta through `/plan-sprint`, and one more clause in a rule every merge, fix, and verify prompt carries, though only the backout acts on it.
2. Keep the decision and keep the exception in the backout prompt alone, as the more specific text. Cost: SKILL.md's "the one exception is the owner-list agent" stays false.
3. Keep the decision as it stands, keep the exception's statement in the backout prompt, and correct SKILL.md's exception list to name the backout beside the owner-list agent. Cost: none beyond a one-sentence tooling edit; no corpus delta.

The ruling decides whether the backout's restore of a left-alone file needs a corpus commitment, or only an accurate list in the skill.

## Ruling

> Recommended ruling (/triage-issues): Option 3. Leave decision:runs-fix-what-the-project-owns and the shared fix-line rule as they stand. Correct the converge skill's list of exceptions so it names both: the owner-list agent writes the intake, and a backout restores a stuck defect's own edits, left-alone files included. The backout prompt keeps the full statement of its exception.
>
> Rationale: a restore leaves the file as the run found it, so the decision's line ("They leave five kinds of file alone") already holds, and it needs no new clause. The defect is that SKILL.md claims "the one exception" while the backout prompt states a second; option 2 leaves that false claim. Option 1 adds a clause to a rule that every merge, fix, and verify agent reads and none acts on, against the cheatsheet's "Say it once". The flip case: if a backout ever has to do more than restore bytes in a left-alone file, for example merge around another defect's edit there, then it makes a change of its own. The decision should then say so, as option 1 does.

<!-- Owner: this is a recommendation, not your decision. Leave it
as-is to accept; the next /plan-sprint carries it. Edit the text to
redirect, empty the section to discuss live, or delete this note to
adopt the ruling as your own. -->
