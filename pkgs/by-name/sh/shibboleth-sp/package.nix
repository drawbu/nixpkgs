{
  lib,
  stdenv,
  fetchFromCodeberg,
  autoreconfHook,
  boost,
  fcgi,
  openssl,
  opensaml-cpp,
  log4shib,
  pkg-config,
  xercesc,
  xml-security-c,
  xml-tooling-c,
  unstableGitUpdater,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "shibboleth-sp";
  version = "3.6.0";

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
    openssl
    opensaml-cpp
    log4shib
    xercesc
    xml-security-c
    xml-tooling-c
  ];

  configureFlags = [
    "--without-apxs"
    "--with-xmltooling=${xml-tooling-c}"
    "--with-saml=${opensaml-cpp}"
    "--with-boost=${boost.dev}"
    "--with-fastcgi"
    "--with-boost=${boost.dev}"
    "CXXFLAGS=-std=c++14"
  ];

  enableParallelBuilding = true;

  passthru.updateScript = unstableGitUpdater { };

  meta = {
    homepage = "https://shibboleth.net/products/service-provider.html";
    description = "Enables SSO and Federation web applications written with any programming language or framework";
    platforms = lib.platforms.unix;
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ drawbu ];
  };
})
