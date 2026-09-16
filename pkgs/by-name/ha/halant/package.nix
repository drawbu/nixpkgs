{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  installFonts,
  nix-update-script,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "halant";
  version = "2.000";

  src = fetchFromGitHub {
    owner = "itfoundry";
    repo = "halant";
    rev = "v${finalAttrs.version}";
    hash = "sha256-8+W8rQVseNKJMPFfTICEYzwZ5+tfGRpN69t6y2Nk7dQ=";
    sparseCheckout = [ "build" ];
  };

  nativeBuildInputs = [ installFonts ];

  dontBuild = true;

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Devanagari and Latin serif family";
    homepage = "https://github.com/itfoundry/halant";
    license = lib.licenses.ofl;
    platforms = lib.platforms.all;
    maintainers = with lib.maintainers; [ drawbu ];
  };
})
