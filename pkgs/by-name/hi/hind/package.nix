{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  installFonts,
  nix-update-script,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "hind";
  version = "2.000";

  src = fetchFromGitHub {
    owner = "itfoundry";
    repo = "hind";
    rev = "v${finalAttrs.version}";
    hash = "sha256-i+icfbZTb4eQfGiov8cniykm/hQNq4N6xDRwXRZ6DhE=";
    sparseCheckout = [ "build" ];
  };

  nativeBuildInputs = [ installFonts ];

  dontBuild = true;

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Devanagari and Latin sans serif family for user interfaces";
    homepage = "https://github.com/itfoundry/hind";
    license = lib.licenses.ofl;
    platforms = lib.platforms.all;
    maintainers = with lib.maintainers; [ drawbu ];
  };
})
