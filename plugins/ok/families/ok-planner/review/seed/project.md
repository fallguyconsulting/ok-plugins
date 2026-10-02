# This project, for the review loop

The owner writes this file. The review loop pastes it into every prompt that reads or runs the tree. It holds the facts a general loop cannot know. Replace each instruction line below with this project's facts, and leave a section empty where the project has nothing to say.

## The root and what is out of scope

Name the project root, the paths no agent reads or edits (working notes, briefs, vendored code), and the folders outside the root a sprint may list under `## Paths outside the project root`.

## What no agent of this loop ever runs

Name every command that reaches a hosted deployment, spends money, or acts with the operator's own credentials, so no agent runs it while it checks something.

## The helpers the catalogs name

Name the tree's event emitter, its atomic-replace helper, and the practice that governs owner frames, each as the symbol or slug an agent imports or cites.

## Code rules

List each `.claude/rules/` file that holds a rule about the shape of code, one `` - `<path>` `` line each.

## Scripts for developers and operators

List each script the project ships for its developers or operators, by path, with the inputs it takes; accept-list entry A3 covers every one.

## Drive commands

Give one line per role, as `` - `<role>`: `<command>` `` or `` - `<role>`: <the steps under a heading below> ``, for the roles `stack-start`, `stack-stop`, `instance-create`, `instance-destroy`, `resource-start`, `resource-stop`, `service-log`, and `sign-in`; `{name}`, `{folder}`, and `{service}` stand for a drive name, an instance folder, and a service.

## Running the product, for the drive

Say how the drive's stack starts and stops, which surface is the product's primary user surface, the other surfaces a story may be offered through, and the steps that sign a user in on each.

## Resources a driver starts

Give the steps a driver follows to start and stop a resource of its own under its drive name, where a story needs one.

## Stories that drive alone

List, one `` - `<story slug>` `` line each, the stories that change state every other driver reads; each runs after every other driver, one at a time.

## Stories that drive on an instance of their own

List, one `` - `<story slug>` `` line each, the stories that need a deployment the shared stack cannot give, and the steps a driver follows to create, use, and destroy its instance.
