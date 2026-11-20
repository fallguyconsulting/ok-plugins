---
decision: drive-writes-only-in-scratch
---

# A driver writes only in a scratch folder outside the checkout

## Choice

A driver changes nothing git tracks in the project's tree. A command that may
write runs against a scratch copy of the project or a scratch project,
never at the project root. Every file a driver keeps, its scratch
copy, its scratch project, and each command's saved output among them,
sits in the scratch folder the drive names for the driver's drive
name, under the system temp directory and outside the checkout. A
file may sit instead in the instance folder the drive names for an
instance story, or in the run folder a review-facts command makes for
that drive name, each outside the checkout. The
one write a driver's commands make in the tree is one the review facts
name for starting and stopping a stack, an instance, or a resource,
into a folder git ignores.

## Rationale

A driver that writes at the project root rewrites the tree the run
certifies; a scratch copy gives it the same product to use with
nothing of the run's at stake. A file a driver leaves in the checkout,
such as a command's output saved with a shell redirect, is listed as
part of the change, so certification reviews scratch output as product
code. A folder outside the checkout keeps every such file out of the
change, and one folder per drive name keeps two drivers' files apart.
An instance folder and a review-facts run folder sit outside the
checkout too, so a file kept there stays out of the change as well. A
command the review facts name for a stack, an instance, or a resource
writes in the tree only into a folder git ignores, since any other
write would land in the change certification reviews.

## Alternatives

- Drivers run their commands at the project root — no copy to make, and
  a writing command rewrites the tree the run certifies.
- The change listing leaves out each untracked file a drive created —
  the listing must then tell a driver's file from a file the sprint
  added.
