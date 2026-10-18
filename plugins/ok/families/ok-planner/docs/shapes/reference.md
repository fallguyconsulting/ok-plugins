# Shape template: reference

Reference documentation lists every public element of the classes a docspec's `## Lists` names, one entry per element, so a reader can look up one element and find all of it in one place. Every class the surface intent makes public has a reference docspec.

When planning declares a docspec, it copies the layout below into the docspec's `## Where`, after the path, and the shape below into its `## Shape`. The owner adjusts both. The docspec never names this template.

## Layout

```
One file per class the docspec lists, named for the class. Within a
file, one entry per public element, in the order its declaring file
declares them.
```

## Shape

```
Each file opens with one paragraph: what the class is, and how a reader
reaches its elements. Then one entry per public element, each under a
heading that names the element exactly as a reader types it. Each entry
holds these parts, in this order:

1. What it does: one or two sentences, leading with the result.
2. Inputs: each argument, flag, field, or parameter, with its type,
   whether it is required, and its default.
3. Outputs: what it returns, prints, or writes, and in what format.
4. Errors: each refusal or failure a reader can meet, and what to do
   about it.
5. Example: one call and the output it gives.
```

## In code

For documentation that lives in code, the docspec's `## Where` reads `in code:` followed by the files that declare the listed classes. Its `## Shape` gives the same five parts, written as the doc comment on each public element, in the comment form the language's tool reads. Its `## Generator` names that tool, where its output goes, and whether the output is committed.
