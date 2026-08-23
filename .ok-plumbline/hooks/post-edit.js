#!/usr/bin/env node

// SPDX-License-Identifier: Apache-2.0
// Materialized by ok-plumbline v19.0.0 — plugin-owned, overwritten wholesale on converge by the front door's administration (/ok); do not hand-edit.
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
const MARKER_PREFIX = 'ok-plumbline-tool-start-';
const PROSE_FLAG_PREFIX = 'ok-plumbline-prose-written-';
const MAX_FILE_BYTES = 1048576;
const MAX_CHANGED_FILES = 40;
const MIN_LINE_WORDS = 6;
const MIN_WORDY_RATIO = 0.8;
const PROSE_WHEN_LINE_WORDS = 12;
const PROSE_WHEN_TOTAL_WORDS = 20;

const BLOCKING_EXIT_CODE = 2;
const AGENT_VISIBLE_CHANNEL = process.stderr;
const PROSE_REVIEWED_MARKER = 'plumbline:prose-reviewed';
const STANDARD_REL = ['.ok-plumbline', 'docs', 'technical-writing.md'];
const MAX_SOURCES_LISTED = 30;

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

function markerPath(event) {
  const key = String(event.tool_use_id || event.session_id || 'anonymous').replace(/[^A-Za-z0-9._-]/g, '_');
  return path.join(os.tmpdir(), MARKER_PREFIX + key);
}

function agentKey(event) {
  return String(event.agent_id || event.session_id || 'anonymous').replace(/[^A-Za-z0-9._-]/g, '_');
}

function proseFlagPath(event) {
  return path.join(os.tmpdir(), PROSE_FLAG_PREFIX + agentKey(event));
}

function toolStart(event) {
  const p = markerPath(event);
  try {
    const t = parseInt(fs.readFileSync(p, 'utf8'), 10);
    fs.unlinkSync(p);
    return Number.isFinite(t) ? t : null;
  } catch (err) {
    return null;
  }
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
  const ls = spawnSync('git', ['-C', root, 'ls-files', '-m', '-o', '--exclude-standard', '-z'], { encoding: 'utf8' });
  if (ls.status !== 0) return [];
  const out = [];
  for (const rel of ls.stdout.split('\0')) {
    if (!rel) continue;
    const abs = path.join(root, rel);
    let st;
    try {
      st = fs.statSync(abs);
    } catch (err) {
      continue;
    }
    if (!st.isFile() || st.mtimeMs < since) continue;
    if (!isTextFile(abs)) continue;
    out.push(abs);
    if (out.length >= MAX_CHANGED_FILES) break;
  }
  return out;
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
    case 'Bash': {
      // @decision: steering-over-prose-lint
      const since = toolStart(event);
      if (since === null) return [];
      return filesChangedSince(root, since).map((changed) => ({ label: changed, text: addedLinesSinceHead(root, changed) }));
    }
    default:
      return [];
  }
}

function isProseReviewedMarker(event) {
  if (event.tool_name !== 'Bash') return false;
  const command = String((event.tool_input || {}).command || '');
  return command.includes(PROSE_REVIEWED_MARKER);
}

function clearProseFlag(event) {
  try {
    fs.unlinkSync(proseFlagPath(event));
  } catch (err) {
    return;
  }
}

function proseStage(root, event) {
  if (isProseReviewedMarker(event)) {
    clearProseFlag(event);
    return;
  }
  const written = writtenSources(root, event).filter((s) => s.text && isProse(proseLines(s.text)));
  if (written.length === 0) return;
  const lines = written.map((s) => `${event.tool_name}\t${s.label}\n`).join('');
  try {
    fs.appendFileSync(proseFlagPath(event), lines);
  } catch (err) {
    return;
  }
}

function standardPresent(root) {
  try {
    return fs.statSync(path.join(root, ...STANDARD_REL)).size > 0;
  } catch (err) {
    return false;
  }
}

function flaggedSources(root, event) {
  let body;
  try {
    body = fs.readFileSync(proseFlagPath(event), 'utf8');
  } catch (err) {
    return [];
  }
  const seen = new Set();
  const out = [];
  for (const line of body.split('\n')) {
    if (!line.trim()) continue;
    const [tool, label] = line.split('\t');
    if (!label) continue;
    const shown = label.startsWith(root + path.sep) ? path.relative(root, label) : label;
    const key = `${tool} ${shown}`;
    if (seen.has(key)) continue;
    seen.add(key);
    out.push(key);
  }
  return out;
}

function pendingReviewReminder(root, event) {
  if (!standardPresent(root)) return null;
  const sources = flaggedSources(root, event);
  if (sources.length === 0) return null;
  const listed = sources.slice(0, MAX_SOURCES_LISTED).join('; ');
  const more = sources.length > MAX_SOURCES_LISTED ? `; and ${sources.length - MAX_SOURCES_LISTED} more` : '';
  return [
    `plumbline/prose: this turn has written prose awaiting review in: ${listed}${more}.`,
    'Keep working; do not review now. When your work is done — after your last edit and before your final message — review every sentence you wrote in these files against the writing standard (.ok-plumbline/docs/technical-writing.md), rewrite what fails, then run `echo ' + PROSE_REVIEWED_MARKER + '` to clear this list.',
    'A list still standing when you stop brings the review back as a Stop-hook instruction.',
  ].join(' ');
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
  if (lint !== null) {
    AGENT_VISIBLE_CHANNEL.write(lint);
    process.exit(BLOCKING_EXIT_CODE);
  }

  const reminder = pendingReviewReminder(root, event);
  if (reminder === null) process.exit(0);
  process.stdout.write(JSON.stringify({
    hookSpecificOutput: { hookEventName: 'PostToolUse', additionalContext: reminder },
  }) + '\n');
  process.exit(0);
}

main();
