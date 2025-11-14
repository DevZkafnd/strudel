import { defineConfig } from 'vite'

export default defineConfig({
  server: {
    port: 5173,
    open: true
  },
  build: {
    outDir: 'dist',
    sourcemap: true
  },
  optimizeDeps: {
    include: [
      '@strudel/core',
      '@strudel/webaudio',
      '@strudel/mini',
      '@strudel/tonal',
      '@strudel/soundfonts',
      '@strudel/osc',
      '@strudel/effects'
    ]
  }
})
