#!/usr/bin/env node

// SPDX-License-Identifier: Apache-2.0

const fs = require('fs');
const path = require('path');
const { spawnSync } = require('child_process');

function findRepoRoot(file) {
  let dir = path.dirname(path.resolve(file));
  while (dir !== path.dirname(dir)) {
    if (fs.existsSync(path.join(dir, '.git'))) return dir;
    dir = path.dirname(dir);
  }
  return null;
}

function getChangedLineRanges(file) {
  const repoRoot = findRepoRoot(file);
  if (!repoRoot) return null;
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

function main() {
  let event;
  try {
    event = JSON.parse(fs.readFileSync(0, 'utf8'));
  } catch (err) {
    process.exit(0);
  }

  const file = event && event.tool_input && event.tool_input.file_path;
  if (!file || !fs.existsSync(file)) process.exit(0);
  if (!findRepoRoot(file)) process.exit(0);

  const pluginRoot = process.env.CLAUDE_PLUGIN_ROOT;
  if (!pluginRoot) process.exit(0);

  const binary = path.join(pluginRoot, 'bin', 'plumbline');
  if (!fs.existsSync(binary)) process.exit(0);

  const args = [binary];
  const ranges = getChangedLineRanges(file);
  if (ranges !== null) {
    if (ranges.length === 0) process.exit(0);
    args.push('--lines', formatRanges(ranges));
  }
  args.push(file);

  const result = spawnSync('node', args, { stdio: 'inherit' });
  if (result.error) process.exit(0);
  process.exit(result.status === 2 ? 2 : 0);
}

main();
