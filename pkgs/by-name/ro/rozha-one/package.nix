{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  installFonts,
  nix-update-script,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "rozha-one";
  version = "2.000";

  src = fetchFromGitHub {
    owner = "itfoundry";
    repo = "rozhaone";
    rev = "v${finalAttrs.version}";
    hash = "sha256-G+9wqKcV7oh9R6LFkK3KkNWwwRCy6biJeZPfcCfm75Y=";
    sparseCheckout = [ "build" ];
  };

  nativeBuildInputs = [ installFonts ];

  dontBuild = true;

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Devanagari and Latin display serif family";
    homepage = "https://github.com/itfoundry/rozhaone";
    license = lib.licenses.ofl;
    platforms = lib.platforms.all;
    maintainers = with lib.maintainers; [ drawbu ];
  };
})
