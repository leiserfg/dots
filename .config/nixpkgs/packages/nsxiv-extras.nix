{
    makeDesktopItem,
    copyDesktopItems,
    nsxiv,
    stdenv,
    fetchFromGitHub
}:
let
    imgFormats = ["bmp" "gif" "jpeg" "jpg" "png" "tiff" "x-bmp" "x-portable-anymap" "x-portable-bitmap" "x-portable-graymap" "x-tga" "x-xpixmap" "webp"];
in
stdenv.mkDerivation rec {
  pname = "nsxiv-extra";
  version = "0.0.1";
  src = fetchFromGitHub {
      owner = "nsxiv";
      repo = pname;
      rev = "baf3745";
      sha256 = "sha256-3qs8rjK0WsCv1tIobrVJfqri7ZiV5FYgwgIAVtvn1VU=";
  };
  builtInputs = [nsxiv];
  nativeBuildInputs = [copyDesktopItems];
  desktopItems = [
    (makeDesktopItem {
     desktopName="Nsxiv Rifle";
     exec = "nsxiv-rifle";
     name = "nsxiv-rifle";
     icon= "nsxiv";
     mimeTypes = builtins.map (p: "image/${p}") imgFormats;
     genericName="Image Viewer";
     })
    ];

  installPhase = ''
  mkdir -p $out/bin
  cd scripts
  find -type f ! -name "*.md" -exec cp {} $out/bin \;
  copyDesktopItems
  '';
}
