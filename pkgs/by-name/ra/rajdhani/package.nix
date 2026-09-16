{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  installFonts,
  nix-update-script,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "rajdhani";
  version = "2.000";

  src = fetchFromGitHub {
    owner = "itfoundry";
    repo = "rajdhani";
    rev = "v${finalAttrs.version}";
    hash = "sha256-yeRNGH+6HwX0XqEzvIDcp2+8BmJpho1MFGKNJHvvTZ8=";
    sparseCheckout = [ "build" ];
  };

  nativeBuildInputs = [ installFonts ];

  dontBuild = true;

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Squared condensed Devanagari and Latin family for display";
    homepage = "https://github.com/itfoundry/rajdhani";
    license = lib.licenses.ofl;
    platforms = lib.platforms.all;
    maintainers = with lib.maintainers; [ drawbu ];
  };
})
