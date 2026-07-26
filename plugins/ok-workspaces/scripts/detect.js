#!/usr/bin/env node
// ok-workspaces stack detection. Read-only scan of the project for
// stack signals; prints the detected profile as JSON on stdout.
// Detection PROPOSES; the committed .ok-workspaces/config.json DECIDES.

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

function repoRoot() {
  try {
    return execSync('git rev-parse --show-toplevel', { encoding: 'utf8' }).trim();
  } catch {
    return process.cwd();
  }
}

const root = repoRoot();
const exists = (p) => fs.existsSync(path.join(root, p));
const topEntries = fs.readdirSync(root);

const stacks = [];
if (exists('go.mod') || exists('go.work')) stacks.push('go');
if (exists('package.json')) stacks.push('node');
if (exists('Cargo.toml')) stacks.push('rust');
if (exists('pyproject.toml') || exists('setup.py') || exists('requirements.txt')) stacks.push('python');

const composeFiles = topEntries.filter((f) => /^(docker-)?compose.*\.ya?ml$/.test(f));
const hasDockerfiles =
  topEntries.some((f) => /^Dockerfile/.test(f)) ||
  (exists('dockerfiles') && fs.readdirSync(path.join(root, 'dockerfiles')).some((f) => /^Dockerfile/.test(f)));
if (composeFiles.length || hasDockerfiles) stacks.push('docker');

let runtime = 'none';
if (composeFiles.length || hasDockerfiles) {
  runtime = 'docker-compose';
} else if (exists('package.json')) {
  try {
    const pkg = JSON.parse(fs.readFileSync(path.join(root, 'package.json'), 'utf8'));
    if (pkg.scripts && (pkg.scripts.dev || pkg.scripts.start || pkg.scripts.serve)) runtime = 'dev-server';
  } catch {}
}

const profile = {
  stacks,
  runtime,
  // Default keeps worktrees inside the project root, under the
  // plugin's own dot-directory (true-up gitignores them). A project
  // that wants them elsewhere declares it in the committed profile.
  worktrees: { dirPrefix: '.ok-workspaces/worktrees/', branchPrefix: 'wt/' },
  srcTag: { path: '.ok-workspaces/bin/src-tag' },
};
if (runtime === 'docker-compose') {
  profile.compose = { projectPrefix: path.basename(root), files: composeFiles };
}
if (runtime === 'dev-server') {
  profile.devServer = { portEnvVars: ['PORT'], basePort: 3000, portsPerWorkspace: 10 };
}

process.stdout.write(JSON.stringify(profile, null, 2) + '\n');
