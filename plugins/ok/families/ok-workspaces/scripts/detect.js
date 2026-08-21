#!/usr/bin/env node
// ok-workspaces stack detection. Read-only scan of the project for
// stack signals; prints the detected profile as JSON on stdout.
// Detection PROPOSES; the committed .ok-workspaces/config.json DECIDES.

const fs = require('fs');
const path = require('path');

// Project root: nearest ancestor carrying a suite estate marker, else
// the working directory — never derived from .git; the estate may live
// in a subfolder, submodule, or subproject of a repo whose own root
// wants no estate.
const ROOT_MARKERS = [
  '.ok-planner',
  '.ok-plumbline',
  '.ok-workspaces',
  '.plumbline.json',
  path.join('.claude', 'rules', 'plumbline-cheatsheet.md'),
];
function projectRoot() {
  let dir = process.cwd();
  for (;;) {
    if (ROOT_MARKERS.some((m) => fs.existsSync(path.join(dir, m)))) return dir;
    const parent = path.dirname(dir);
    if (parent === dir) return process.cwd();
    dir = parent;
  }
}

const root = projectRoot();
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
  // family's own dot-directory (converge gitignores them). A project
  // that wants them elsewhere declares it in the committed profile.
  worktrees: { dirPrefix: '.ok-workspaces/worktrees/', branchPrefix: 'wt/' },
  runTag: { path: '.ok-workspaces/bin/run-tag' },
};
if (runtime === 'docker-compose') {
  profile.compose = { projectPrefix: path.basename(root), files: composeFiles };
}
if (runtime === 'dev-server') {
  profile.devServer = { portEnvVars: ['PORT'], basePort: 3000, portsPerWorkspace: 10 };
}

process.stdout.write(JSON.stringify(profile, null, 2) + '\n');
