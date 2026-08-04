// dom-picker — dev-only element picker for human-to-agent pointing.
//
// Contract (agents rely on these exact names):
//   window.__domPicker.start()  — begin picking: hover highlights, click selects
//   window.__domPicker.stop()   — cancel without selecting (Esc does the same)
//   window.__domPicker.active   — whether picking is in progress
//   On selection: the element is stamped data-claude-selected="true" (any
//   previous stamp cleared), a descriptor is written to
//   window.__claudeSelected, and the picker deactivates.
//
// Ship dev-only: import this module behind your bundler's dev flag
// (e.g. Vite: if (import.meta.env.DEV) import('./dom-picker')).
// Importing the module installs the picker; it does not start it.

interface SelectedDescriptor {
  tag: string;
  id: string | null;
  classes: string[];
  text: string;
  attributes: Record<string, string>;
  rect: { x: number; y: number; width: number; height: number };
  selector: string;
  styles: { fontSize: string; color: string; backgroundColor: string };
}

const OVERLAY_ID = "__dom-picker-overlay";

function cssPath(el: Element): string {
  const parts: string[] = [];
  let node: Element | null = el;
  while (node && node.nodeType === Node.ELEMENT_NODE && node !== document.documentElement) {
    if (node.id) {
      parts.unshift(`#${CSS.escape(node.id)}`);
      break;
    }
    let part = node.tagName.toLowerCase();
    const classes = Array.from(node.classList).slice(0, 3);
    if (classes.length) part += "." + classes.map((c) => CSS.escape(c)).join(".");
    const parent = node.parentElement;
    if (parent) {
      const siblings = Array.from(parent.children).filter((s) => s.tagName === node!.tagName);
      if (siblings.length > 1) part += `:nth-child(${Array.from(parent.children).indexOf(node) + 1})`;
    }
    parts.unshift(part);
    node = node.parentElement;
  }
  return parts.join(" > ");
}

function describe(el: Element): SelectedDescriptor {
  const rect = el.getBoundingClientRect();
  const computed = getComputedStyle(el);
  const attributes: Record<string, string> = {};
  for (const attr of Array.from(el.attributes)) attributes[attr.name] = attr.value;
  return {
    tag: el.tagName.toLowerCase(),
    id: el.id || null,
    classes: Array.from(el.classList),
    text: (el.textContent || "").trim().slice(0, 200),
    attributes,
    rect: { x: rect.x, y: rect.y, width: rect.width, height: rect.height },
    selector: cssPath(el),
    styles: {
      fontSize: computed.fontSize,
      color: computed.color,
      backgroundColor: computed.backgroundColor,
    },
  };
}

function makeOverlay(): HTMLDivElement {
  const overlay = document.createElement("div");
  overlay.id = OVERLAY_ID;
  Object.assign(overlay.style, {
    position: "fixed",
    zIndex: "2147483647",
    pointerEvents: "none",
    outline: "2px solid #4a90d9",
    background: "rgba(74, 144, 217, 0.15)",
    display: "none",
  });
  document.body.appendChild(overlay);
  return overlay;
}

let active = false;
let overlay: HTMLDivElement | null = null;

function onMove(e: MouseEvent) {
  const target = document.elementFromPoint(e.clientX, e.clientY);
  if (!overlay) return;
  if (!target || target === document.body || target === document.documentElement) {
    overlay.style.display = "none";
    return;
  }
  const rect = target.getBoundingClientRect();
  Object.assign(overlay.style, {
    display: "block",
    left: `${rect.x}px`,
    top: `${rect.y}px`,
    width: `${rect.width}px`,
    height: `${rect.height}px`,
  });
}

function onClick(e: MouseEvent) {
  e.preventDefault();
  e.stopPropagation();
  const target = document.elementFromPoint(e.clientX, e.clientY);
  stop();
  if (!target) return;
  document
    .querySelectorAll('[data-claude-selected="true"]')
    .forEach((el) => el.removeAttribute("data-claude-selected"));
  target.setAttribute("data-claude-selected", "true");
  (window as any).__claudeSelected = describe(target);
}

function onKey(e: KeyboardEvent) {
  if (e.key === "Escape") stop();
}

function start() {
  if (active) return;
  active = true;
  if (!overlay) overlay = makeOverlay();
  document.addEventListener("mousemove", onMove, true);
  document.addEventListener("click", onClick, true);
  document.addEventListener("keydown", onKey, true);
}

function stop() {
  if (!active) return;
  active = false;
  if (overlay) overlay.style.display = "none";
  document.removeEventListener("mousemove", onMove, true);
  document.removeEventListener("click", onClick, true);
  document.removeEventListener("keydown", onKey, true);
}

(window as any).__domPicker = {
  start,
  stop,
  get active() {
    return active;
  },
};

export {};
