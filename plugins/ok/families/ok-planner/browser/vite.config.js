import { defineConfig } from 'vite';
import { svelte } from '@sveltejs/vite-plugin-svelte';

// @decision: svelte-dashboard-frontend
export default defineConfig({
  plugins: [svelte()],
  base: './',
  build: {
    outDir: 'dist',
    emptyOutDir: true,
    assetsDir: 'assets',
  },
});
