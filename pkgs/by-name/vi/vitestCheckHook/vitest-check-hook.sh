# shellcheck shell=bash disable=SC2154

vitestCheckHook() {
    echo "Executing vitestCheckHook"

    runHook preCheck

    local vitest=node_modules/.bin/vitest
    if [ ! -x "$vitest" ]; then
        echo "vitestCheckHook: $vitest not found; is vitest a dependency of the project?" >&2
        exit 1
    fi

    local workers=1
    if [ "${enableParallelChecking-1}" ]; then
        workers="$NIX_BUILD_CORES"
    fi

    local flagsArray=(
        run
        # Both caches live under node_modules, which installers copy into $out.
        --no-cache
        --no-fsModuleCache
        "--maxWorkers=$workers"
    )

    local disabledTestPathsArray=()
    concatTo disabledTestPathsArray disabledTestPaths
    local path
    for path in "${disabledTestPathsArray[@]}"; do
        flagsArray+=("--exclude=$path")
    done

    concatTo flagsArray vitestFlags

    echoCmd 'vitest flags' "${flagsArray[@]}"
    # Nix runs builders on a pty; without CI, vitest redraws its summary in the log.
    CI=true "$vitest" "${flagsArray[@]}"

    echo "Finished vitestCheckHook"

    runHook postCheck
}

if [ -z "${dontUseVitestCheck-}" ] && [ -z "${checkPhase-}" ]; then
    checkPhase=vitestCheckHook
fi
