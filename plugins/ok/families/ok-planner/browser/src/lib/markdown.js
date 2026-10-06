import { marked } from 'marked';
import DOMPurify from 'dompurify';

const SCHEME = /^[a-z][a-z0-9+.-]*:/i;

export const isProjectLink = (href) => Boolean(href) && !SCHEME.test(href) && !/^[#/]/.test(href);

DOMPurify.addHook('afterSanitizeAttributes', (node) => {
  if (node.tagName === 'A' && node.hasAttribute('href') && !isProjectLink(node.getAttribute('href'))) {
    node.setAttribute('target', '_blank');
    node.setAttribute('rel', 'noopener noreferrer');
  }
});

export function rendered(text) {
  return DOMPurify.sanitize(marked.parse(text ?? '', { gfm: true, breaks: true, async: false }));
}

function normalized(parts) {
  const out = [];
  for (const part of parts) {
    if (part === '' || part === '.') continue;
    if (part === '..') out.pop();
    else out.push(part);
  }
  return out.join('/');
}

export function resolveLink(href, from = '') {
  const [path, fragment = ''] = href.split('#');
  const dir = from.includes('/') ? from.slice(0, from.lastIndexOf('/')) : '';
  const lines = /^L(\d+)(?:-L?(\d+))?$/.exec(fragment);
  return {
    path: normalized([...(from ? dir.split('/') : []), ...decodeURI(path).split('/')]),
    lines: lines ? [Number(lines[1]), Number(lines[2] ?? lines[1])] : null,
  };
}

export function projectLinkAt(event) {
  const anchor = event.target instanceof Element ? event.target.closest('a[href]') : null;
  return anchor && isProjectLink(anchor.getAttribute('href')) ? anchor.getAttribute('href') : null;
}
