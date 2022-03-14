{ config, pkgs, ... }:

{
  targets.genericLinux.enable = true;  # I don't use NixOS nor MacOS

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "leiserfg";
  home.homeDirectory = "/home/leiserfg";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  home.sessionVariables = let
  hardware = pkgs.callPackage ./hardware.nix {};
  in
    if hardware.productName == "MS-7A38" then  hardware.nvidiaVars else hardware.intelVars;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
      (import (
               builtins.fetchTarball {
               url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
               }))
  ];

 home.packages = with pkgs; [
    neovim-nightly
    pcmanfm
    krita
    (writeScriptBin "vim" ''
     exec ${ neovim-nightly }/bin/nvim "$@"
     '')
    (writeScriptBin "vi" ''
     exec ${ neovim-nightly }/bin/nvim "$@"
     '')
    (writeScriptBin "vimdiff" ''
     exec ${ neovim-nightly }/bin/nvim -d "$@"
     '')
 ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.fzf.enable = true;
  programs.lf.enable = true;
  programs.mpv = {
      enable = true;
      scripts = [pkgs.mpvScripts.mpris];
  };
 gtk = {
     enable = true;
     iconTheme = {
         package = pkgs.papirus-icon-theme;
         name = "Papirus-Dark";
    };
 };
 qt.enable = true;
}
