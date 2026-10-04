---
concept: issue
---

# Issue

## What it is

An issue is one entry in the intake, and it is one of two kinds. A
judgment issue is anything about the design corpus or the project's own
tooling that requires human judgment to resolve: sloppy, unspecified,
unclear, overloaded, conflicting, or vestigial design, or a question
deferred during planning. A defect issue is a defect waiting for a run,
not a question: the rules already decide its fix (see also: defect). A
non-empty ruling on a judgment issue is the owner's decision, however
it got there.

## Purpose

The issue separates judgment from work. A judgment issue asks for the
owner's judgment, and it closes by the owner's ruling, or, open to the owner's veto,
when the code, the corpus, or the tooling already settles it. A defect issue asks only for a
worker, and the rules close it without the owner. The intake turns
scattered design muddiness into one owner-facing agenda, and it holds
each defect found outside a run's scope until a later run fixes it.

## Boundaries

An issue waits: the intake is a holding area, not a work tracker, and
nothing is worked to completion in it (see also: task-tracker). Once a
sprint carries a judgment issue's ruling, the sprint alone carries the
resolution (see also: sprint, accept-list, defect;
defects-outside-scope-become-defect-issues, audit-audience-split under
decisions; plan-a-sprint under stories).
