{
  buildNpmPackage,
  fetchFromGitHub,
  jq,
  lib,
  versionCheckHook,
  vitestCheckHook,
}:

buildNpmPackage (finalAttrs: {
  pname = "upm";
  version = "1.4.0";

  __structuredAttrs = true;

  src = fetchFromGitHub {
    owner = "unjs";
    repo = "upm";
    tag = "v${finalAttrs.version}";
    hash = "sha256-R+foJCRg35BIEUjkGdRKnSQf2PfFiCm7wODQyB5O2Ps=";
  };

  postPatch = ''
    # the `web` workspace is the upm.sh website
    ${lib.getExe jq} 'del(.workspaces)' package.json > package.json.tmp
    mv package.json.tmp package.json

    cp ${./package-lock.json} package-lock.json
  '';

  npmDepsHash = "sha256-0pJg9noJ77Nj4JYC120WchlQkNDG7z6JTbH7+tncX6Y=";

  doCheck = true;
  nativeCheckInputs = [ vitestCheckHook ];
  vitestFlags = [
    "--test-timeout=30000"
    "--testNamePattern=^(?!.*passes a signal on to the script)"
  ];

  preCheck = ''
    substituteInPlace test/cli.test.ts \
      --replace-fail '#!/usr/bin/env node' '#!''${process.execPath}'

    unset npm_config_offline # allow local registries
  '';
  __darwinAllowLocalNetworking = true;

  doInstallCheck = true;
  nativeInstallCheckInputs = [ versionCheckHook ];

  meta = {
    description = "Fast, tiny package manager for the npm registry, written in TypeScript";
    homepage = "https://upm.sh";
    changelog = "https://github.com/unjs/upm/blob/v${finalAttrs.version}/CHANGELOG.md";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ drawbu ];
    mainProgram = "upm";
  };
})
