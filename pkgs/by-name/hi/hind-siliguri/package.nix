{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  installFonts,
  nix-update-script,
}:

stdenvNoCC.mkDerivation {
  pname = "hind-siliguri";
  version = "0-unstable-2015-10-17";

  src = fetchFromGitHub {
    owner = "itfoundry";
    repo = "hind-siliguri";
    rev = "affb7dbd00dc554c33ecafc92cbfef5323ae5235";
    hash = "sha256-xAoCD0QFo1SzLtXVGESieOJzWwsiUdHgscD94Zlh2g8=";
    sparseCheckout = [ "build" ];
  };

  nativeBuildInputs = [ installFonts ];

  dontBuild = true;

  passthru.updateScript = nix-update-script {
    extraArgs = [ "--version=branch" ];
  };

  meta = {
    description = "Bangla and Latin sans serif family";
    homepage = "https://github.com/itfoundry/hind-siliguri";
    license = lib.licenses.ofl;
    platforms = lib.platforms.all;
    maintainers = with lib.maintainers; [ drawbu ];
  };
}
