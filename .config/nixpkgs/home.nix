{ config, pkgs, ... }:

let nixGL = (pkgs.callPackage "${builtins.fetchTarball {
      url = https://github.com/guibou/nixGL/archive/17c1ec63b969472555514533569004e5f31a921f.tar.gz;
      sha256 = "0yh8zq746djazjvlspgyy1hvppaynbqrdqpgk447iygkpkp3f5qr";
    }}/nixGL.nix"
  { }).nixGLDefault;
in
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
  nixpkgs.config.allowUnfree = true;
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
  programs.fzf.enable = true;
  programs.lf.enable = true;
  programs.mpv = {
      enable = true;
      # scripts = [pkgs.mpvScripts.mpris];
      package =
          pkgs.writeShellScriptBin "mpv" ''
          #!/bin/sh
          ${nixGL}/bin/nixGL ${pkgs.mpv}/bin/mpv "$@"
          '';
  };


}
