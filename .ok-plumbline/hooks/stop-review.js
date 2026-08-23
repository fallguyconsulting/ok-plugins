#!/usr/bin/env node

// SPDX-License-Identifier: Apache-2.0
// Materialized by ok-plumbline v19.1.0 — plugin-owned, overwritten wholesale on converge by the front door's administration (/ok); do not hand-edit.
let fs, path, os;
try {
  fs = require('fs');
  path = require('path');
  os = require('os');
} catch (err) {
  process.exit(0);
}

const STANDARD_REL = ['.ok-plumbline', 'docs', 'technical-writing.md'];
const PROSE_FLAG_PREFIX = 'ok-plumbline-prose-written-';
const HOOK_EVENT_NAMES = new Set(['Stop', 'SubagentStop']);

const ROOT_MARKERS = [
  '.ok-planner',
  '.ok-plumbline',
  '.ok-workspaces',
  '.plumbline.json',
  path.join('.claude', 'rules', 'plumbline-cheatsheet.md'),
];
const PLUMBLINE_MARKERS = [
  '.ok-plumbline',
  '.plumbline.json',
  path.join('.claude', 'rules', 'plumbline-cheatsheet.md'),
];

function resolveProjectRoot() {
  const start = path.resolve(process.env.CLAUDE_PROJECT_DIR || process.cwd());
  let dir = start;
  while (dir !== path.dirname(dir)) {
    if (ROOT_MARKERS.some((m) => fs.existsSync(path.join(dir, m)))) return dir;
    dir = path.dirname(dir);
  }
  return start;
}

function hasPlumblinePresence(root) {
  return PLUMBLINE_MARKERS.some((m) => fs.existsSync(path.join(root, m)));
}

function standardPresent(root) {
  try {
    return fs.statSync(path.join(root, ...STANDARD_REL)).size > 0;
  } catch (err) {
    return false;
  }
}

function agentKey(event) {
  return String(event.agent_id || event.session_id || 'anonymous').replace(/[^A-Za-z0-9._-]/g, '_');
}

function proseFlagPath(event) {
  return path.join(os.tmpdir(), PROSE_FLAG_PREFIX + agentKey(event));
}

function takeFlag(event) {
  const p = proseFlagPath(event);
  let body;
  try {
    body = fs.readFileSync(p, 'utf8');
  } catch (err) {
    return null;
  }
  try {
    fs.unlinkSync(p);
  } catch (err) {
    return body;
  }
  return body;
}

function peekFlag(event) {
  return fs.existsSync(proseFlagPath(event));
}

function main() {
  let event;
  try {
    event = JSON.parse(fs.readFileSync(0, 'utf8'));
  } catch (err) {
    process.exit(0);
  }
  if (!event || typeof event !== 'object') process.exit(0);

  const root = resolveProjectRoot();
  if (!hasPlumblinePresence(root)) process.exit(0);

  if (event.stop_hook_active) {
    takeFlag(event);
    process.exit(0);
  }
  if (!peekFlag(event)) process.exit(0);
  if (!standardPresent(root)) process.exit(0);

  // @decision: steering-over-prose-lint
  const script = path.join(root, '.ok-plumbline', 'hooks', 'stop-instructions.js');
  const instruction = `plumbline: run \`node "${script}" ${agentKey(event)}\` and follow the instructions it returns.`;
  const hookEventName = HOOK_EVENT_NAMES.has(event.hook_event_name) ? event.hook_event_name : 'Stop';
  process.stdout.write(JSON.stringify({
    hookSpecificOutput: { hookEventName, additionalContext: instruction },
  }) + '\n');
  process.exit(0);
}

main();
