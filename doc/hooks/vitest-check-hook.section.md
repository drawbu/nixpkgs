# vitestCheckHook {#vitest-check-hook}

This hook sets the `checkPhase` to run the project's [vitest](https://vitest.dev) suite with `node_modules/.bin/vitest run`.
It works with any builder that installs the project's dependencies into `node_modules`, such as [`buildNpmPackage`](#javascript-buildNpmPackage) or [`pnpmConfigHook`](#javascript-pnpm).

```nix
{
  buildNpmPackage,
  vitestCheckHook,
  # ...
}:

buildNpmPackage (finalAttrs: {
  # ...

  nativeCheckInputs = [ vitestCheckHook ];
  doCheck = true;

  disabledTestPaths = [
    # Needs network access
    "test/registry.test.ts"
  ];
})
```

The hook disables vitest's results and module caches, as they would otherwise be written into `node_modules` and end up in the output.
It runs vitest with `CI=true`, and caps its workers to `$NIX_BUILD_CORES`, or 1 when `enableParallelChecking` is false.

## Variables controlling vitestCheckHook {#vitest-check-hook-variables}

`disabledTestPaths`
: Globs of test files to skip, passed to vitest's `--exclude`.

`vitestFlags`
: Additional arguments for `vitest run`, such as test file filters or `--test-timeout`.
  vitest has no flag to exclude a single test by name: skip it in the source, or narrow the run with `--testNamePattern`.

`dontUseVitestCheck`
: Set to `true` to keep the hook from setting the `checkPhase`. `vitestCheckHook` remains callable.
