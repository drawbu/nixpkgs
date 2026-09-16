{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  installFonts,
  nix-update-script,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "laila";
  version = "2.000";

  src = fetchFromGitHub {
    owner = "itfoundry";
    repo = "laila";
    rev = "v${finalAttrs.version}";
    hash = "sha256-ni7wX1pEscIhYMKnLEsY2frMLsbOZbLxNrx9+5dSL3o=";
    sparseCheckout = [ "build" ];
  };

  nativeBuildInputs = [ installFonts ];

  dontBuild = true;

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Devanagari and Latin serif family";
    homepage = "https://github.com/itfoundry/laila";
    license = lib.licenses.ofl;
    platforms = lib.platforms.all;
    maintainers = with lib.maintainers; [ drawbu ];
  };
})
