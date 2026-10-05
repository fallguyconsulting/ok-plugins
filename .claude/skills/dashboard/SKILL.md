---
name: dashboard
description: "ONLY activated by explicit /dashboard slash command. Never auto-triggered by conversation content. Starts the project's issue dashboard, the local service at .ok-planner/bin/dashboard, in the background of this session, reports the page's address, and stops the service when the owner asks."
---

# Dashboard

Start the issue dashboard's service in the background of this session, give the owner the page's address, and stop the service when the owner says to. The service is the program at `.ok-planner/bin/dashboard`. It serves the page over loopback and reads and writes the intake through `.ok-planner/bin/issues`. The owner can also run it from a terminal with `python3 .ok-planner/bin/dashboard`; this skill runs the same program.

This skill edits no file, starts no other skill, and runs no command but the two below.

## Procedure

### 1. Find the service

Check that `.ok-planner/bin/dashboard` exists at the project root. Where it is missing, tell the owner: "This project has no dashboard service at `.ok-planner/bin/dashboard`. Run `/ok` to converge the project; it installs the service and places the page." Then stop.

Where this session already started the dashboard and has not stopped it, report the address and pid from its `serving` line again and stop. Never start a second copy.

### 2. Start the service

From the project root, run `python3 .ok-planner/bin/dashboard` with the Bash tool's `run_in_background` set. Where the owner named a port, add `--port <port>`; otherwise give no port, and the operating system assigns one.

Read the background command's output until one of two things happens:

- A line of the form `dashboard: serving http://127.0.0.1:<port>/ (pid <pid>)` appears. Keep the address and the pid.
- The command exits. Report its output to the owner verbatim, for example `dashboard: port 8080 is in use; omit --port to let the OS assign one`, and stop.

### 3. Report

Tell the owner:

- the page's address, from the `serving` line;
- every other `dashboard:` line the service printed before it, verbatim — these name a version that disagrees with the project's pin, or a missing page build, and each says to run `/ok`;
- the pid, and that saying "stop the dashboard" stops it.

The service keeps running while the owner works. Do not stop it on your own initiative.

### 4. Stop on the owner's word

When the owner asks to stop the dashboard, run `kill <pid>` with the pid from the `serving` line. The service closes and prints `dashboard: stopped`. Tell the owner the dashboard stopped. Where `kill` reports no such process, tell the owner the service had already exited.

<!-- Materialized by ok-planner v25.0.1 — suite-owned; overwritten on converge; do not hand-edit. -->
