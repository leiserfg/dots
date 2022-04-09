{
    writeShellScriptBin, alacritty, symlinkJoin
}:

let
    wrapped = writeShellScriptBin "alacritty" ''
        #!/bin/sh
        echo "HOLO"
        ${alacritty}/bin/alacritty "$@"
      '';
in

symlinkJoin {
  name = "alacritty";
  paths = [
    wrapped
    alacritty
  ];
}
