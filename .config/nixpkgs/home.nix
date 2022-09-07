{ config, pkgs, ... }:
let
  hardware = pkgs.callPackage ./hardware.nix { };
  isThePc = "shiralad" == hardware.hostName;
  isTheThinkpad = "dunkel" == hardware.hostName;
  isAComputer = isThePc || isTheThinkpad;
in
{
  targets.genericLinux.enable = true; # I don't use NixOS nor MacOS
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "leiserfg";
  home.homeDirectory = "/home/leiserfg";
  home.stateVersion = "22.05";

  nixpkgs.overlays = [
    (builtins.getFlake github:edolstra/nix-warez?dir=blender).overlays.default
    (builtins.getFlake github:leiserfg/leiserfg-overlay).overlays.default
    (builtins.getFlake github:nix-community/neovim-nightly-overlay).overlay
  ];


  home.sessionVariables = (if isThePc then hardware.nvidiaVars else if isTheThinkpad then
  hardware.intelVars else {});
  # // let distroTerminfoDirs = concatStringsSep ":" [
  #       "/etc/terminfo" # debian, fedora, gentoo
  #       "/lib/terminfo" # debian
  #       "/usr/share/terminfo" # package default, all distros
  #     ];
  #   in {
  #     NIX_PATH = "$HOME/.nix-defexpr/channels\${NIX_PATH:+:}$NIX_PATH";
  #     TERMINFO_DIRS =
  #       "$HOME/.nix-profile/share/terminfo:$TERMINFO_DIRS\${TERMINFO_DIRS:+:}${distroTerminfoDirs}";
  #   };
  # };
  # { TERMINFO_DIRS = "/home/leiserfg/.nix-profile/share/terminfo";};

    nixpkgs.config = {
      allowUnfree = true;
      packageOverrides = pkgs: {
        nixos = import <nixos> {
          config = config.nixpkgs.config;
        };
      };
    };

  home.packages = with pkgs; with builtins; with lib; [
    termusic
    pipewire
    neovim-unwrapped
    anki
    # (nixos.discord)
    # This has to be available for treesitter to build the parsers
    javx
    gcc
    nodePackages.npm
    controllermap
    pcmanfm
    krita
    poetry
    (getAttr system (getFlake github:bennofs/nix-index).defaultPackage)
    (iosevka-bin.override{variant="sgr-iosevka-term-ss07";})
    pandoc
    # nix-update
    python310Packages.ipython
    python310Packages.pip
    darktable
    gimp
    kitty
    fish
    lightlocker
    rofi
    dwarfs
    yt-dlp
    mediainfo
    picom
    dogdns
    unclutter
    awesome
    pasystray
    pavucontrol
    tdesktop
    firefox
    zathura
    mupdf
    brave
    calibre
    nsxiv
    xdragon
    arandr
    xcwd
    moreutils
    typos
    lf
    fzf
    bat
    zoxide
    ripgrep
    rust-analyzer-unwrapped
    # git stuff
    delta
    sshuttle
    gh
    git
    git-standup
    act
    # nix-du
    patool
    stylua
    autorandr
    godot
      # blender_3_1
      blender
  ]
  ++ map (x: pkgs.callPackage ("${./packages}/${x}") { })
         (filter (hasSuffix ".nix")
                 (attrNames (readDir ./packages)))
  ++ pkgs.lib.optionals isTheThinkpad [
    slack
    insomnia
    terraform-ls
    winetricks
    # wineWowPackages.staging
  ]
  ++ pkgs.lib.optionals isThePc [
      dxvk
      luajitPackages.ldoc
      # lutris-free
      # wineWowPackages.unstable
      cabextract
# for debugging the keyboad
# tio
  ];

  services.caffeine.enable = true;
  services.udiskie = {
      enable = true;
      automount = true;
  };
  services.mpris-proxy.enable = true;
  services.dunst = {
      enable = false;
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
              format = "%s %p\\n%b";
              transparency = 15;
              follow = "mouse";
              show_indicators = "yes";
              mouse_right = "do_action";
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
  fonts.fontconfig.enable = true;

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
    # windowManager.command = "${pkgs.}/bin/qtile start";
    windowManager.command = "awesome";
  };
  home.pointerCursor = {
        package = pkgs.gnome.adwaita-icon-theme;
        name = "Adwaita";
        size=16;
        x11.enable=true;
    };
}
