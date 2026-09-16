{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  installFonts,
  nix-update-script,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "kalam";
  version = "2.001";

  src = fetchFromGitHub {
    owner = "itfoundry";
    repo = "kalam";
    rev = "v${finalAttrs.version}";
    hash = "sha256-kbvUdJAjcxnrKarfNr0dr9x6aypxFJsFO2ybI0eN/fk=";
    sparseCheckout = [ "build" ];
  };

  nativeBuildInputs = [ installFonts ];

  dontBuild = true;

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Devanagari and Latin handwriting-style family";
    homepage = "https://github.com/itfoundry/kalam";
    license = lib.licenses.ofl;
    platforms = lib.platforms.all;
    maintainers = with lib.maintainers; [ drawbu ];
  };
})
