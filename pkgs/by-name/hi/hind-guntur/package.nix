{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  installFonts,
  nix-update-script,
}:

stdenvNoCC.mkDerivation {
  pname = "hind-guntur";
  version = "0-unstable-2015-10-17";

  src = fetchFromGitHub {
    owner = "itfoundry";
    repo = "hind-guntur";
    rev = "d1f95f8d9a6013297a6a63cc54e48e3885eb5813";
    hash = "sha256-Ii/0W5DqZgdAOpBb8lgGkYE++riqKGu6KJwGxZEtVu0=";
    sparseCheckout = [ "build" ];
  };

  nativeBuildInputs = [ installFonts ];

  dontBuild = true;

  passthru.updateScript = nix-update-script {
    extraArgs = [ "--version=branch" ];
  };

  meta = {
    description = "Telugu and Latin sans serif family";
    homepage = "https://github.com/itfoundry/hind-guntur";
    license = lib.licenses.ofl;
    platforms = lib.platforms.all;
    maintainers = with lib.maintainers; [ drawbu ];
  };
}
