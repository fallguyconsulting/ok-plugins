---
decision: shared-outcomes-checked-for-a-new-instance
---

# A test that checks a shared outcome resets it or checks for a new instance

## Choice

A test that checks a shared outcome either resets the outcome in its
setup under its exclusive lock, or reads the outcome's state before its
action and checks for a new instance after it (see also:
tests-set-up-their-own-starting-state).

## Rationale

A reset under the exclusive lock keeps every other test that holds the
lock from raising the outcome between the reset and the check. A check
for a new instance after the action passes only on what this test
caused, even where another test raised the same outcome before it.

## Alternatives

- Check a shared outcome as it stands after the action: an earlier
  test's instance of the same outcome passes the check.
