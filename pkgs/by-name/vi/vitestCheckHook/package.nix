{
  lib,
  makeSetupHook,
}:

makeSetupHook {
  name = "vitest-check-hook";
  meta = {
    description = "Run a project's vitest suite as its checkPhase";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ drawbu ];
  };
} ./vitest-check-hook.sh
