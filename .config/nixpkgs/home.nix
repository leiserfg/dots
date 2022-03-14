{ config, pkgs, ... }:

{
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

  home.sessionVariables = {
   # VK_ICD_FILENAMES="${nvidiaLibsOnly}/share/vulkan/icd.d/nvidia_icd.x86_64.json"
  };
  nixpkgs.overlays = [
      (import (
               builtins.fetchTarball {
               url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
               }))
  ];

 home.packages = with pkgs; [
    neovim-nightly
 ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.lf.enable = true;
  programs.mpv = {
      enable = true;
      scripts = [pkgs.mpvScripts.mpris];
  };


}
