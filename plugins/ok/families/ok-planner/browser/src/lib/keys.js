const FIELDS = new Set(['INPUT', 'TEXTAREA', 'SELECT']);

function typing(target) {
  return target instanceof HTMLElement && (FIELDS.has(target.tagName) || target.isContentEditable);
}

// @story: rule-on-the-whole-intake
export function onKeys(bindings) {
  const on = (event) => {
    if (event.defaultPrevented || event.metaKey || event.ctrlKey || event.altKey) return;
    if (typing(event.target)) return;
    const act = bindings[event.key];
    if (!act) return;
    event.preventDefault();
    act();
  };
  window.addEventListener('keydown', on);
  return () => window.removeEventListener('keydown', on);
}

export const submits = (event) => event.key === 'Enter' && (event.ctrlKey || event.metaKey);

export const cancels = (event) => event.key === 'Escape';
