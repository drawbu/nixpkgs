{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  installFonts,
  nix-update-script,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "teko";
  version = "2.000";

  src = fetchFromGitHub {
    owner = "itfoundry";
    repo = "teko";
    rev = "v${finalAttrs.version}";
    hash = "sha256-jn5eF60CJHaIqTIJNNqlV4zSkCXvyX29FLllyLm4LpM=";
    sparseCheckout = [ "build" ];
  };

  nativeBuildInputs = [ installFonts ];

  dontBuild = true;

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Devanagari and Latin sans serif family for display";
    homepage = "https://github.com/itfoundry/teko";
    license = lib.licenses.ofl;
    platforms = lib.platforms.all;
    maintainers = with lib.maintainers; [ drawbu ];
  };
})
