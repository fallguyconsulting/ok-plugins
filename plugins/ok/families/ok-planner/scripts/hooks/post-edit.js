#!/usr/bin/env node

// SPDX-License-Identifier: Apache-2.0
// Materialized by ok-planner v{{OK_PLANNER_VERSION}} — plugin-owned, overwritten wholesale on converge by the front door's administration (/ok); do not hand-edit.
let fs, path, spawnSync;
try {
  fs = require('fs');
  path = require('path');
  ({ spawnSync } = require('child_process'));
} catch (err) {
  process.exit(0);
}

const CLEAN_EXIT_CODE = 0;
const BLOCKING_EXIT_CODE = 2;
const INTERNAL_ERROR_EXIT_CODE = 1;
const AGENT_VISIBLE_CHANNEL = process.stderr;

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

function lintStage(binary, event) {
  const file = event.tool_input && event.tool_input.file_path;
  if (!file || !fs.existsSync(file)) return null;
  const target = path.resolve(file);
  const { findProjectRoot, inProject } = require(binary);
  const root = findProjectRoot(process.env.CLAUDE_PROJECT_DIR || process.cwd());
  if (!inProject(root, target)) return null;

  const args = [binary];
  const ranges = getChangedLineRanges(root, target);
  if (ranges !== null) {
    if (ranges.length === 0) return null;
    args.push('--lines', formatRanges(ranges));
  }
  args.push(target);

  const result = spawnSync('node', args, { encoding: 'utf8' });
  if (result.error) return null;
  if (result.status === CLEAN_EXIT_CODE) return null;
  const output = (result.stdout || '') + (result.stderr || '');
  const exitCode = result.status === BLOCKING_EXIT_CODE ? BLOCKING_EXIT_CODE : INTERNAL_ERROR_EXIT_CODE;
  return { output, exitCode };
}

function main() {
  let event;
  try {
    event = JSON.parse(fs.readFileSync(0, 'utf8'));
  } catch (err) {
    process.exit(0);
  }
  if (!event || typeof event !== 'object') process.exit(0);

  const binary = path.resolve(__dirname, '..', 'bin', 'plumbline');
  if (!fs.existsSync(binary)) process.exit(0);
  const lint = lintStage(binary, event);
  if (lint === null) process.exit(0);
  AGENT_VISIBLE_CHANNEL.write(lint.output);
  process.exit(lint.exitCode);
}

main();
