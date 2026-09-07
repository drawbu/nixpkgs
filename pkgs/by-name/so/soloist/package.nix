{
  autopatchelfhook,
  fetchurl,
  lib,
  libpulseaudio,
  makewrapper,
  pipewire,
  stdenv,
  versioncheckhook,
}:

let
  sources = {
    x86_64-linux = fetchurl {
      url = "https://soloist-builds.spotifycdn.com/soloist_release_x86_64.tar.gz";
      hash = "sha256-srfzjaa9c1grsuxhposlnldeoqfbekyzplxytfe4es8=";
    };
    aarch64-linux = fetchurl {
      url = "https://soloist-builds.spotifycdn.com/soloist_release_arm64.tar.gz";
      hash = "sha256-mliiz5qu/yoaixv8xj4pcolfh8ysgyxn/hoa827/zp0=";
    };
  };
in
stdenv.mkderivation (finalattrs: {
  pname = "soloist";
  version = "1.3.8.22";

  strictdeps = true;
  __structuredattrs = true;

  src =
    sources.${stdenv.hostplatform.system}
      or (throw "unsupported system: ${stdenv.hostplatform.system}");

  sourceroot = ".";

  nativebuildinputs = [
    autopatchelfhook
    makewrapper
  ];

  buildinputs = [ stdenv.cc.cc.lib ];

  installphase = ''
    runhook preinstall

    install -dm755 soloist $out/bin/soloist
    install -dm644 third_party_licenses.txt $out/share/licenses/soloist/third_party_licenses.txt

    runhook postinstall
  '';

  postfixup = ''
    wrapprogram $out/bin/soloist \
      --prefix ld_library_path : "${
        lib.makelibrarypath [
          pipewire
          libpulseaudio
        ]
      }"
  '';

  nativeinstallcheckinputs = [ versioncheckhook ];
  doinstallcheck = true;

  meta = {
    description = "headless spotify connect client for linux";
    homepage = "https://developer.spotify.com/documentation/soloist";
    license = lib.licenses.unfree;
    mainprogram = "soloist";
    maintainers = with lib.maintainers; [ drawbu ];
    platforms = builtins.attrnames sources;
    sourceprovenance = with lib.sourcetypes; [ binarynativecode ];
  };
})
