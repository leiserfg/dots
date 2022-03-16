{ config, pkgs, ... }:
let
  hardware = pkgs.callPackage ./hardware.nix {};
  hasNvidia = hardware.productName == "MS-7A38";
 in
{
  targets.genericLinux.enable = true;  # I don't use NixOS nor MacOS
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "leiserfg";
  home.homeDirectory = "/home/leiserfg";
  home.stateVersion = "22.05";

 nixpkgs.overlays = [
    (builtins.getFlake github:edolstra/nix-warez?dir=blender).overlay
    (builtins.getFlake github:nix-community/neovim-nightly-overlay).overlay
    ];


  home.sessionVariables = if hasNvidia then  hardware.nvidiaVars else hardware.intelVars;

  nixpkgs.config.allowUnfree = true;

 home.packages = with pkgs; [
    neovim-nightly
    pcmanfm
    krita
    poetry
 ]
 ++ builtins.map (x: pkgs.callPackage x {}) [
    ./packages/glslviwer.nix
 ]
 ++ pkgs.lib.optionals  hasNvidia [blender_3_1 lutris-unwrapped];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.fzf.enable = true;
  programs.lf.enable = true;
  programs.mpv = {
      enable = true;
      scripts = [pkgs.mpvScripts.mpris];
  };
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

 gtk = {
     enable = true;
     iconTheme = {
         package = pkgs.papirus-icon-theme;
         name = "Papirus-Dark";
    };
 };
 qt.enable = true;
}
