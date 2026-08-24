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

const STANDARD_REL = ['.ok-plumbline', 'docs', 'technical-writing.md'];
const PROSE_FLAG_PREFIX = 'ok-plumbline-prose-written-';
const MAX_SOURCES_LISTED = 30;

const ROOT_MARKERS = [
  '.ok-planner',
  '.ok-plumbline',
  '.ok-workspaces',
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

function agentKeyFromArgv() {
  return String(process.argv[2] || 'anonymous').replace(/[^A-Za-z0-9._-]/g, '_');
}

function takeFlag(key) {
  const p = path.join(os.tmpdir(), PROSE_FLAG_PREFIX + key);
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

function sourcesFrom(body, root) {
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

function main() {
  const root = resolveProjectRoot();
  const flag = takeFlag(agentKeyFromArgv());
  if (flag === null) {
    process.stdout.write('plumbline: nothing to do before you stop.\n');
    process.exit(0);
  }
  const sources = sourcesFrom(flag, root);
  const listed = sources.slice(0, MAX_SOURCES_LISTED).map((s) => `  - ${s}`).join('\n');
  const more = sources.length > MAX_SOURCES_LISTED ? `\n  - and ${sources.length - MAX_SOURCES_LISTED} more` : '';
  process.stdout.write([
    `plumbline/prose: you wrote prose this turn. Before you stop, review every sentence you wrote in these files against the writing standard (${path.join(...STANDARD_REL)}) and rewrite what fails. Then stop.`,
    'Where you wrote it:',
    listed + more,
    '',
  ].join('\n'));
  process.exit(0);
}

main();
