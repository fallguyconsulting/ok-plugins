#!/usr/bin/env node

// SPDX-License-Identifier: Apache-2.0
// Materialized by ok-plumbline v19.3.0 — plugin-owned, overwritten wholesale on converge by the front door's administration (/ok); do not hand-edit.
let fs, path, os;
try {
  fs = require('fs');
  path = require('path');
  os = require('os');
} catch (err) {
  process.exit(0);
}

const TURN_STAMP_PREFIX = 'ok-plumbline-turn-start-';

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

function agentKey(event) {
  return String(event.agent_id || event.session_id || 'anonymous').replace(/[^A-Za-z0-9._-]/g, '_');
}

function turnStampPath(event) {
  return path.join(os.tmpdir(), TURN_STAMP_PREFIX + agentKey(event));
}

function stampTurnStart(event) {
  const p = turnStampPath(event);
  if (fs.existsSync(p)) return;
  try {
    fs.writeFileSync(p, String(Date.now()));
  } catch (err) {
    return;
  }
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

  stampTurnStart(event);
  process.exit(0);
}

main();
