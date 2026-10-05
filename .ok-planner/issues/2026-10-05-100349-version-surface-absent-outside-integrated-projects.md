---
issue: version-surface-absent-outside-integrated-projects
kind: audit
category: product-intent
artifacts:
  - story:see-governing-versions
  - concept:conduct
status: verified
triage: question
opened: 2026-10-05T10:03:49Z
---

# The conduct tells every session to run `/ok-version`, which exists only in projects that integrate ok-planner

The suite ships the conduct, a user's personal delivery discipline, as the plugin `ok-conduct`. A user installs it once, and it loads in every project. Its session-start hook adds this line to every session: "/ok-version reports the conduct actually governing." `/ok-version` is not part of the conduct. It ships inside ok-planner, and it reaches a project only when that project integrates ok-planner. In any other project, the hook names a command the user cannot run. That user also has no other way to see the governing conduct beside the installed one, which story:see-governing-versions promises "a suite consumer".

## Mechanism

`plugins/ok-conduct/hooks/session-start` writes the line into every session. The only copy of the skill is `plugins/ok/families/ok-planner/skills/ok-version/SKILL.md`, in the family the front door carries. The converge core copies it into a project's `.claude/skills/` only when the project integrates ok-planner. `plugins/ok/skills` holds only `ok`, and `plugins/ok-conduct` ships no skill. `/ok` accepts a declined bootstrap and records the project as "not integrated (declined)". `/ok` reports suite versions, but not the governing conduct. It also updates plugins before it reports, so it is no read-only check.

A driver in run converge-2026-10-05T024119 found this (failure i4). The merge agent confirmed it under A9: the hook tells the session something false that the user acts on. The hook line stood the same at the run's base, so the defect lay outside that run's scope. A sprint driver recorded the open question as call i24: "The corpus does not decide which."

## State of play

The corpus pulls two ways. concept:conduct says the conduct governs "in every project and session the user runs", and lies "outside any project's vendored presence". decision:vendored-skills keeps the machine-shared layer to "the administrator, the conduct, and the web setup skills". The version skill belongs to the vendored layer. story:see-governing-versions does not say whether a user with only the conduct counts as "a suite consumer". Its goal is "so that version drift is visible and convergence stays my deliberate act", and convergence is the act of `/ok` in an integrated project. Between sessions, the governing conduct and the installed one load from the same copy, so they differ only after a plugin update mid-session. A new session ends that gap.

## Options

1. The story owes the view in every project, so a version surface ships in a user-scoped plugin, the front door or `ok-conduct`. Cost: decision:vendored-skills widens its machine-shared layer by a skill and must say so. One idiom per job then forces the vendored `/ok-version` to be retired or reduced.
2. The story owes the view only in a project that integrates ok-planner, and the hook names `/ok-version` only where the project holds the skill. Cost: the conduct's hook must know ok-planner's vendored layout, which couples the personal layer to a project's estate.
3. The story narrows as in option 2, and the hook names no command: it states the installed conduct version only. Cost: an integrated project loses the hook's pointer to `/ok-version`, though the skill still appears among the project's skills.
4. `/ok`'s report carries the governing and installed conduct versions. Cost: `/ok` updates plugins before it reports, so its "installed" value is the post-update one, and a version check becomes an administration act.

The ruling decides where the suite owes the version view, and so what the conduct's hook may point to.

## Ruling

> Recommended ruling (/triage-issues): Option 3. Amend story:see-governing-versions so its actor is the owner of a project that integrates ok-planner, where convergence happens. Change the conduct's session-start hook to state the installed conduct version and name no command.
>
> Rationale: concept:conduct places the conduct outside any project's vendored presence. A conduct line that points at a vendored skill crosses that boundary. Option 2 keeps the crossing and hard-codes ok-planner's layout into the personal layer. Option 1 widens the machine-shared layer that decision:vendored-skills keeps small on purpose, to serve a drift that a conduct-only user ends by starting a new session. Option 4 turns a read-only check into an administration act. The story's own goal names convergence, which only an integrated project performs, so narrowing the actor states what it already means. Rule this with its sibling installed-version-entry-selection, which amends the same story. The flip case: if users who run only the conduct are a real audience who need to confirm which conduct governs a session, the view belongs in a user-scoped plugin. Option 1 is then right, with `/ok-version` moved there rather than duplicated.

<!-- Owner: this is a recommendation, not your decision. Leave it
as-is to accept; the next /plan-sprint carries it. Edit the text to
redirect, empty the section to discuss live, or delete this note to
adopt the ruling as your own. -->
