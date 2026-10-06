import { defineConfig } from 'vite';
import { svelte } from '@sveltejs/vite-plugin-svelte';

const api = process.env.DASHBOARD_API;

// @decision: svelte-dashboard-frontend
export default defineConfig({
  plugins: [svelte()],
  server: api ? { proxy: { '/api': { target: api, changeOrigin: true, headers: { origin: new URL(api).origin } } } } : {},
  base: './',
  build: {
    outDir: 'dist',
    emptyOutDir: true,
    assetsDir: 'assets',
  },
});
