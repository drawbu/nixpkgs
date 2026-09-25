{
  autoreconfHook,
  boost,
  fcgi,
  fetchFromCodeberg,
  gitUpdater,
  lib,
  log4shib,
  opensaml-cpp,
  openssl,
  pkg-config,
  stdenv,
  xercesc,
  xml-security-c,
  xml-tooling-c,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "shibboleth-sp";
  version = "3.6.0";

  outputs = [
    "out"
    "bin"
    "dev"
    "doc"
  ];

  src = fetchFromCodeberg {
    owner = "Shibboleth";
    repo = "cpp-sp";
    tag = finalAttrs.version;
    hash = "sha256-edcRzf95NILkQbIf6cXNefQuksDHmbqa2jR6QNn/tno=";
  };

  nativeBuildInputs = [
    autoreconfHook
    pkg-config
  ];
  buildInputs = [
    boost
    fcgi
    log4shib
    opensaml-cpp
    openssl
    xercesc
    xml-security-c
    xml-tooling-c
  ];

  configureFlags = [
    "--without-apxs"
    "--with-boost=${boost.dev}"
    "--with-fastcgi"
    "CXXFLAGS=-std=c++14"
  ];

  enableParallelBuilding = true;

  passthru.updateScript = gitUpdater { ignoredVersions = "alpha|beta|rc"; };

  __structuredAttrs = true;
  strictDeps = true;

  meta = {
    homepage = "https://shibboleth.net/products/service-provider.html";
    description = "Enables SSO and Federation web applications written with any programming language or framework";
    platforms = lib.platforms.unix;
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ drawbu ];
  };
})
