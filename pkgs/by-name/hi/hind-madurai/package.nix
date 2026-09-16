{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  installFonts,
  nix-update-script,
}:

stdenvNoCC.mkDerivation {
  pname = "hind-madurai";
  version = "0-unstable-2015-10-17";

  src = fetchFromGitHub {
    owner = "itfoundry";
    repo = "hind-madurai";
    rev = "3f3bd222489daea4dfec65d5de86012ed4819b5b";
    hash = "sha256-x6+5ochYDYva3dIADadqsxRSACIYB1IqP3MraTHVwRM=";
    sparseCheckout = [ "build" ];
  };

  nativeBuildInputs = [ installFonts ];

  dontBuild = true;

  passthru.updateScript = nix-update-script {
    extraArgs = [ "--version=branch" ];
  };

  meta = {
    description = "Tamil and Latin sans serif family";
    homepage = "https://github.com/itfoundry/hind-madurai";
    license = lib.licenses.ofl;
    platforms = lib.platforms.all;
    maintainers = with lib.maintainers; [ drawbu ];
  };
}
