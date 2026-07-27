// The one derivation of ok-workspaces' vendored-skill renderings, shared by
// true-up.js (writes), diagnose.js (compares), and the repo's vendored-layer
// conformance check. The audit verb materializes plugin-prefixed under the
// integration contract's collision rule; every other verb keeps its name;
// the merged lifecycle verb comes from the shared template.
// @decision: vendored-skills

const fs = require('fs');
const path = require('path');

const SKILLS = {
  audit: 'ok-workspaces-audit',
  close: 'close',
  'ok-workspaces': 'ok-workspaces',
  open: 'open',
};

function renderSkill(text, srcName, version) {
  if (srcName === 'audit') {
    text = text.replace('name: audit', 'name: ok-workspaces-audit');
  }
  text = text.replace(/ok-workspaces:audit/g, 'ok-workspaces-audit');
  text = text.replace(/\/audit\b/g, '/ok-workspaces-audit');
  text = text.replace(/ok-workspaces:(true-up|open|close)/g, '$1');
  return (
    text +
    `\n<!-- Materialized by ok-workspaces v${version} — plugin-owned; overwritten by the true-up verb; do not hand-edit. -->\n`
  );
}

function vendoredSkills(pluginRoot, root, version) {
  const out = {};
  for (const [src, name] of Object.entries(SKILLS)) {
    const body = fs.readFileSync(path.join(pluginRoot, 'skills', src, 'SKILL.md'), 'utf8');
    out[path.join(root, '.claude', 'skills', name, 'SKILL.md')] = renderSkill(body, src, version);
  }
  out[path.join(root, '.claude', 'skills', 'true-up', 'SKILL.md')] =
    fs.readFileSync(path.join(pluginRoot, 'scripts', 'true-up-skill.md'), 'utf8') +
    `\n<!-- Materialized by the ok suite v${version} — plugin-owned; overwritten by the true-up verb; do not hand-edit. -->\n`;
  return out;
}

module.exports = { vendoredSkills };
