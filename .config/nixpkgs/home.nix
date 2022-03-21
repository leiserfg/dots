{ config, pkgs, ... }:
let
  hardware = pkgs.callPackage ./hardware.nix { };
  hasNvidia = hardware.productName == "MS-7A38";
in
{
  targets.genericLinux.enable = true; # I don't use NixOS nor MacOS
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "leiserfg";
  home.homeDirectory = "/home/leiserfg";
  home.stateVersion = "22.05";

  nixpkgs.overlays = [
    (builtins.getFlake github:edolstra/nix-warez?dir=blender).overlay
    (builtins.getFlake github:nix-community/neovim-nightly-overlay).overlay
    # (self: super: {
    #     qtile = python3.withPackages(_: [super.qtile.unwrapped]).overrideAttrs (_: {
    #       otherwise will be exported as "env", this restores `nix search` behavior
    #       name = "${unwrapped.pname}-${unwrapped.version}";
    #       # export underlying qtile package
    #       passthru = { inherit unwrapped; };
    #     }
    # })
  ];


  home.sessionVariables = if hasNvidia then hardware.nvidiaVars else hardware.intelVars;

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; with builtins; with lib; [
    neovim-nightly
    gcc # This has to be available for treesitter to build the parsers
    pcmanfm
    krita
    poetry
    (getAttr system (builtins.getFlake github:bennofs/nix-index).defaultPackage)
    pandoc
    nix-update
    firefox
    python310Packages.ipython
    python310Packages.pip
    darktable
    fish
    rofi
  ]
  ++ map (x: pkgs.callPackage ("${./packages}/${x}") { })
         (filter (hasSuffix ".nix")
                 (attrNames (readDir ./packages)))
  ++ pkgs.lib.optionals hasNvidia [
        wineWowPackages.unstable
        blender_3_1
        lutris
        dxvk
    ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.fzf.enable = true;
  programs.lf.enable = true;
  programs.mpv = {
    enable = true;
    scripts = [ pkgs.mpvScripts.mpris ];
  };
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
    font = {
        package=pkgs.lato;
        name = "Lato";
    };
    cursorTheme = {
        package = pkgs.gnome.adwaita-icon-theme;
        name = "Adwaita";
    };
  };
  qt.enable = true;

  xsession = {
    enable = true;
    windowManager.command = "env XCURSOR_PATH=$HOME/.nix-profile/share/icons ${pkgs.qtile}/bin/qtile start";
    pointerCursor = {
        package = pkgs.gnome.adwaita-icon-theme;
        name = "Adwaita";
    };
  };

}
