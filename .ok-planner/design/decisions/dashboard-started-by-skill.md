---
decision: dashboard-started-by-skill
---

# A vendored skill starts the dashboard

## Choice

A vendored `/dashboard` skill starts the dashboard's service in the
background of the owner's session and reports the page's address. The
service also runs directly from a terminal.

## Rationale

The owner plans and triages from a session, so a verb there keeps the
dashboard one command away. The skill is a thin verb over the same
program, so the program stays usable without a session.

## Alternatives

- Only a terminal command — no new verb, but the owner leaves the session to start the page.
