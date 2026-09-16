{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  installFonts,
  nix-update-script,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "tillana";
  version = "2.002";

  src = fetchFromGitHub {
    owner = "itfoundry";
    repo = "tillana";
    rev = "v${finalAttrs.version}";
    hash = "sha256-rmvToEMzTrxzMRY1s9wjFt/SRNfrX/wmXdWCBjRTmmk=";
    sparseCheckout = [ "build" ];
  };

  nativeBuildInputs = [ installFonts ];

  dontBuild = true;

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Devanagari and Latin display family";
    homepage = "https://github.com/itfoundry/tillana";
    license = lib.licenses.ofl;
    platforms = lib.platforms.all;
    maintainers = with lib.maintainers; [ drawbu ];
  };
})
