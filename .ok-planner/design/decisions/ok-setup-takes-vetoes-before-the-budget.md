---
decision: ok-setup-takes-vetoes-before-the-budget
---

# `/ok-setup` takes the owner's vetoes before it writes the test budget

## Choice

`/ok-setup`'s budget agent records each choice it makes without the
owner as a call. `/ok-setup` shows the owner every such call, reruns
the agent with each call the owner vetoes, and writes the budget only
after, so a vetoed call never takes effect and files no issue (see
also: testing-set-up-by-its-own-verb).

## Rationale

The owner is promised a way to see and overturn every call an agent
made in their absence (see also: veto-calls-made-in-my-absence). The
closing ceremonies file an issue per veto because their work is done
by the time the owner reads the calls (see also:
converge-close-takes-vetoes). `/ok-setup` holds the owner before the
budget exists, as planning does at approval, so a veto acts at once,
and no budget the owner rejected ever runs.

## Alternatives

- File one issue per vetoed budget call for the next planning
  session, as the closing ceremonies do: a budget the owner rejected
  runs every sprint until a sprint changes it.
- Rerun the agent and also file an issue per veto: a second record of
  a veto already acted on, which planning must then close.
