---
decision: instance-drives-serial-on-a-project-mark
---

# A project can make its instance-story drives run one at a time after the other drivers

## Choice

A project's review facts can mark that its stories that drive on an
instance of their own drive one at a time. With the mark, `/converge`
files each such drive after every other driver, the stories that drive
alone included, and chains each one after the one before, so at most
one instance runs beside the shared stack. The confirm drivers follow
the same order. Without the mark, instance drives run beside the
shared-stack drivers.

## Rationale

An instance is a full stack of its own, and a host that fits the
shared stack and one instance may not fit more. On an overloaded host
a drive times out, and its story goes unproven on every run there. The
review facts already carry the drive's one ordering fact, the list of
stories that drive alone, so a mark beside the instance list keeps
drive ordering in one place and in one form. A project whose hosts
have room to spare keeps its parallelism by leaving the mark off. The
cost: the right limit can depend on the machine more than on the
project, and one checkout cannot set the mark per machine.

## Alternatives

- Always drive instance stories one at a time — every project loses parallelism, even on hosts with room to spare.
- A number of instance drives at once, in the review configuration — a new key with a seed default and true-up handling that no project has asked for.
- A per-project concurrency cap for the drive — slows the shared-stack drivers too, and still lets instances overlap.
- Leave the order as it is — on a host that cannot fit three stacks, the instance stories are never proven.
