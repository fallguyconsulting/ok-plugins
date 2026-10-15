# This project, for the review loop

Agents keep this file current: a sprint build that adds or changes a script input updates it in the same stage, and a `/converge` fixer fixes a clear defect in it. The limits under "What no agent of this loop ever runs" bind every agent. The review loop pastes the file into every prompt that reads or runs the tree. It holds the facts a general loop cannot know. Replace each instruction line below with this project's facts, and leave a section empty where the project has nothing to say.

## The root and what is out of scope

Name the project root and each folder `.ok-planner/config.json` declares under `folders`, which every mode of the loop reads with the root; the paths no agent reads or edits (working notes, briefs, vendored code); and the further folders outside the root a sprint may list under `## Paths outside the project root`.

## What no agent of this loop ever runs

Name every command that reaches a hosted deployment, spends money, or acts with the operator's own credentials, one line each. Each line is a rule every agent keeps: no agent runs the command while it checks something, and no agent removes or weakens the line.

## The helpers the catalogs name

Name the tree's event emitter, its atomic-replace helper, and the practice that governs owner frames, each as the symbol or slug an agent imports or cites.

## Code rules

List each `.claude/rules/` file that holds a rule about the shape of code, one `` - `<path>` `` line each.

## Scripts for developers and operators

List each script the project ships for its developers or operators, by path, with the inputs it takes; accept-list entry A3 covers every one.

## Drive commands

Give one line per role, as `` - `<role>`: `<command>` `` or `` - `<role>`: <the steps under a heading below> ``, for the roles `instance-create`, `instance-destroy`, `resource-start`, `resource-stop`, `service-log`, and `sign-in`; `{name}`, `{folder}`, and `{service}` stand for a drive name, an instance folder, and a service. `{tag}` stands for the tag `stack up` printed for the drive's stack. The drive names it in every driver's brief, so a driver fills it into any role's line that names it, such as `service-log` and `sign-in`; every line that names `{tag}` reaches the stack this run started, never another run's.

The drive's stack is declared in `.ok-planner/config.json` under `stack`, not here: the command that starts it, the command that stops it, and the variable the start command reads the run's tag from, or, for a product with no stack to start or stop, such as a product of skills or shell scripts, why it has none. The drive starts the stack with `.ok-planner/bin/stack up` and ends it with `.ok-planner/bin/stack down <tag>`, whether the run passed or failed. A project that declares neither skips the drive.

## Running the product, for the drive

Say how a driver reaches the stack its run started from the run tag its brief names, such as the ports and the folder `.ok-planner/bin/stack list` prints for that tag, which surface is the product's primary user surface, the other surfaces a story may be offered through, and the steps that sign a user in on each.

## Resources a driver starts

Give the steps a driver follows to start and stop a resource of its own under its drive name, where a story needs one. A driver runs the start as `.ok-planner/bin/stack up -- <the command>` from the project root, which runs it in a run of its own and prints that run's tag on line 1, and ends the resource with the stop steps, then `.ok-planner/bin/stack down <tag>`. `stack up` waits for the command to exit, so write the start as one command, such as `sh -c '<steps>'`, that starts any server in the background and writes every file under `$OK_RUN_FOLDER`.

## Stories that drive alone

List, one `` - `<story slug>` `` line each, the stories that change state every other driver reads; each runs after every other driver, one at a time.

## Stories that drive on an instance of their own

List, one `` - `<story slug>` `` line each, the stories that need a deployment the shared stack cannot give, and the steps a driver follows to create, use, and destroy its instance.
