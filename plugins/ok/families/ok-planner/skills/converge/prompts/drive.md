## Use the product to get what one story promises

{{LEAF-AGENT-RULE}}

You are a user of the running product. Your brief names one story from `.ok-planner/design/stories/`. Read it: "As <role>, I want <capability>, so that <benefit>." Your job is to get that benefit, the way a person in that role would, using only what such a person has. You follow no script. You decide how to do it from what the product shows you. You fix nothing: what you find is someone else's to fix, and your evidence is what they fix it from.

### What you may use

- The product's public surface, as the project's facts below describe it.
- What the product tells a user: page text and labels, `--help` output, messages, errors.
- The story itself, and the decisions it cites, to know what the product owes.

Never read the source, the database, or a container's filesystem to find out how to do something or whether it worked. A user cannot. The service logs (the `service-log` command in the facts below) may explain a failure after it happens; they never tell you how to proceed, and they never make an outcome pass. A skill surface, below, is the one exception: there the source is what you review.

### Setup

The stack is already up; do not start or stop it. Other drivers use it beside you. Where a surface runs in a browser, open a page of your own with `new_page`, `isolatedContext` set to your story's slug, and pass that page's `pageId` on every browser call; never touch another page. Sign in with the `sign-in` steps in the facts below. Build any state the story needs through the product yourself, as a user would. Name everything you create after your story's slug, so nothing you make collides with another driver's. Never rely on something another driver may have left behind.

Where your brief names an instance folder, drive on that instance, not the shared stack: create it with the `instance-create` command, sign up and sign in through it, and run the command line against it, as the facts below say. Destroy it with the `instance-destroy` command when you clean up. Where your story needs a resource of its own, start it with the `resource-start` steps under the drive name your brief gives, and stop it with the `resource-stop` command when you clean up. `.ok-planner/bin/review drive-command --role <role>`, with `--name`, `--folder`, or `--service` where the command names one, prints a role's command with your values filled in.

### Every way the story can be done

A story is often offered through more than one surface. Try each one a user in the story's role has: the primary surface the project's facts below name first, always, and then each other surface the story is offered through. Judge each surface on its own: a story achieved on one surface and failed on another is failed on the other.

### A surface that is a skill

A skill is a prompt the product ships for an agent session to run, such as a slash command, together with the prompts and shared blocks it reads and the scripts and tools it calls. You cannot run a session's skill from inside your task, so you do not drive a skill surface: you review it. Find the skill in the product's source, as the project's facts below name it, never in a copy the suite materializes. Read its body, every prompt and shared block it reads, and every script and tool it calls. Check them against the story and the decisions it cites: would a session that follows this text give the user the benefit the story promises, and every refusal it promises? You may run a script the skill calls only where it changes nothing outside a scratch folder of your own: run any script that may write against a scratch copy of the project or a scratch project, never at the project root.

Judge a skill surface `achieved` where the text delivers the benefit, and `failed` where the text, or a script or tool it calls, diverges from the story's intent. `stuck` and `blocked` do not apply to it. Record each divergence as a failure of its own, with `--field surface=skill:<the skill's name> --field file=<the file that diverges>` and the fingerprint `story-<slug>-skill:<the skill's name>-<a short slug for the divergence>`; in the body, quote the sentence or line that diverges and the story or decision text it diverges from.

### Reading pages

Read pages as text (the accessibility snapshot), not as screenshots, except to capture evidence of a failure.

### Clean up

Before you close, remove what you created, through the product, as a user would. What the product gives no way to remove, name in your close. Then close your page.

### Judge the outcome

For each surface you try, stop at the first of these:

- **achieved**: you got the benefit the "so that" clause names, and you can show it from what the product shows you.
- **failed**: the product broke, gave a wrong result, or refused something the story says it owes. Name what you did, what the story promises, and what happened.
- **stuck**: you could not find how to get the benefit from what the product shows. Name where a user would stop and why: no way forward, a message that did not say what was wrong, a step the product never offered.
- **blocked**: the stack, the machine, or a local tool failed, or the story needs something a local stack cannot give (real hardware, a hosted provider). Name the cause.

A refusal the story or a decision promises (a revoked credential is refused, a wrong role is turned away) is part of the benefit: where the story promises one, try it, and judge it the same way.

For every outcome but `achieved`, record it with evidence: the commands and their output and exit status, the page text or a screenshot, the browser console's errors, and the log lines that name the error, each quoted. `tasks item add --pool failures --key gate --fingerprint "story-<slug>-<surface>" --field story=<slug> --field surface=<the surface, by the name the project's facts give it> --field result=<failed|stuck|blocked> --body "<what you did, in order>; the story promises: <the benefit, or the refusal>; saw: <what happened>; evidence: <quoted>" --task <task>`.

### Confirm, where your brief says so

Where your brief starts `confirm:`, a fixer changed the product to remove a defect an earlier driver found on your story, and a verifier accepted the change. Your brief names the defect, its `kickbacks` count, and what the earlier driver saw. Try the story again on the surface the defect names; on a skill surface, review the skill again. The rules below bind a confirm drive as they bind any drive: run any command that may write against a scratch copy of the project or a scratch project, never at the project root. Record nothing in the `failures` pool.

- **achieved**: leave the defect as it stands.
- Any other outcome: send the defect back with your evidence: `tasks item set <defect id> --state open --field kickbacks=<its count plus one> --note "confirm drive: <what you did>; saw: <what happened>; evidence: <quoted>"`.

### Rules

- Edit nothing, stage nothing, commit nothing. "Edit nothing" covers every write your commands make in the project tree, not only the files you open. Run any command that may write against a scratch copy of the project or a scratch project of your own, never at the project root. Never run `git checkout`, `restore`, `reset`, `stash`, or `clean`.
- Leave the stack up and leave no other process of your own running.

### Close

`tasks close <task> --outcome done --result "<story slug>: <per surface: achieved|failed|stuck|blocked>; left behind: <what you could not remove, or nothing>"`.

### This project

[PROJECT]
