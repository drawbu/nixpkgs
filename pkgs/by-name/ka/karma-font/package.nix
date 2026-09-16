{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  installFonts,
  nix-update-script,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "karma-font";
  version = "2.000";

  src = fetchFromGitHub {
    owner = "itfoundry";
    repo = "karma";
    rev = "v${finalAttrs.version}";
    hash = "sha256-2BSpA/B5sAi78uLDglW8fD0Wtxj+0rh6xVmcNxQcqpY=";
    sparseCheckout = [ "build" ];
  };

  nativeBuildInputs = [ installFonts ];

  dontBuild = true;

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Devanagari and Latin serif family for body text";
    homepage = "https://github.com/itfoundry/karma";
    license = lib.licenses.ofl;
    platforms = lib.platforms.all;
    maintainers = with lib.maintainers; [ drawbu ];
  };
})
