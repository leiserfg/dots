{
    withFFMPG ? true,
    stdenv, cmake, ninja, lib, fetchFromGitHub,
    libX11, libXrandr, libXinerama, libXcursor, libXi, libXext, libGLU, ffmpeg
}:

stdenv.mkDerivation rec {
  pname = "glslViewer";
  version = "2.0.4";
  src = fetchFromGitHub {
      owner = "patriciogonzalezvivo";
      repo = pname;
      fetchSubmodules = true;
      rev = version;
      sha256 = "sha256-Jrj8WlKrkPpmME50oVcZLQZs0bqbODAYibLJGPF7ock=";
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
  ] ++ lib.optional withFFMPG ffmpeg;

  cmakeFlags = [
      "-DCMAKE_BUILD_TYPE='Release'"
      "-GNinja"
  ];

  meta = with lib; {
      description = "Live GLSL coding renderer";
      homepage = "http://patriciogonzalezvivo.com/2015/glslViewer/";
      license = licenses.bsd3;
      platforms = platforms.linux;
      maintainers = [ maintainers.hodapp ];
  };
}
