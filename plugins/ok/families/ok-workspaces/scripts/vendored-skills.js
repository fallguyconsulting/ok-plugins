// The one derivation of ok-workspaces' vendored-skill renderings, shared by
// converge.js (writes), diagnose.js (compares), and the repo's vendored-layer
// conformance check. The audit verb materializes family-prefixed under the
// integration contract's collision rule; every other verb keeps its name.
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
  // Rewrite slash-command references only — never support-script paths
  // (an `/audit-…` file name must survive), hence the hyphen guard.
  text = text.replace(/\/audit\b(?!-)/g, '/ok-workspaces-audit');
  text = text.replace(/ok-workspaces:(open|close)/g, '$1');
  return (
    text +
    `\n<!-- Materialized by ok-workspaces v${version} — suite-owned; overwritten on converge; do not hand-edit. -->\n`
  );
}

function vendoredSkills(pluginRoot, root, version) {
  const out = {};
  for (const [src, name] of Object.entries(SKILLS)) {
    const body = fs.readFileSync(path.join(pluginRoot, 'skills', src, 'SKILL.md'), 'utf8');
    out[path.join(root, '.claude', 'skills', name, 'SKILL.md')] = renderSkill(body, src, version);
  }
  return out;
}

module.exports = { vendoredSkills };
