---
decision: no-speed-floor
---

# The testing standard names no speed floor

## Choice

The testing standard names no speed floor. The ranking chooses which
tests a reader reads (see also: speed-ranked-by-median-seconds), and
the reader judges the waste. No time budget decides a verdict.

## Rationale

A suite's speed depends on the product and on the machine it runs on,
so no target speed can be a verdict without tying a pass to the
machine.

## Alternatives

- A round budget the completion check enforces: completion then
  depends on the machine the round ran on.
- A speed floor, such as a time under which a test passes unread:
  ties which tests a reader reads to the machine.
