---
issue: prohibitions-that-restate-or-repeat
kind: human
category: unspecified
artifacts:
  - decision:single-source-transclusion
  - concept:skill
status: open
opened: 2026-09-24T05:05:13Z
---

# Skill texts carry prohibitions that restate an instruction beside them or repeat a rule stated elsewhere

## Problem

The suite's skill, ceremony, and shared-prompt texts carry at least 46
prohibitions that do no work: each forbids the opposite of an
instruction next to it, repeats a rule another file already states, or
forbids an act the skill has no step for. The repeats break
`decision:single-source-transclusion`, which says "no block is defined
in more than one place"; the others add length and name the act they
forbid to an agent that would not have attempted it.

A prohibition does work in two cases:

1. It guards an act that cannot be undone or that reaches outside the
   repository: discarding uncommitted work, committing or pushing
   without the owner, deleting a file, overwriting owner-authored text.
2. It blocks a failure an agent actually made, which the positive
   instructions alone do not exclude.

The sweep below applied that test to every `SKILL.md`, every file
under `skills/_shared/`, every `ceremony/*.md`, the cheatsheets, and
the agent profiles under `plugins/ok/`. It kept every guard of the
first kind, including the git-discard rule repeated once per
cold-started task prompt, because each dispatched agent reads only its
own prompt. Line numbers are at the tree of 2026-09-24 and will drift;
the quotes locate each site.

The pattern with the widest reach: the front-door ceremonies
(`ceremonies/audit`, `certify-work`, `document`, `plan-sprint`) each
end with a "What this skill does NOT do" list whose bullets repeat the
family ceremony file's Boundaries list, and four of them share two
bullets verbatim ("Does not carry family knowledge", "Does not
converge an estate, materialize a file, or repair a family's
presence").

**Complement of a positive instruction**

- `families/ok-planner/scripts/ok-planner-cheatsheet.md:233` —
  "never write a plan document from one" — the same sentence opens
  "Staging it is execution's job".
- `families/ok-planner/skills/_shared/certification-core.md:195` —
  "Do not stop to ask." — follows "make the best engineering call and
  record it".
- `certification-core.md:263` — "Edit the completion report itself
  never." — follows "You and the architect own `## Divergences`,
  through that pool".
- `certification-core.md:446` — "Rewrite a resolved entry through its
  item, never in the file."
- `certification-core.md:541` — "Never split an area and never merge
  two" — the same sentence says an area "is as large as it is".
- `certification-core.md:675` — "Never drop a defect for being
  pre-existing, and never widen your reading to hunt for them" —
  follows "is still a finding: file it".
- `certification-core.md:765` — "You file nothing and route nothing."
- `certification-core.md:831` — "You never file an issue and never
  stop to ask." — precedes "make the most plausible call, continue,
  and record it".
- `families/ok-planner/skills/_shared/implementation-auditor.md:78` —
  "prose style is never a defect."
- `implementation-auditor.md:191` and `:395` — "Never reach behind the
  surface." — follows "and nothing else".
- `families/ok-planner/skills/_shared/artifact-definitions.md:92` —
  "never about the surface that delivers it" — follows "The delivery
  surface belongs to a decision".

**Duplicate of a rule stated elsewhere**

- `ceremonies/audit/SKILL.md:85`, `ceremonies/plan-sprint/SKILL.md:61`,
  `ceremonies/document/SKILL.md:107` — "Does not carry family
  knowledge." — verbatim in `ceremonies/certify-work/SKILL.md:82`.
- `ceremonies/audit/SKILL.md:96`, `ceremonies/plan-sprint/SKILL.md:65`,
  `ceremonies/document/SKILL.md:118`,
  `families/ok-planner/skills/execute-tasks/SKILL.md:50` — "Does not
  converge an estate, materialize a file, or repair a family's
  presence." — in `ceremonies/certify-work/SKILL.md:85`.
- `ceremonies/audit/SKILL.md:86`, `:89`, `:90`, `:95` — "Does not fix
  anything", "Does not build the project", "Does not compute
  staleness…", "Does not roll into follow-on work" — in
  `families/ok-planner/ceremony/audit.md:233`, `:236`, `:238`, `:243`.
- `ceremonies/plan-sprint/SKILL.md:64` — "Does not stage, phase, or
  theme the work items" — verbatim in
  `families/ok-planner/ceremony/plan-sprint.md:263`.
- `ceremonies/certify-work/SKILL.md:12` and `:84` — "This gate does not
  audit", "Does not widen its reading mid-run" — in
  `families/ok-planner/ceremony/certify-work.md:57` and `:58`.
- `certification-core.md:937`–`:939` — "Triages and defers nothing",
  "Asks the owner nothing mid-round", "Archives and commits nothing on
  its own" — stated at `certification-core.md:47`, `:78`, `:931`.
- `certification-core.md:941` — "Dispatches no agent directly" — the
  file establishes every agent as a task at lines 5, 49, 70.
- `certification-core.md:804` and
  `families/ok-planner/skills/_shared/sprint-document.md:132` — "Never
  stub, defer, narrow, no-op, or leave a `TODO` in place of a promised
  outcome." — near-verbatim in both.
- `implementation-auditor.md:229` and `:262` — "never a warrant", "It
  never stands as proof." — `implementation-auditor.md:215` says
  "Conclusions never carry".
- `implementation-auditor.md:315` and `:559` — "never escalates",
  "never escalated" — stated at `implementation-auditor.md:78`.
- `implementation-auditor.md:490` — "never substitute a reading for the
  measurement" — `implementation-auditor.md:273` says "Never settle a
  story by reading".
- `families/ok-planner/skills/discover-design/SKILL.md:655` and `:731`
  — "Record, do not evaluate." — stated at `discover-design/SKILL.md:214`.
- `families/ok-planner/skills/verify-issues/SKILL.md:188` and `:192` —
  "Does not delegate…", "Does not edit code or the design corpus" —
  stated at `verify-issues/SKILL.md:15`, `:122`, `:136`.
- `artifact-definitions.md:258` — "never an edit" — stated at
  `artifact-definitions.md:255`, "The verifier never applies the fix".
- `families/ok-plumbline/ceremony/plan-sprint.md:37` — "A departure is
  a competing practice, never an exemption." — verbatim in
  `families/ok-plumbline/docs/plumbline-cheatsheet.md:60`.
- `families/ok-plumbline/ceremony/certify-work.md:93` — "Never edits
  `.ok-plumbline/config.json`." — in
  `families/ok-plumbline/ceremony/audit.md:236`.

**Act out of reach**

- `certification-core.md:940` — "Plans and builds no new scope" — no
  step of the review-fix loop plans or builds scope.

The project that surfaced this (linescout `platform/`) now carries the
test as a project rule for its own trial skills, at
`.claude/rules/skill-prohibitions.md`.

## Candidates

- Add a decision that a prohibition in a suite text stands only where
  it guards an irreversible or outward act or blocks a failure it
  names, and sweep the suite's texts against it in one sprint: cut the
  complements, cut each duplicate to the one place that owns it, and
  cut each "does NOT do" bullet that restates the body.
- Amend `decision:single-source-transclusion` so a front-door
  ceremony's boundaries are its family contribution's Boundaries,
  referenced rather than restated, and cut the duplicates alone;
  leave the complements as they stand.
- Keep the texts as they are, accepting the length and the repeats as
  emphasis for agents that read each prompt cold.
