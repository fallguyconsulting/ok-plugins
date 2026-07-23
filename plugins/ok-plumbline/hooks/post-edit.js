#!/usr/bin/env node

// SPDX-License-Identifier: Apache-2.0
//
// Plugin-root shim — behavior deliberately lives elsewhere.
//
// The harness resolves hook commands against ${CLAUDE_PLUGIN_ROOT}, so this
// file has to sit in the installed plugin copy. Nothing else does: it locates
// the project's own materialized hook at .ok-plumbline/hooks/post-edit.js and
// hands off, stdin intact. Every project therefore lints with the binary
// version it was trued up to, and editing this plugin cannot disturb a session
// running in another project. A project with no .ok-plumbline/ estate is
// silently skipped — the same discovery rule the rest of the suite uses.

const fs = require('fs');
const path = require('path');
const { spawnSync } = require('child_process');

function resolveRoot() {
  let dir = process.env.CLAUDE_PROJECT_DIR || process.cwd();
  dir = path.resolve(dir);
  while (dir !== path.dirname(dir)) {
    if (fs.existsSync(path.join(dir, '.git'))) return dir;
    dir = path.dirname(dir);
  }
  return path.resolve(process.env.CLAUDE_PROJECT_DIR || process.cwd());
}

const impl = path.join(resolveRoot(), '.ok-plumbline', 'hooks', 'post-edit.js');
if (!fs.existsSync(impl)) process.exit(0);

const result = spawnSync('node', [impl], { stdio: 'inherit' });
if (result.error) process.exit(0);
process.exit(result.status === 2 ? 2 : 0);
