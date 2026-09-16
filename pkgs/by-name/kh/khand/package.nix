{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  installFonts,
  nix-update-script,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "khand";
  version = "2.000";

  src = fetchFromGitHub {
    owner = "itfoundry";
    repo = "khand";
    rev = "v${finalAttrs.version}";
    hash = "sha256-NxaoS4FOxYiavuuDo4gq1Sw272M3DuVZwA4SrJRfOwE=";
    sparseCheckout = [ "build" ];
  };

  nativeBuildInputs = [ installFonts ];

  dontBuild = true;

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Condensed Devanagari and Latin sans serif family for display";
    homepage = "https://github.com/itfoundry/khand";
    license = lib.licenses.ofl;
    platforms = lib.platforms.all;
    maintainers = with lib.maintainers; [ drawbu ];
  };
})
