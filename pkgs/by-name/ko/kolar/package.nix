{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  installFonts,
  nix-update-script,
}:

stdenvNoCC.mkDerivation {
  pname = "kolar";
  version = "0-unstable-2016-04-07";

  src = fetchFromGitHub {
    owner = "itfoundry";
    repo = "kolar";
    rev = "0da459bfb28a89423ab4c6232912054349855093";
    hash = "sha256-Q2+M86hpzMrgBPFcp9eXCwyYJ67c5BY6lcepVMDMUls=";
    sparseCheckout = [ "products" ];
  };

  nativeBuildInputs = [ installFonts ];

  dontBuild = true;

  passthru.updateScript = nix-update-script {
    extraArgs = [ "--version=branch" ];
  };

  meta = {
    description = "Kannada and Latin serif family for long-form text";
    homepage = "https://github.com/itfoundry/kolar";
    license = lib.licenses.ofl;
    platforms = lib.platforms.all;
    maintainers = with lib.maintainers; [ drawbu ];
  };
}
