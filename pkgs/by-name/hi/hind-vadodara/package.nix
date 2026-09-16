{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  installFonts,
  nix-update-script,
}:

stdenvNoCC.mkDerivation {
  pname = "hind-vadodara";
  version = "0-unstable-2015-10-17";

  src = fetchFromGitHub {
    owner = "itfoundry";
    repo = "hind-vadodara";
    rev = "d1972e4ebebc3a65feef2f66823a83444469ece4";
    hash = "sha256-CY/0cHSu8nl+of2TrrEO4fK8/QtKCaV7ZDvHNTVgNoM=";
    sparseCheckout = [ "build" ];
  };

  nativeBuildInputs = [ installFonts ];

  dontBuild = true;

  passthru.updateScript = nix-update-script {
    extraArgs = [ "--version=branch" ];
  };

  meta = {
    description = "Gujarati and Latin sans serif family";
    homepage = "https://github.com/itfoundry/hind-vadodara";
    license = lib.licenses.ofl;
    platforms = lib.platforms.all;
    maintainers = with lib.maintainers; [ drawbu ];
  };
}
