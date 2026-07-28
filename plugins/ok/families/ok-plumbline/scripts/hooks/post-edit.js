#!/usr/bin/env node

// SPDX-License-Identifier: Apache-2.0
// Materialized by ok-plumbline v{{OK_PLUMBLINE_VERSION}} — plugin-owned, overwritten wholesale on converge by the front door's administration (/ok); do not hand-edit.

// @story: edit-time-lint-enforcement
let fs, path, spawnSync;
try {
  fs = require('fs');
  path = require('path');
  ({ spawnSync } = require('child_process'));
} catch (err) {
  process.exit(0);
}

function resolveProjectRoot() {
  const start = path.resolve(process.env.CLAUDE_PROJECT_DIR || process.cwd());
  let dir = start;
  while (dir !== path.dirname(dir)) {
    if (fs.existsSync(path.join(dir, '.git'))) return { root: dir, inRepo: true };
    dir = path.dirname(dir);
  }
  return { root: start, inRepo: false };
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

const BLOCKING_EXIT_CODE = 2;
const AGENT_VISIBLE_CHANNEL = process.stderr;

// @story: edit-time-lint-enforcement
function blockWithViolationsOnAgentVisibleChannel(result) {
  if (result.stdout) AGENT_VISIBLE_CHANNEL.write(result.stdout);
  if (result.stderr) AGENT_VISIBLE_CHANNEL.write(result.stderr);
  process.exit(BLOCKING_EXIT_CODE);
}

function main() {
  let event;
  try {
    event = JSON.parse(fs.readFileSync(0, 'utf8'));
  } catch (err) {
    process.exit(0);
  }

  const file = event && event.tool_input && event.tool_input.file_path;
  if (!file || !fs.existsSync(file)) process.exit(0);

  const { root, inRepo } = resolveProjectRoot();
  if (!inRepo) process.exit(0);

  const target = path.resolve(file);
  if (!isInsideRoot(root, target)) process.exit(0);

  const binary = path.resolve(__dirname, '..', 'bin', 'plumbline');
  if (!fs.existsSync(binary)) process.exit(0);

  const args = [binary];
  const ranges = getChangedLineRanges(root, target);
  if (ranges !== null) {
    if (ranges.length === 0) process.exit(0);
    args.push('--lines', formatRanges(ranges));
  }
  args.push(target);

  const result = spawnSync('node', args, { encoding: 'utf8' });
  if (result.error) process.exit(0);
  if (result.status === BLOCKING_EXIT_CODE) blockWithViolationsOnAgentVisibleChannel(result);
  process.exit(0);
}

main();
