#!/usr/bin/env node

// SPDX-License-Identifier: Apache-2.0
// Materialized by ok-plumbline v19.3.0 — plugin-owned, overwritten wholesale on converge by the front door's administration (/ok); do not hand-edit.
let fs, path, os, spawnSync;
try {
  fs = require('fs');
  path = require('path');
  os = require('os');
  ({ spawnSync } = require('child_process'));
} catch (err) {
  process.exit(0);
}

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
const PROSE_FLAG_PREFIX = 'ok-plumbline-prose-written-';
const MAX_FILE_BYTES = 1048576;
const MIN_LINE_WORDS = 6;
const MIN_WORDY_RATIO = 0.8;
const PROSE_WHEN_LINE_WORDS = 12;
const PROSE_WHEN_TOTAL_WORDS = 20;

const BLOCKING_EXIT_CODE = 2;
const AGENT_VISIBLE_CHANNEL = process.stderr;

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

function isInsideRoot(root, target) {
  return target === root || target.startsWith(root + path.sep);
}

function getChangedLineRanges(repoRoot, file) {
  const tracked = spawnSync('git', ['-C', repoRoot, 'ls-files', '--error-unmatch', file], { stdio: 'ignore' });
  if (tracked.status !== 0) return null;
  const diff = spawnSync('git', ['-C', repoRoot, 'diff', '-U0', 'HEAD', '--', file], { encoding: 'utf8' });
  if (diff.status !== 0) return null;
  const ranges = [];
  for (const line of diff.stdout.split('\n')) {
    const m = line.match(/^@@ -\d+(?:,\d+)? \+(\d+)(?:,(\d+))? @@/);
    if (!m) continue;
    const start = parseInt(m[1], 10);
    const count = m[2] !== undefined ? parseInt(m[2], 10) : 1;
    if (count === 0) continue;
    ranges.push([start, start + count - 1]);
  }
  return ranges;
}

function formatRanges(ranges) {
  return ranges.map(([a, b]) => (a === b ? `${a}` : `${a}-${b}`)).join(',');
}

function lintStage(root, event) {
  const file = event.tool_input && event.tool_input.file_path;
  if (!file || !fs.existsSync(file)) return null;
  const target = path.resolve(file);
  if (!isInsideRoot(root, target)) return null;
  const binary = path.resolve(__dirname, '..', 'bin', 'plumbline');
  if (!fs.existsSync(binary)) return null;

  const args = [binary];
  const ranges = getChangedLineRanges(root, target);
  if (ranges !== null) {
    if (ranges.length === 0) return null;
    args.push('--lines', formatRanges(ranges));
  }
  args.push(target);

  const result = spawnSync('node', args, { encoding: 'utf8' });
  if (result.error) return null;
  if (result.status !== BLOCKING_EXIT_CODE) return null;
  return (result.stdout || '') + (result.stderr || '');
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

function agentKey(event) {
  return String(event.agent_id || event.session_id || 'anonymous').replace(/[^A-Za-z0-9._-]/g, '_');
}

function proseFlagPath(event) {
  return path.join(os.tmpdir(), PROSE_FLAG_PREFIX + agentKey(event));
}

function writtenSources(root, event) {
  const input = event.tool_input || {};
  const file = input.file_path ? path.resolve(String(input.file_path)) : null;
  const inRoot = file !== null && isInsideRoot(root, file);
  switch (event.tool_name) {
    case 'Write':
      return inRoot ? [{ label: file, text: String(input.content || '') }] : [];
    case 'Edit':
      return inRoot ? [{ label: file, text: String(input.new_string || '') }] : [];
    case 'MultiEdit':
      return inRoot ? [{ label: file, text: (input.edits || []).map((e) => String(e.new_string || '')).join('\n') }] : [];
    case 'NotebookEdit':
      return inRoot ? [{ label: file, text: String(input.new_source || '') }] : [];
    default:
      return [];
  }
}

function proseStage(root, event) {
  const written = writtenSources(root, event).filter((s) => s.text && isProse(proseLines(s.text)));
  if (written.length === 0) return;
  const lines = written.map((s) => `${event.tool_name}\t${s.label}\n`).join('');
  try {
    fs.appendFileSync(proseFlagPath(event), lines);
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

  proseStage(root, event);

  const lint = lintStage(root, event);
  if (lint === null) process.exit(0);
  AGENT_VISIBLE_CHANNEL.write(lint);
  process.exit(BLOCKING_EXIT_CODE);
}

main();
