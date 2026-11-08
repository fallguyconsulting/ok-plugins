---
decision: settings-have-no-code-defaults
---

# Code gives no setting a default

## Choice

Code reads every setting from the project's configuration and gives
none a default. A setting is a value an operator could sensibly want
to differ between deployments: an interval, a limit, a threshold, a
size, a timeout, an address. A tuning value written as a literal in
code is a setting. Code that finds a setting missing refuses to start
and names the missing key.

A value the product's design fixes stays a constant, such as a set of
presets a user picks from. So does a value a spec, a protocol,
arithmetic, or a data format fixes, such as a status code or the bytes
in a kibibyte. A library value the project passes as a parameter is a
setting, and the project passes it from configuration.

The change that removes a default writes that key, with the former
default as its value, into every deployment script and configuration
file the project owns, so no deployment changes behavior on update.
For the suite's own tools, true-up writes each such key into every
project's configuration. Where the former behavior depends on the
project's state, true-up reads that state, such as testing turned on
in a project an earlier test sprint tested. Where a key records a fact
about the project the suite cannot read, such as the schedule the
project's suite command runs, true-up writes the value that keeps the
tools' former behavior and marks it unconfirmed, with no owner's words
in its `said` field. While no open issue carries such a key, true-up
files one intake issue that asks the owner for the answer and names
where the answer is recorded, such as `/ok-setup` for a testing key. A tool reads an
unconfirmed value for its former behavior and fails no check on it.
Where a new required key would break a user across a release
boundary, the change takes a boundary ruling, such as a migration
(see also: release-boundaries-bind-changes).

The rule binds every project the suite manages, as a coding rule. Only
judgment tells a setting from a constant, so review reads for it, and
no lint enforces it (see also: accept-list-decides-defects).

## Rationale

A default in code is shared by every deployment that never set the
key. A value changed in code to make tests fast reaches every
production deployment that relied on the old one. On one project, a
run that fixed code for its tests cut a device-poll interval to one
second in code, and every new production deployment then polled at
that rate. With no default, the test stack's configuration names its
own value and the production configuration names its own, so a change
to one cannot reach the other. Refusing to start names the gap at
once, where a default would hide it. Writing the former value into
every deployment the project owns keeps the change invisible to
running systems. A former value true-up writes for a fact it cannot
read is a guess, not the owner's answer: marking it unconfirmed keeps
the tools' behavior unchanged, and no check fails a project on a
guess. One issue per key asks the owner once and keeps the question
open until the owner answers.

## Alternatives

- Defaults in code, overridden for tests: a value changed for tests
  reaches every deployment that never set it.
- Named profiles in code, such as production and test: a hidden
  default by another name, chosen by whoever forgot to pick one.
- A lint for literal values: no procedure tells a setting from a
  constant, so it flags constants and misses settings.
- True-up asks the owner for each such key before it writes: every
  upgrade waits on a question the owner may not be able to answer yet.
- True-up writes a guessed value as the owner's answer: a check then
  fails a project whose runner works otherwise.
