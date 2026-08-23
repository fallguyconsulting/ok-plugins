# The second-pass rewrite

An agent cannot edit a message it has not yet written. This note explains why an in-prompt instruction to "draft, reread, and rewrite" fails, and describes a technique that makes the second pass real.

## Why the instruction fails

An agent generates a response once, token by token. When its instructions say "write the draft, then reread it against the rules, then rewrite it", no draft exists at the moment of the reread. The agent holds the rules as a plan while it writes, and a plan is not a pass. Whatever the plan misses, the response misses.

The failure is consistent. Add a rule and the agent checks the rules it holds most firmly and skips the rest. Number the rules and it reports that it walked them all, and the output shows it did not. Each variant asks for a second pass that never mechanically happens.

## Why "write, then cut" still works

One in-prompt rule survives this: write the response once, then cut it at the point where a second topic begins, and hold the rest for the next turn. It works because a cut is not an edit. It asks the agent to stop, not to change text it has already produced. The agent can apply a stopping rule at the moment it matters, while it is still writing: it notices the second topic beginning and ends the message there. Nothing earlier has to change, so no earlier draft has to exist. A rule that asks the agent to alter text already written needs a second pass; a rule that asks it to end sooner needs only the place to end, and that place arrives while the first pass is still under way.

## What makes a second pass real

A second pass needs a first draft that exists as input. The agent gets one by writing the draft to a file through a tool call. The draft is now text the agent can read, and the next generation reads it as input instead of imagining it.

From there, two shapes work:

1. **Self-rewrite.** The agent writes the draft to a file, reads it back, and rewrites it. No other model is involved. Each generation carries the agent's whole conversation history, so the second pass costs a second full read of that history.
2. **Separate rewriter.** The agent writes the draft to a file and hands the file to a script. The script runs a second model with a short system prompt that holds only the writing rules, and returns the rewritten draft. The agent sends the rewritten text as its message.

The separate rewriter is the better default. It reads a few hundred tokens of rules and draft instead of the whole conversation, so it costs a small fraction of the self-rewrite. It can run on a smaller model than the agent. And it reads the text with only the rules in front of it, so nothing else in the conversation competes for its attention. The agent that wrote the draft keeps the priorities that shaped the draft; the rewriter has none.

## Part one: the light version

The light version rewrites the draft alone. It needs one script and one hook.

- **Per-turn reminder.** A hook that fires on every user prompt injects the instruction: write the response once, write it to a scratch file, run the rewriter on the file, send what the rewriter returns. The reminder fires every turn, because an instruction given once at session start loses force as the session grows.
- **The rewriter script.** It reads the draft on stdin, wraps it in markers so the model treats it as text to edit and never as instructions, and calls the model with a system prompt holding the rules and one instruction: keep every fact, number, path, code span, list, and link; change wording and sentence shape only; output the rewritten draft and nothing else. It strips the markers from the output.
- **Model settings.** Run the rewriter with extended thinking off and effort low. Thinking adds seconds and thousands of tokens per call and improves nothing for a rewrite.
- **Silence.** The reminder must also say that the rewrite is the whole of what the agent says: no line before running the command, none between its result and the rewrite, and nothing about the rewriter or its verdicts. Harness instructions that ask for progress updates otherwise produce lines like "The reviewer returned a rewrite. Sending it." in the reply.

Each call costs a few hundred input tokens and a rewrite's worth of output. The rewriter sees the draft and the rules, nothing else. It does not know what the conversation has defined, what the user asked, or what was said two turns ago. Rules that depend on that knowledge stay with the agent in this version: which terms need defining, which question is being answered, where to cut so a message carries one topic.

## Part two: the full version

The full version gives the rewriter the conversation, so it can also judge what the user cannot know. That judgment is the one the agent fails most often: it writes for a reader who has read what it just read, and names items from that material as if they were shared. A reader who holds only the conversation is the right judge of that, and the rewriter is such a reader.

### The kickback

The rewriter's prompt gains one check before the rewrite: list every name, term, label, or reference in the draft that neither the draft nor the conversation defines. A term the conversation already uses passes. When the list is not empty, the rewriter prints a marker word and the list and stops; the agent defines each item in the draft and resubmits, until the rewriter returns a rewrite. The kickback is mechanical, so the agent cannot skip it the way it skips a checklist item.

### Conversation context

Extract the conversation from the session transcript: user prompts and the assistant's text only, skipping tool calls, tool results, and subagent traffic, and collapsing each slash-command expansion to the command's name. This is a small fraction of the transcript: on a session whose transcript was 2 MB, the conversation was 24k tokens.

### The cache

How the conversation reaches the rewriter decides the cost. The API's prompt cache matches a request prefix block by block, so a prefix that only ever grows by appending is served from cache and a prefix whose early blocks change is not.

- A system prompt that carries the whole conversation is one block that changes every turn. Measured: 38k tokens created on every call, at $0.15 to $0.18 each.
- A persistent rewriter session, resumed every turn with only the new turns and the draft, grows by appending. Measured: the first call created 38k tokens; each later call read 38k from cache and created a few hundred, at one to two cents.
- Editing the rewriter's transcript after each turn, to replace the draft and the rewriter's reply with the user's prompt and the agent's final message, defeats the cache again. The client marks the cache at the end of the last message it sent, which is the message carrying the draft; replace it and no cached entry matches. Measured: 22k tokens created every turn. Leave the transcript alone. The draft and the rewriter's reply stay in its history and read from cache at a tenth of the price.
- Any change to the rules text changes the first block and costs one full re-read.

So the shape is: one rewriter session per agent session, created on the first call and resumed on every later one; a fixed system prompt holding only the rules; each message carrying the turns the rewriter has not yet seen, then the draft. The script tracks how many turns it has sent. When the agent's session compacts, the transcript marks the summary, and the script starts a new rewriter session from it.

### Warm start

A command-line model client pays a startup cost before it reads input. The per-prompt hook starts the client in the background the moment the user's prompt arrives, resuming the rewriter session and holding stdin open on a named pipe; the rewriter writes the draft into the pipe, reads the result, and ends the process. Startup overlaps with the agent's own composition. Keep what travels through the pipe small: a message over the pipe's buffer size stalls the client, and a first message carrying a long history goes through a cold call instead.

### Alerts and the ledger

Record each call's cache creation, cache read, output tokens, and cost to a per-session log. A cache miss shows up as a large creation count on the next line; without the log the first sign is the bill. When the script falls back, because a resume failed or the pre-started client returned nothing, it prints a notice line ahead of its output, and the reminder tells the agent to put that line verbatim at the top of its message. The user sees the fallback in the reply.

### What the full version costs

On a 40k-token conversation: one to two cents a turn, a few seconds of latency, and one full read at about $0.15 whenever the rules change, the session compacts, or the cache expires between turns. The client's cache lifetime is one hour.
