{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  installFonts,
  nix-update-script,
}:

stdenvNoCC.mkDerivation {
  pname = "roundo";
  version = "0-unstable-2016-05-24";

  src = fetchFromGitHub {
    owner = "itfoundry";
    repo = "roundo";
    rev = "f7e77db4300d2c7ce0176f42196cd35fc1c91c42";
    hash = "sha256-7Upm86BXe1J073aQ0bYasqWzZYfNoIAv+Xc8jzBx/u4=";
    sparseCheckout = [ "build" ];
  };

  nativeBuildInputs = [ installFonts ];

  dontBuild = true;

  passthru.updateScript = nix-update-script {
    extraArgs = [ "--version=branch" ];
  };

  meta = {
    description = "Geometric sans serif with Gurmukhi and Latin support";
    homepage = "https://github.com/itfoundry/roundo";
    license = lib.licenses.ofl;
    platforms = lib.platforms.all;
    maintainers = with lib.maintainers; [ drawbu ];
  };
}
