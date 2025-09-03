{
  stdenv,
  fetchzip,
  lib,
}:
stdenv.mkDerivation rec {
  name = "nersc-sshproxy";
  version = "2.1.2";

  src =
    let
      url' = endname: "https://portal.nersc.gov/cfs/mfa/sshproxy-${version}-${endname}";
    in
    {
      x86_64-linux = fetchzip {
        url = url' "linux-x86_64.tar.gz";
        hash = "sha256-iAtGfArq7K/FFIeplKYjc2mDfsXzZ5PyW0+xfSfmzWg=";
      };
      aarch64-linux = fetchzip {
        url = url' "linux-aarch64.tar.gz";
        hash = "sha256-uoIYSzvv4GuyHa9B2RWWfcn0CFXz3HU+aA4v8M9+xNg=";
      };
    }
    .${stdenv.hostPlatform.system} or (throw "Unsupported system: ${stdenv.hostPlatform.system}");

  installPhase = ''
    install -Dm755 sshproxy $out/bin/sshproxy
  '';

  meta = {
    description = "NERSC SSH Proxy Service";
    mainProgram = "sshproxy";
    homepage = "https://github.com/deedy5/ddgs";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ drawbu ];
  };
}
