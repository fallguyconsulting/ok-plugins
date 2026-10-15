---
decision: port-range-chosen-at-true-up
---

# The owner picks each project's port range at true-up, from a random suggestion clear of listed ports

## Choice

Where a project publishes ports and declares no provisioning range, the true-up core offers one. A project publishes ports when its configuration names any, or, where the suite's lint can run, when a compose file in it publishes a host port. The offer names the ports it found and suggests a range picked at random above 1024 and below the start of the machine's ephemeral range, in a gap that no port on the stack tool's block list touches and whose ports no listening program holds at that moment. The front door asks the owner once: take the suggestion or name another range. It reads where the ephemeral range starts from the machine, uses 49152 where it cannot read the value, and refuses a range that reaches that start. Where an owner-named range overlaps listed ports, it names the ports the range hits and how many of its ports remain to lease, and the owner keeps the range or picks another. It reminds the owner that no other project on the machine may share the range. On the answer, the true-up core writes the range and the port names into the project's configuration. A declined offer returns on the next true-up. A project that publishes no ports gets no question.

## Rationale

Only the owner knows which other projects on the machine lease ports, so only the owner can keep their ranges apart, and true-up is the act that already settles the owner's configuration. A random suggestion keeps two projects that both take the suggestion from landing on one range. A gap clear of listed ports leaves every suggested port leasable. The ephemeral range starts at 49152 on macOS and Windows and at 32768 on a default Linux, so a fixed bound of 49152 would admit, on Linux, a range the operating system itself hands out; the bound comes from the machine. The stack tool skips listed ports, so a range that spans some still works, and an overlap warns rather than refuses.

## Alternatives

- One default range for every project — every project that keeps the default shares one range, and their registries cannot see each other.
- A range derived from the project's path — two paths can land on one range, and a moved checkout changes its range.
- A fixed upper bound of 49152 — on Linux it admits ranges inside the operating system's own ephemeral range.
- Refuse an owner-named range that overlaps any listed port — rejects ranges the stack tool can lease from by skipping the listed ports.
