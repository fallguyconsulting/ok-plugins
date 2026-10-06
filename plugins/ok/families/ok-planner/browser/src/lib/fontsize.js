const KEY = 'ok-planner-dashboard.font-size';
const STEPS = [70, 80, 90, 100, 110, 125, 140, 160, 180, 200];
export const DEFAULT_SCALE = 100;

function stepped(value) {
  return STEPS.includes(value) ? value : DEFAULT_SCALE;
}

export function loadScale() {
  try {
    return stepped(Number(window.localStorage.getItem(KEY)));
  } catch (e) {
    console.error('DASHBOARD.FONTLOAD.FAILED', { error: e.name, message: e.message, stack: e.stack });
    return DEFAULT_SCALE;
  }
}

export function applyScale(scale) {
  document.documentElement.style.fontSize = `${scale}%`;
  try {
    window.localStorage.setItem(KEY, String(scale));
  } catch (e) {
    console.error('DASHBOARD.FONTSAVE.FAILED', { error: e.name, message: e.message, stack: e.stack });
  }
}

export function nextScale(scale, direction) {
  const at = STEPS.indexOf(stepped(scale));
  return STEPS[Math.min(STEPS.length - 1, Math.max(0, at + direction))];
}

export const smallest = (scale) => scale === STEPS[0];
export const largest = (scale) => scale === STEPS[STEPS.length - 1];
