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
project's configuration. Where a new required key would break a user
across a release boundary, the change takes a boundary ruling, such as
a migration (see also: release-boundaries-bind-changes).

The rule binds every project the suite manages, as a coding rule. Only
judgment tells a setting from a constant, so review reads for it, and
no lint enforces it (see also: accept-list-decides-defects).

## Rationale

A default in code is shared by every deployment that never set the
key. A value changed in code to make tests fast reaches every
production deployment that relied on the old one. On one project, a
test sprint cut a device-poll interval to one second in code, and
every new production deployment then polled at that rate. With no
default, the test stack's configuration names its own value and the
production configuration names its own, so a change to one cannot
reach the other. Refusing to start names the gap at once, where a
default would hide it. Writing the former value into every
deployment the project owns keeps the change invisible to running
systems.

## Alternatives

- Defaults in code, overridden for tests: a value changed for tests
  reaches every deployment that never set it.
- Named profiles in code, such as production and test: a hidden
  default by another name, chosen by whoever forgot to pick one.
- A lint for literal values: no procedure tells a setting from a
  constant, so it flags constants and misses settings.
