{
    withFFMPG ? true,
    stdenv, cmake, ninja, lib, fetchFromGitHub, pkg-config,
    libX11, libXrandr, libXinerama, libXcursor, libXi, libXext, libGLU, ffmpeg, ncurses
}:

stdenv.mkDerivation rec {
  pname = "glslViewer";
  version = "2.0.4-test";
  src = fetchFromGitHub {
      owner = "patriciogonzalezvivo";
      repo = pname;
      fetchSubmodules = true;
      rev = "9dc7a065124724652b391886bdc0054c9fc97cf6";
      sha256 = "sha256-THw0K3e8WVPfI09ZfB5CCfEwroazLBpC+fqd4QphXNg=";
  };
  nativeBuildInputs = [cmake ninja];
  buildInputs = [
      libX11
      libXrandr
      libXinerama
      libXcursor
      libXi
      libXext
      libGLU
      ncurses
      pkg-config
  ] ++ lib.optional withFFMPG ffmpeg;

  meta = with lib; {
      description = "Live GLSL coding renderer";
      homepage = "http://patriciogonzalezvivo.com/2015/glslViewer/";
      license = licenses.bsd3;
      platforms = platforms.linux;
  };
}
