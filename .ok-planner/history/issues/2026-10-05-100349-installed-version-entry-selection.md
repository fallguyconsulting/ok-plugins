---
issue: installed-version-entry-selection
kind: audit
category: product-intent
artifacts:
  - story:see-governing-versions
status: verified
triage: question
opened: 2026-10-05T10:03:49Z
---

# `/ok-version` can call a disabled plugin copy "installed", and the story does not say which copy counts

`/ok-version` prints two versions of each suite plugin side by side: the one governing this session, and the one installed. A user reads the pair to spot drift. Claude Code can hold several installs of one plugin for one project: one at user scope, one at project scope, each enabled or disabled. The skill picks one of them as "installed" by a rule of its own. story:see-governing-versions promises the governing version "alongside what is installed", and does not say which install that is. The skill counts a disabled install, which no session loads. So the "installed" line can name a version that will never govern anything here.

## Mechanism

`plugins/ok/families/ok-planner/skills/ok-version/SKILL.md` runs `claude plugin list --json` once. That command prints one entry per install. Step 2 takes an entry whose `projectPath` is this project's root or whose `scope` is `user`, and prefers the project's entry where both apply. Step 2 then reports the `ok@` entry's version. Step 5 does the same for the `ok-conduct@` entry. The skill reads neither the `enabled` field nor the `projectEnabled` field. On this machine every entry prints `projectEnabled: false`, the loaded user-scope installs of `ok` and `ok-conduct` included. That field alone cannot mark the loaded install.

A fixer in run converge-2026-10-05T024119 built this rule to fix defect i23 and recorded two readings as call i49. The project's entry outranks the user's, matching Claude Code's more-specific-scope precedence. A disabled entry still counts, "since the story asks what is installed, not what is enabled".

## State of play

Precedence by scope is settled in the skill. Enablement is not settled anywhere. decision:vendored-skills says "the plugin system delivers only the user-scoped plugins", so a project-scoped install of `ok` or `ok-conduct` already lies outside the designed shape. The corpus says nothing about one. No accept-list entry covers the choice until the story says what "installed" names. Once it does, a line that names a different install is a false report the user acts on, under A9.

## Options

1. "Installed" names the install a new session here would load: an enabled install, the project's over the user's. Cost: a story clause and a skill edit. A user whose only copy is disabled no longer sees that copy's version.
2. "Installed" names any install present for this project or user, enabled or not, the project's first. Cost: a story clause only, since the skill already does this. The line can name a version nothing loads, which weakens the drift signal the story exists for.
3. Report every applying install, with its scope and whether it is enabled. Cost: the skill's fixed five-line report grows into a list, and the story's single "what is installed" becomes several.

The ruling decides what "installed" names when more than one install of a plugin applies to this project.

## Ruling

> Recommended ruling (/triage-issues): Option 1. Amend story:see-governing-versions so that "what is installed" means the version a new session in this context would load. That is the enabled install, with the project's install over the user's. Change `/ok-version` to skip disabled installs. Where an install applies but none is enabled, the line says so instead of printing a version.
>
> Rationale: the story exists "so that version drift is visible". Drift is the gap between what governs now and what would govern next, and a disabled copy governs nothing. Option 2 lets the pair show drift that cannot happen. Option 3 answers a question the story does not ask, and the cost falls on the fixed report every user reads. Saying "none enabled" keeps option 1's one cost small: a user with a disabled copy learns it is disabled rather than seeing `unknown`. Rule this with its sibling version-surface-absent-outside-integrated-projects, which amends the same story. The flip case: if Claude Code's `enabled` field turns out not to track what a session loads, as `projectEnabled` does not, the skill cannot tell the loaded install apart. Option 3's full list would then be the honest report.

<!-- Owner: this is a recommendation, not your decision. Leave it
as-is to accept; the next /plan-sprint carries it. Edit the text to
redirect, empty the section to discuss live, or delete this note to
adopt the ruling as your own. -->
