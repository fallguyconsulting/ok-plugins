---
decision: retired-script-repoint-needs-a-proven-root
---

# True-up repoints a retired script reference only behind a prefix it can prove names the project root

## Choice

True-up repoints a line that names a retired suite script's path only
behind a prefix that names the project root with certainty: one of the
fixed root forms, or a prefix true-up proves resolves to the root, such
as git's top-level idiom where the project root is the repository's
top. A line whose prefix may name the project root but that true-up
cannot prove does stays as written: true-up files an intake issue
naming the line and keeps the retired copy, because that line still
names it. A path built at run time is outside what true-up sees, and
true-up's report says so when it removes a retired copy. True-up
searches every tracked file for such lines but a payload copy's own
files: a file below a folder that holds a family's true-up core and
administration document, where the payload running true-up carries a
file at the same path relative to its own root. Every other file below
such a folder is searched like any project file.

## Rationale

Text alone cannot tell whether a prefix such as a shell variable or a
home directory names the project root. Rewriting such a line can point
a line about some other file at the suite's copy, and removing the
copy behind it can break a real caller, so holding the copy and asking
the owner costs only a kept file. A prefix true-up proves names the
root is as certain as a fixed root form, and asking about it adds a
question with one sensible answer. A caller that builds the path at
run time leaves no text to find, so the report names that limit where
a removal could reach one. A payload copy documents the scripts its
release retires, and those lines call nothing. A path the running
payload also carries proves a file belongs to such a copy, and the
proof holds when the working tree moves past the installed release,
which a match on the file's content does not. Its one false positive,
a payload file newer than the installed release, costs a kept copy and
an issue until the next release, the cost this choice already accepts.

## Alternatives

- Repoint every reference whose prefix may name the project root — a line about a home or sibling-repository script is rewritten wrongly, with only a report line as warning.
- Leave an uncertain reference as written and remove the retired copy anyway — a real caller fails at its next run.
- Count only the fixed root forms as certain — files an issue for a prefix true-up could have settled.
- Skip every file below a folder holding the two administration files — a project file there that calls a retired script is never found, and true-up removes the copy it calls.
- Skip only the payload that runs true-up — the suite's own repository gets a standing issue for every retired script its payload copy documents.
- Skip the folders the project's configuration declares as payload copies — a configuration key that one repository uses, and every file in a declared folder goes unsearched.
