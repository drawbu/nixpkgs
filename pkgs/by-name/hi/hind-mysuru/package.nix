{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  installFonts,
  nix-update-script,
}:

stdenvNoCC.mkDerivation {
  pname = "hind-mysuru";
  version = "0-unstable-2015-10-17";

  src = fetchFromGitHub {
    owner = "itfoundry";
    repo = "hind-mysuru";
    rev = "7d7fe4cfa6f19c057217ed43174dc9a7aef82552";
    hash = "sha256-/KVIK44h6ScGZLT7wD/sGgeJEPzqV+zw475q+pixch4=";
    sparseCheckout = [ "build" ];
  };

  nativeBuildInputs = [ installFonts ];

  dontBuild = true;

  passthru.updateScript = nix-update-script {
    extraArgs = [ "--version=branch" ];
  };

  meta = {
    description = "Kannada and Latin sans serif family";
    homepage = "https://github.com/itfoundry/hind-mysuru";
    license = lib.licenses.ofl;
    platforms = lib.platforms.all;
    maintainers = with lib.maintainers; [ drawbu ];
  };
}
