#!/usr/bin/env node

// SPDX-License-Identifier: Apache-2.0
// Materialized by ok-plumbline v18.6.1 — plugin-owned, overwritten wholesale on converge by the front door's administration (/ok); do not hand-edit.
let fs, path, os;
try {
  fs = require('fs');
  path = require('path');
  os = require('os');
} catch (err) {
  process.exit(0);
}

const STANDARD_REL = ['.ok-plumbline', 'docs', 'technical-writing.md'];
const MARKER_PREFIX = 'ok-plumbline-tool-start-';

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

function standard(root) {
  let text;
  try {
    text = fs.readFileSync(path.join(root, ...STANDARD_REL), 'utf8');
  } catch (err) {
    return null;
  }
  const body = text.split('\n').filter((line) => !line.startsWith('# ')).join('\n').trim();
  return body === '' ? null : body;
}

function markerPath(event) {
  const key = String(event.tool_use_id || event.session_id || 'anonymous').replace(/[^A-Za-z0-9._-]/g, '_');
  return path.join(os.tmpdir(), MARKER_PREFIX + key);
}

function stampToolStart(event) {
  try {
    fs.writeFileSync(markerPath(event), String(Date.now()));
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

  if (event.tool_name === 'Bash') stampToolStart(event);

  const rule = standard(root);
  if (rule === null) process.exit(0);

  process.stdout.write(JSON.stringify({
    hookSpecificOutput: {
      hookEventName: 'PreToolUse',
      permissionDecision: 'allow',
      additionalContext:
        `The project's writing standard (.ok-plumbline/docs/technical-writing.md) governs every sentence you write — files, commit messages, replies. Before you stop, a hook has you review the prose you wrote this turn against it:\n${rule}`,
    },
  }));
  process.exit(0);
}

main();
