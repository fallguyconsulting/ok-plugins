#!/usr/bin/env node

// SPDX-License-Identifier: Apache-2.0
// Materialized by ok-plumbline v19.3.0 — plugin-owned, overwritten wholesale on converge by the front door's administration (/ok); do not hand-edit.
let fs, path, os, spawnSync;
try {
  fs = require('fs');
  path = require('path');
  os = require('os');
  spawnSync = require('child_process').spawnSync;
} catch (err) {
  process.exit(0);
}

const STANDARD_REL = ['.ok-plumbline', 'docs', 'technical-writing.md'];
const PROSE_FLAG_PREFIX = 'ok-plumbline-prose-written-';
const TURN_STAMP_PREFIX = 'ok-plumbline-turn-start-';
const MAX_FILE_BYTES = 1048576;
const MAX_CHANGED_FILES = 40;
const MIN_LINE_WORDS = 6;
const MIN_WORDY_RATIO = 0.8;
const PROSE_WHEN_LINE_WORDS = 12;
const PROSE_WHEN_TOTAL_WORDS = 20;
const WALK_SKIP = new Set(['.git', 'node_modules', '.ok-workspaces']);
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

function turnStampPath(event) {
  return path.join(os.tmpdir(), TURN_STAMP_PREFIX + agentKey(event));
}

function takeTurnStart(event) {
  const p = turnStampPath(event);
  try {
    const t = parseInt(fs.readFileSync(p, 'utf8'), 10);
    fs.unlinkSync(p);
    return Number.isFinite(t) ? t : null;
  } catch (err) {
    return null;
  }
}

const LEADER = /^(?:#{1,6}\s+|[-*+]\s+|\d+[.)]\s+|>\s*|\/\/+\s*|#+\s*|\/\*+\s*|\*+\s*|<!--\s*|--\s*|;+\s*|"""\s*|'''\s*)+/;
const WORDY = /^["“(‘']?[A-Za-z][A-Za-z'’\-]*[.,;:!?)"”’']*$/;

function proseLines(text) {
  const out = [];
  let inFence = false;
  for (const raw of String(text).split('\n')) {
    const t = raw.trim();
    if (t.startsWith('```') || t.startsWith('~~~')) {
      inFence = !inFence;
      continue;
    }
    if (inFence || t === '' || t.startsWith('|')) continue;
    const s = t.replace(LEADER, '');
    const tokens = s.split(/\s+/).filter(Boolean);
    if (tokens.length < MIN_LINE_WORDS) continue;
    const wordy = tokens.filter((tok) => WORDY.test(tok)).length;
    if (wordy / tokens.length < MIN_WORDY_RATIO) continue;
    out.push({ text: s, words: tokens.length });
  }
  return out;
}

function isProse(lines) {
  if (lines.length === 0) return false;
  const total = lines.reduce((n, l) => n + l.words, 0);
  return total >= PROSE_WHEN_TOTAL_WORDS || lines.some((l) => l.words >= PROSE_WHEN_LINE_WORDS);
}

function isTextFile(file) {
  try {
    const st = fs.statSync(file);
    if (!st.isFile() || st.size > MAX_FILE_BYTES) return false;
    const fd = fs.openSync(file, 'r');
    const buf = Buffer.alloc(Math.min(8192, st.size));
    fs.readSync(fd, buf, 0, buf.length, 0);
    fs.closeSync(fd);
    return !buf.includes(0);
  } catch (err) {
    return false;
  }
}

function addedLinesSinceHead(root, file) {
  const tracked = spawnSync('git', ['-C', root, 'ls-files', '--error-unmatch', file], { stdio: 'ignore' });
  if (tracked.status !== 0) {
    try {
      return fs.readFileSync(file, 'utf8');
    } catch (err) {
      return '';
    }
  }
  const diff = spawnSync('git', ['-C', root, 'diff', '-U0', 'HEAD', '--', file], { encoding: 'utf8' });
  if (diff.status !== 0) return '';
  return diff.stdout
    .split('\n')
    .filter((l) => l.startsWith('+') && !l.startsWith('+++'))
    .map((l) => l.slice(1))
    .join('\n');
}

function filesChangedSince(root, since) {
  const out = [];
  const stack = [root];
  while (stack.length > 0 && out.length < MAX_CHANGED_FILES) {
    const dir = stack.pop();
    let entries;
    try {
      entries = fs.readdirSync(dir, { withFileTypes: true });
    } catch (err) {
      continue;
    }
    for (const entry of entries) {
      if (WALK_SKIP.has(entry.name)) continue;
      const abs = path.join(dir, entry.name);
      if (entry.isDirectory()) {
        stack.push(abs);
        continue;
      }
      if (!entry.isFile()) continue;
      let st;
      try {
        st = fs.statSync(abs);
      } catch (err) {
        continue;
      }
      if (st.mtimeMs < since) continue;
      if (!isTextFile(abs)) continue;
      out.push(abs);
      if (out.length >= MAX_CHANGED_FILES) break;
    }
  }
  return out;
}

function recordProseWrittenThisTurn(root, event) {
  const since = takeTurnStart(event);
  if (since === null) return;
  const flagPath = proseFlagPath(event);
  let existing = '';
  try {
    existing = fs.readFileSync(flagPath, 'utf8');
  } catch (err) {
    existing = '';
  }
  const lines = [];
  for (const file of filesChangedSince(root, since)) {
    if (existing.includes('\t' + file + '\n')) continue;
    if (!isProse(proseLines(addedLinesSinceHead(root, file)))) continue;
    lines.push(`Bash\t${file}\n`);
  }
  if (lines.length === 0) return;
  try {
    fs.appendFileSync(flagPath, lines.join(''));
  } catch (err) {
    return;
  }
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
    takeTurnStart(event);
    process.exit(0);
  }
  recordProseWrittenThisTurn(root, event);
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
