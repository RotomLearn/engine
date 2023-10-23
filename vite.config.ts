import {defineConfig} from 'vitest/config';

export default defineConfig({
  test: {
    watch: false,
    globals: true,
    exclude: ['node_modules', 'build', 'examples'],
    coverage: {reportsDirectory: 'coverage/js', exclude: ['src/test', '**/*.test.ts']},
  }
});
