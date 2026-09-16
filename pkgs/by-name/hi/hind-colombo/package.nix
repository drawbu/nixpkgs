{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  installFonts,
  nix-update-script,
}:

stdenvNoCC.mkDerivation {
  pname = "hind-colombo";
  version = "0-unstable-2015-10-17";

  src = fetchFromGitHub {
    owner = "itfoundry";
    repo = "hind-colombo";
    rev = "3cf4e8b8400db78e2e07c75d162e66eb59e042c5";
    hash = "sha256-17DTiH2XaRJq5ypsnE4P3W9bqtyG7FgqOqqQp8V5HKE=";
    sparseCheckout = [ "build" ];
  };

  nativeBuildInputs = [ installFonts ];

  dontBuild = true;

  passthru.updateScript = nix-update-script {
    extraArgs = [ "--version=branch" ];
  };

  meta = {
    description = "Sinhala and Latin sans serif family";
    homepage = "https://github.com/itfoundry/hind-colombo";
    license = lib.licenses.ofl;
    platforms = lib.platforms.all;
    maintainers = with lib.maintainers; [ drawbu ];
  };
}
