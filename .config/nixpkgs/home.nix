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

  home.sessionVariables = with pkgs; let
        mesa-drivers = [ mesa.drivers ]
          ++ lib.optional true pkgsi686Linux.mesa.drivers;
        intel-driver = [ intel-media-driver vaapiIntel ]
          # Note: intel-media-driver is disabled for i686 until https://github.com/NixOS/nixpkgs/issues/140471 is fixed
          ++ [driversi686Linux.vaapiIntel ];
        libvdpau = [ libvdpau-va-gl  pkgsi686Linux.libvdpau-va-gl];
        glxindirect = runCommand "mesa_glxindirect" { } (''
          mkdir -p $out/lib
          ln -s ${mesa.drivers}/lib/libGLX_mesa.so.0 $out/lib/libGLX_indirect.so.0
        '');
      in {
       # VK_ICD_FILENAMES="${nvidiaLibsOnly}/share/vulkan/icd.d/nvidia_icd.x86_64.json"
      LD_LIBRARY_PATH="${lib.makeLibraryPath mesa-drivers}:${lib.makeSearchPathOutput "lib" "lib/vdpau" libvdpau}:${glxindirect}/lib:${lib.makeLibraryPath [libglvnd]}";
      LIBGL_DRIVERS_PATH="${lib.makeSearchPathOutput "lib" "lib/dri" mesa-drivers}";
      LIBVA_DRIVERS_PATH="${lib.makeSearchPathOutput "out" "lib/dri" intel-driver}";
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
    pcmanfm
    krita
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
