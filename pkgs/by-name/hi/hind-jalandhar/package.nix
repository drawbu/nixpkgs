{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  installFonts,
  nix-update-script,
}:

stdenvNoCC.mkDerivation {
  pname = "hind-jalandhar";
  version = "0-unstable-2015-10-17";

  src = fetchFromGitHub {
    owner = "itfoundry";
    repo = "hind-jalandhar";
    rev = "27af9e8ea8f29ac810ffc0f76b4f240b70af0b24";
    hash = "sha256-0u5wALuUaSHElk9yoVSWehS7YAZxfdTqDYbUxIJ2IGQ=";
    sparseCheckout = [ "build" ];
  };

  nativeBuildInputs = [ installFonts ];

  dontBuild = true;

  passthru.updateScript = nix-update-script {
    extraArgs = [ "--version=branch" ];
  };

  meta = {
    description = "Gurmukhi and Latin sans serif family";
    homepage = "https://github.com/itfoundry/hind-jalandhar";
    license = lib.licenses.ofl;
    platforms = lib.platforms.all;
    maintainers = with lib.maintainers; [ drawbu ];
  };
}
