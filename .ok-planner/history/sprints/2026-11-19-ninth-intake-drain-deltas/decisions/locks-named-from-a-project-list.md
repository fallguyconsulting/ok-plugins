---
decision: locks-named-from-a-project-list
---

# Lock names come from one list the project keeps

## Choice

The project keeps one lock list: each lock name with one line saying
what shared thing it guards. The scenario list holds it, and only the
tests tool writes it (see also: scenario-list-decided-once). The tests tool refuses a lock name the list does
not hold, wherever it reads a declaration. An agent that needs a lock
reads the list first, and adds a name only where no name on it fits.
A name names the shared thing a test sets up or checks, in the
product's own words, at the narrowest scope at which two tests can
both see it: `resource-change-notice`, not the service
`formation-graph` or the action `formation-apply`. State only one test
can see, such as an account or a device the test created, needs no
lock. The tests tool removes a name from the list only while no live
test and no test support file declares it.

## Rationale

Two names for one thing let two tests that disturb each other each
hold a lock and still run together. A list read before each addition
keeps one name per thing, and the refusal stops a name typed wrong. A
name at a service's scope keeps every test that touches the service
apart from every other, and costs a round most of its parallel time; a
name at the narrowest scope two tests share keeps apart only the tests
that can see each other's work. The product's own words let a writer
and a fixer find the name a thing already has, and the line beside
each name tells the next agent what the name covers.

## Alternatives

- Free names on each test, with no list: one thing takes two names,
  and two tests that hold different names for it run together.
- One name per service: tests that touch one service, each through a
  different thing in it, run one after another.
- One name per product action: a test that watches an outcome must
  hold the lock of every action that can cause it.
