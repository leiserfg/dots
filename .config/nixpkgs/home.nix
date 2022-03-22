{ config, pkgs, ... }:
let
  hardware = pkgs.callPackage ./hardware.nix { };
  isThePc = "MS-7A38" == hardware.productName;
  isTheThinkpad = pkgs.lib.hasPrefix "20TH" hardware.productName ;
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


  home.sessionVariables = if isThePc then hardware.nvidiaVars else if isTheThinkpad then
  hardware.intelVars else [];

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; with builtins; with lib; [
    neovim-nightly
    gcc # This has to be available for treesitter to build the parsers
    pcmanfm
    krita
    poetry
    (getAttr system (getFlake github:bennofs/nix-index).defaultPackage)
    pandoc
    nix-update
    firefox
    python310Packages.ipython
    python310Packages.pip
    darktable
    kitty
    fish
    rofi
    picom
    unclutter
    pasystray
    pavucontrol
    tdesktop
    zathura
    # bluetooth_battery
    nsxiv
    dragon-drop
  ]
  ++ map (x: pkgs.callPackage ("${./packages}/${x}") { })
         (filter (hasSuffix ".nix")
                 (attrNames (readDir ./packages)))
  ++ pkgs.lib.optionals isTheThinkpad [slack]
  ++ pkgs.lib.optionals isThePc [
        wineWowPackages.unstable
        blender_3_1
        lutris
        dxvk
    ];
  services.mpris-proxy.enable = true;
  services.dunst = {
      enable = true;
      iconTheme = {
          package = pkgs.papirus-icon-theme;
          name = "Papirus-Dark";
      };
      settings = {
          global = {
              frame_width = 1;
              frame_color = "#788388";
              font = "Lato 10";
              markup="yes";
              format = "%s %p\n%b";
              transparency = 15;
              follow = "mouse";
              show_indicators = "yes";
          };
          urgency_low = {
              background = "#263238";
              foreground = "#556064";
              timeout = 10;
          };

          urgency_normal = {
              background = "#263238";
              foreground = "#F9FAF9";
              timeout = 10;
          };

          urgency_critical = {
              background = "#D62929";
              foreground = "#F9FAF9";
              timeout = 0;
          };
      };
  };
  services.blueman-applet.enable = true;
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
    # cursorTheme = {
    #     package = pkgs.gnome.adwaita-icon-theme;
    #     name = "Adwaita";
    # };
  };
  qt.enable = true;

  xsession = {
    enable = true;
    windowManager.command = "env XCURSOR_PATH=$HOME/.nix-profile/share/icons ${pkgs.qtile}/bin/qtile start";
    pointerCursor = {
        package = pkgs.gnome.adwaita-icon-theme;
        name = "Adwaita";
        size=16;
    };
  };

}
