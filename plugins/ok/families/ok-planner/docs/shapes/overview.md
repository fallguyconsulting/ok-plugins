# Shape template: overview

An overview tells a reader what something is and how its parts fit, so they know where to go next. It explains, and leaves the detail to reference documentation and guides.

When planning declares a docspec, it copies the layout below into the docspec's `## Where`, after the path, and the shape below into its `## Shape`. The owner adjusts both. The docspec never names this template.

## Layout

```
One file for the whole product, or one file per subsystem, named for
the subsystem.
```

## Shape

```
Each file holds these parts, in this order:

1. What it is: one paragraph, leading with what it does for the reader.
2. Its parts: one short section per part, saying what the part does.
3. How they fit: how a request or a piece of data moves through the
   parts.
4. Where to go next: the reference documentation and guides that carry
   the detail.
```
