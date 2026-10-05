---
issue: drive-rule-conflates-no-stack-with-unfilled-commands
kind: audit
category: tooling
artifacts: []
status: answered
triage: question
opened: 2026-10-04T23:34:00Z
---

# Converge skips the drive of a product with no stack, because it reads "no stack" as "nobody filled in the drive commands"

The `/converge` skill skips the story drive wherever the project's review facts file, `.ok-planner/review/project.md`, names no drive command. It does so in drive mode's stack step and in sprint certification's drive step. The rule exists so that a project whose owner never filled in the seeded skeleton gets no drive against a stack nobody described.

The skill reads one signal, an empty Drive commands section, for two different facts. One is that the owner never filled the section in. The other is that the product has no stack to start. This project is the second case: its project.md says "The product has no stack to start or stop", and its Drive commands section is empty for that reason. The seeded project.md offers no way to say so.

The harm falls on sprint certification. decision:drive-tries-each-story-as-a-user says certification drives the stories a sprint adds or amends, and a driver "works out from the running product how to get the benefit". A product with no stack still has stories to drive. Followed literally, the skill skips every drive on such a product and reports "the drive cannot start" for a product that needs no start. The fix loop's confirm step fails too: it asks the review tool for the `stack-start` command, and the tool refuses a missing role.

Sprint certification run converge-2026-10-04T060800 needed the drive: the sprint's work item 3 required a drive of story:converge-project-estate. The session departed from the rule by hand. It skipped the stack exec tasks and filed the drivers anyway (session note i1). The change falls in the product source in this repository: the converge skill, the review tool, and the seeded project.md under the ok-planner family. The materialized copies follow the next `/ok`.

## Options

- project.md declares no stack with an explicit line in its Drive commands section. The review tool reads it, the skill drives without starting, stopping, or confirming a stack, and a section with no line at all still skips the drive. Cost: a new line in the section's grammar, taught in the review tool, the skill, and the seed.
- Only the seed gains the no-stack line. Cost: it does nothing unless the tool and the skill read it, so it is part of the first option, not an alternative.
- Treat a missing `stack-start` role as no stack whenever the rest of project.md is filled. Cost: an empty section, as here, still cannot be told from the skeleton, so it needs the explicit line anyway.
- Leave the rule, and sessions keep departing from it by hand. Cost: the skill and the decision disagree, and a session that follows the skill skips a drive the sprint requires.

The ruling decides how the skill tells a product with no stack from an unfilled skeleton.

## Ruling

Accept the generated ruling, without its last step. A project can declare in its Drive commands section that the product has no stack. Where the section carries that declaration, drive mode, sprint certification's drive, and the fix loop's confirm step file their drivers and skip the stack's start and stop tasks, and the review tool reports the declaration instead of refusing the missing role. Where the section names no command and no declaration, as in the seeded skeleton, the drive is still skipped with that reason. The seeded section shows the declaration beside the roles. A project of shell scripts, for example, would use it.

This repository does not add the declaration: it takes the inline execution path ruled in leaf-drivers-cannot-reach-orchestrating-surfaces and does not drive.

Answered 2026-10-05: the ruling is built in c9a30ec (v24.0.0) and converged into this repository's vendored layer. A `- No stack:` line in the Drive commands section declares no stack; `review drive-stack` prints `stack`, `none`, or `unfilled`; drive mode, sprint certification's drive, and the confirm step skip the stack tasks on `none`; and the seeded project.md teaches the line. One departure from the ruling's last paragraph: this repository does add the declaration, because the inline execution path it relied on is retired, and the drive must run here to review skill surfaces.
