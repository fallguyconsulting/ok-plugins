---
name: dashboard
description: "ONLY activated by explicit /dashboard slash command. Never auto-triggered by conversation content. Starts the project's issue dashboard, the local service at .ok-planner/bin/dashboard, as a process detached from this session, opens the page in the owner's browser, reports the page's address, and stops the service when the owner asks."
---

# Dashboard

Start the issue dashboard's service as a process detached from this session, open the page in the owner's default browser, give the owner the page's address, and stop the service when the owner says to. The service is the program at `.ok-planner/bin/dashboard`. It serves the page over loopback and reads and writes the intake through `.ok-planner/bin/issues`. The owner can also run it from a terminal with `python3 .ok-planner/bin/dashboard`; this skill runs the same program. A detached service holds no background task of the session open, so a `/goal` check runs while the dashboard serves.

This skill edits no file in the project, starts no other skill, and runs no command but the five below: the liveness check (`kill -0`), the start, the reopen (`python3 -m webbrowser -t`), the stop (`kill`), and the removal of the log folder (`rm -rf`).

## Procedure

### 1. Find the service

Check that `.ok-planner/bin/dashboard` exists at the project root. Where it is missing, tell the owner: "This project has no dashboard service at `.ok-planner/bin/dashboard`. Run `/ok` to true up the project; it installs the service and places the page." Then stop.

Where this session already started the dashboard and has not stopped it, check that its process still runs with `kill -0 <pid>`, using the pid from its `serving` line.

- Where the check succeeds, open its address again with `python3 -m webbrowser -t <address>`, report the address, the pid, and the log file from step 2 again, and stop. Never start a second copy.
- Where `kill` reports no such process, the service has exited. Remove its log folder with `rm -rf <log folder>`, report no address for it, and go on to step 2.

### 2. Start the service

From the project root, run this as one Bash call in the foreground, without `run_in_background`:

```bash
d="$(mktemp -d)"; nohup python3 .ok-planner/bin/dashboard --open > "$d/dashboard.log" 2>&1 < /dev/null & pid=$!; for i in $(seq 1 100); do grep -q '^dashboard: serving ' "$d/dashboard.log" && break; kill -0 "$pid" 2>/dev/null || break; sleep 0.1; done; echo "log: $d/dashboard.log"; echo "pid: $pid"; cat "$d/dashboard.log"
```

`nohup`, the redirections, and the trailing `&` detach the service from the session: its output goes to the log file in a folder `mktemp -d` makes outside the project, and the call returns once the service is listening. `--open` makes the service open the page in the default browser once it is listening. Where the owner named a port, add `--port <port>` after `--open`; otherwise give no port, and the operating system assigns one. The loop waits up to ten seconds for the `serving` line, or for the process to exit.

Read the log the call prints. Keep the log file's path and its folder. Then one of three things holds:

- A line of the form `dashboard: serving http://127.0.0.1:<port>/ (pid <pid>)` appears. Keep the address and the pid.
- No `serving` line appears and the process exited. Report the log to the owner verbatim, for example `dashboard: port 8080 is in use; omit --port to let the OS assign one`, remove the log folder with `rm -rf <log folder>`, and stop.
- No `serving` line appears and the process still runs after the ten seconds. Report the log verbatim, the pid the call printed, and the log file's path, and tell the owner that saying "stop the dashboard" stops it. Then stop.

### 3. Report

Tell the owner:

- the page's address, from the `serving` line;
- that the page opened in the browser, or, where the service printed `dashboard: found no browser to open`, that line verbatim;
- every other `dashboard:` line the service printed before it, verbatim — these name a version that disagrees with the project's pin, or a missing page build, and each says to run `/ok`;
- the pid, the log file's path, and that saying "stop the dashboard" stops it;
- that the service keeps running after this session ends, until the owner stops it here or runs `kill <pid>` from a terminal.

The service keeps running while the owner works. Do not stop it on your own initiative.

### 4. Stop on the owner's word

When the owner asks to stop the dashboard, run `kill <pid>; rm -rf <log folder>` with the pid from the `serving` line and the log folder from step 2. The service closes and writes `dashboard: stopped` to its log, and the command removes the log folder. Tell the owner the dashboard stopped. Where `kill` reports no such process, tell the owner the service had already exited.

<!-- Materialized by ok-planner v27.0.0 — suite-owned; overwritten on true-up; do not hand-edit. -->
