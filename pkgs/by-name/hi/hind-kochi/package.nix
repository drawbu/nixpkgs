{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  installFonts,
  nix-update-script,
}:

stdenvNoCC.mkDerivation {
  pname = "hind-kochi";
  version = "0-unstable-2015-10-17";

  src = fetchFromGitHub {
    owner = "itfoundry";
    repo = "hind-kochi";
    rev = "57ad6793acd07b743efa5f5691d4d58b8956bf74";
    hash = "sha256-m7mX+Zw4vCC97OXp6hcdTpR6l+FKTXrHwuk0ug0Faqk=";
    sparseCheckout = [ "build" ];
  };

  nativeBuildInputs = [ installFonts ];

  dontBuild = true;

  passthru.updateScript = nix-update-script {
    extraArgs = [ "--version=branch" ];
  };

  meta = {
    description = "Malayalam and Latin sans serif family";
    homepage = "https://github.com/itfoundry/hind-kochi";
    license = lib.licenses.ofl;
    platforms = lib.platforms.all;
    maintainers = with lib.maintainers; [ drawbu ];
  };
}
