{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  installFonts,
  nix-update-script,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "sarpanch";
  version = "2.000";

  src = fetchFromGitHub {
    owner = "itfoundry";
    repo = "sarpanch";
    rev = "v${finalAttrs.version}";
    hash = "sha256-Y8t6LmssPYh6nJRmdqZnJVFApPogy2Ikb2tR8qk1TVQ=";
    sparseCheckout = [ "build" ];
  };

  nativeBuildInputs = [ installFonts ];

  dontBuild = true;

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Devanagari and Latin sans serif family";
    homepage = "https://github.com/itfoundry/sarpanch";
    license = lib.licenses.ofl;
    platforms = lib.platforms.all;
    maintainers = with lib.maintainers; [ drawbu ];
  };
})
