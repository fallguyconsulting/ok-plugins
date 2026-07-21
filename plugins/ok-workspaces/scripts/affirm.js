#!/usr/bin/env node
// ok-workspaces materialization. Requires an authoritative committed
// profile at .ok-workspaces/config.json (detection proposes via
// detect.js; a human commits the config). Materializes, from the
// profile: the canonical src-tag script at the profile-declared path,
// and the always-in-context cheatsheet at
// .claude/rules/ok-workspaces-cheatsheet.md. Both are plugin-owned
// whole files, overwritten wholesale, stamped with the plugin version.

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const pluginRoot = path.resolve(__dirname, '..');
const version = JSON.parse(
  fs.readFileSync(path.join(pluginRoot, '.claude-plugin', 'plugin.json'), 'utf8')
).version;

function repoRoot() {
  try {
    return execSync('git rev-parse --show-toplevel', { encoding: 'utf8' }).trim();
  } catch {
    return process.cwd();
  }
}
const root = repoRoot();
const configPath = path.join(root, '.ok-workspaces', 'config.json');

if (!fs.existsSync(configPath)) {
  console.error(
    'ok-workspaces affirm: no committed profile at .ok-workspaces/config.json.\n' +
      'Run detection first (node scripts/detect.js), review the proposal, and commit it as config.json.'
  );
  process.exit(2);
}
const cfg = JSON.parse(fs.readFileSync(configPath, 'utf8'));

const stamp = (s) => s.replace(/\{\{OK_WORKSPACES_VERSION\}\}/g, version);

const srcTagRel = (cfg.srcTag && cfg.srcTag.path) || '.ok-workspaces/bin/src-tag';
const srcTagAbs = path.join(root, srcTagRel);
fs.mkdirSync(path.dirname(srcTagAbs), { recursive: true });
fs.writeFileSync(srcTagAbs, stamp(fs.readFileSync(path.join(pluginRoot, 'scripts', 'src-tag'), 'utf8')));
fs.chmodSync(srcTagAbs, 0o755);

const dirPrefix = (cfg.worktrees && cfg.worktrees.dirPrefix) || '../wt-';
const branchPrefix = (cfg.worktrees && cfg.worktrees.branchPrefix) || 'wt/';

let runtimeRule;
if (cfg.runtime === 'docker-compose') {
  const prefix = (cfg.compose && cfg.compose.projectPrefix) || path.basename(root);
  runtimeRule = `**One runtime stack per worktree.** Every workspace runs its own compose
project, namespaced by workspace: \`COMPOSE_PROJECT_NAME=${prefix}-<job>\`
(set it in the workspace's local env, never hardcoded in a compose file).
Container names, networks, and volumes all derive from the project name,
so two workspaces can run their stacks concurrently without collision.
Host-port mappings must be parameterized (env var with a per-workspace
value), never fixed numbers shared across workspaces.`;
} else if (cfg.runtime === 'dev-server') {
  const vars = ((cfg.devServer && cfg.devServer.portEnvVars) || ['PORT']).join('`, `');
  const base = (cfg.devServer && cfg.devServer.basePort) || 3000;
  const span = (cfg.devServer && cfg.devServer.portsPerWorkspace) || 10;
  runtimeRule = `**One runtime stack per worktree.** Every workspace allocates its own
port block: workspace N uses ports ${base} + N×${span} through
${base} + N×${span} + ${span - 1}, exported via \`${vars}\` in the workspace's
local env. No port number is ever hardcoded in code, scripts, or config —
a second workspace must be startable without editing the first.`;
} else {
  runtimeRule = `**One runtime stack per worktree.** This project declares no shared
runtime (\`runtime: "none"\`). If a dev server, container stack, or other
long-lived process is introduced, re-run detection — /ok-workspaces:doctor
will flag the profile drift.`;
}

const cheatsheet = `# ok-workspaces Cheatsheet

Materialized by ok-workspaces v${version} — plugin-owned; refreshed by
\`/ok-workspaces:affirm\`; do not hand-edit. Profile:
\`.ok-workspaces/config.json\` (stacks: ${(cfg.stacks || []).join(', ') || 'none'};
runtime: ${cfg.runtime}).

Three rules. Each one makes the next one safe — ship any subset and the
isolation story has a hole.

1. **One worktree per job.** Every unit of work gets its own sibling
   checkout on its own branch: directory \`${dirPrefix}<job>\`, branch
   \`${branchPrefix}<job>\`. Never share a working tree between concurrent
   jobs; never do job work on the main checkout. Use
   \`/ok-workspaces:open <job>\` and \`/ok-workspaces:close <job>\`.

2. ${runtimeRule}

3. **Content-addressed artifacts.** Build outputs used for verification
   are tagged by source-tree hash: \`${srcTagRel}\` prints
   \`src-<12 hex>\` — a git tree-object hash of the working tree,
   including uncommitted changes. Same tree → same tag, on every
   machine. Tests and harnesses resolve artifacts by that tag and fail
   loudly when it is missing. Never \`:latest\` or any mutable tag in a
   verification path — staleness must be unrepresentable, not avoided.
`;

const rulesDir = path.join(root, '.claude', 'rules');
fs.mkdirSync(rulesDir, { recursive: true });
fs.writeFileSync(path.join(rulesDir, 'ok-workspaces-cheatsheet.md'), cheatsheet);

console.log(
  `Affirmed ok-workspaces v${version}: ${srcTagRel} + .claude/rules/ok-workspaces-cheatsheet.md materialized from .ok-workspaces/config.json.`
);
