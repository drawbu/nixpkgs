{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  installFonts,
  nix-update-script,
}:

stdenvNoCC.mkDerivation {
  pname = "kumar-one";
  version = "0-unstable-2016-04-12";

  src = fetchFromGitHub {
    owner = "itfoundry";
    repo = "kumar";
    rev = "3192a79a79202eb715d83fd044e9234a6d0dde66";
    hash = "sha256-5SHejajtwiiXAUYFYd852bBULvL0dASsyXbwBm2lJww=";
    sparseCheckout = [ "products" ];
  };

  nativeBuildInputs = [ installFonts ];

  dontBuild = true;

  passthru.updateScript = nix-update-script {
    extraArgs = [ "--version=branch" ];
  };

  meta = {
    description = "Gujarati and Latin display family";
    homepage = "https://github.com/itfoundry/kumar";
    license = lib.licenses.ofl;
    platforms = lib.platforms.all;
    maintainers = with lib.maintainers; [ drawbu ];
  };
}
