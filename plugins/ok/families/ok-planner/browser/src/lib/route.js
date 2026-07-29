import { readable } from 'svelte/store';

function parse() {
  const raw = window.location.hash.replace(/^#\/?/, '');
  const [path, query] = raw.split('?');
  const parts = path ? path.split('/').map(decodeURIComponent) : [];
  return { parts, query: new URLSearchParams(query || '') };
}

export const route = readable(parse(), (set) => {
  const on = () => set(parse());
  window.addEventListener('hashchange', on);
  return () => window.removeEventListener('hashchange', on);
});

export function href(...parts) {
  return '#/' + parts.map(encodeURIComponent).join('/');
}
