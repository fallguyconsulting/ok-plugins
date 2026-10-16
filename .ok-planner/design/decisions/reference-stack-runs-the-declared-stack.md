---
decision: reference-stack-runs-the-declared-stack
---

# The reference stack tool runs the stack the project's configuration declares

## Choice

A project that calls the reference stack tool with no command
declares its stack once, in its ok-planner configuration: the start
command, the stop command where the stack makes anything the tool does
not find by the run tag, and the variable the start command reads the
run tag from (see also: stack-helpers-serve-project-commands). The
reference stack tool, called with no command, runs the declared stack.
Called with a command, it runs that command in the declared stack's
place, with the stop command and tag variable its caller names.

## Rationale

A start command written once cannot disagree with itself. A project
whose review facts and own scripts all call the tool with no command
start one stack the same way from every caller, and a change to the
stack is one edit. A caller that needs a different stack, such as a
build that starts one service alone, still names its own command
without a second declaration. The cost: a project keeps one setting
that only an optional tool requires, beside the review facts that the
drive and the audit read.

## Alternatives

- The reference stack tool takes its commands from its command line alone — every caller spells the start command out, and the copies drift apart.
- The declaration lives in the review facts, and the tool reads it there — the tool then reads a file the review loop owns, and a project that does not run the review loop has nowhere to declare its stack.
- A declaration per named stack — every project pays for a map of stacks that most projects never need, since a caller can already name its own command.
