{ # # Nvidia informations.
# Version of the system kernel module. Let it to null to enable auto-detection.
nvidiaVersion ? null,
# Hash of the Nvidia driver .run file. null is fine, but fixing a value here
# will be more reproducible and more efficient.
nvidiaHash ? null,
# Alternatively, you can pass a path that points to a nvidia version file
# and let nixGL extract the version from it. That file must be a copy of
# /proc/driver/nvidia/version. Nix doesn't like zero-sized files (see
# https://github.com/NixOS/nix/issues/3539 ).
nvidiaVersionFile ? null,
# Enable 32 bits driver
# This is one by default, you can switch it to off if you want to reduce a
# bit the size of nixGL closure.
enable32bits ? true
, writeTextFile, shellcheck, pcre, runCommand, linuxPackages
, fetchurl, lib, runtimeShell, bumblebee, libglvnd, vulkan-validation-layers
, mesa, libvdpau-va-gl, intel-media-driver, vaapiIntel, pkgsi686Linux, driversi686Linux
, zlib, libdrm, xorg, wayland, gcc }:

rec {
    /*
    It contains the builder for different nvidia configuration, parametrized by
    the version of the driver and sha256 sum of the driver installer file.
    */
    nvidiaVersion = let
        data = builtins.readFile "/proc/driver/nvidia/version";
        versionMatch = builtins.match ".*Module  ([0-9.]+)  .*" data;
    in if versionMatch != null then builtins.head versionMatch else null;
    nvidiaPackages = rec {
      nvidiaDrivers = (linuxPackages.nvidia_x11.override { }).overrideAttrs
        (oldAttrs: rec {
          pname = "nvidia";
          src = let
            url =
              "https://download.nvidia.com/XFree86/Linux-x86_64/${nvidiaVersion}/NVIDIA-Linux-x86_64-${nvidiaVersion}.run";
          in builtins.fetchurl url;
          useGLVND = true;
        });

      nvidiaLibsOnly = nvidiaDrivers.override {
        libsOnly = true;
        kernel = null;
      };


      autoNvidia = nvidiaPackages {version = nvidiaVersionAuto; };
      nvidiaVars = {
            VK_LAYER_PATH=''${vulkan-validation-layers}/share/vulkan/explicit_layer.d"'';
            VK_ICD_FILENAMES=''${nvidiaLibsOnly}/share/vulkan/icd.d/nvidia_icd.json${
                  lib.optionalString enable32bits
                  ":${nvidiaLibsOnly.lib32}/share/vulkan/icd.d/nvidia_icd.json"
                }'';
            LD_LIBRARY_PATH=''${
                lib.makeLibraryPath ([ libglvnd nvidiaLibsOnly  vulkan-validation-layers]
                  ++ lib.optionals enable32bits [
                    nvidiaLibsOnly.lib32
                    pkgsi686Linux.libglvnd
                  ])
              }'' ;


    };

    intelVars = let
        mesa-drivers = [ mesa.drivers ]
          ++ lib.optional enable32bits pkgsi686Linux.mesa.drivers;
        intel-driver = [ intel-media-driver vaapiIntel ]
          # Note: intel-media-driver is disabled for i686 until https://github.com/NixOS/nixpkgs/issues/140471 is fixed
          ++ lib.optionals enable32bits [ /* pkgsi686Linux.intel-media-driver */ driversi686Linux.vaapiIntel ];
        libvdpau = [ libvdpau-va-gl ]
          ++ lib.optional enable32bits pkgsi686Linux.libvdpau-va-gl;
        glxindirect = runCommand "mesa_glxindirect" { } (''
          mkdir -p $out/lib
          ln -s ${mesa.drivers}/lib/libGLX_mesa.so.0 $out/lib/libGLX_indirect.so.0
        '');
        # generate a file with the listing of all the icd files
        icd = runCommand "mesa_icd" { } (
          # 64 bits icd
          ''
            ls ${mesa.drivers}/share/vulkan/icd.d/*.json > f
          ''
          #  32 bits ones
          + lib.optionalString enable32bits ''
            ls ${pkgsi686Linux.mesa.drivers}/share/vulkan/icd.d/*.json >> f
          ''
          # concat everything as a one line string with ":" as seperator
          + ''cat f | xargs | sed "s/ /:/g" > $out'');
      in {
        LIBGL_DRIVERS_PATH=lib.makeSearchPathOutput "lib" "lib/dri" mesa-drivers;
        LIBVA_DRIVERS_PATH=lib.makeSearchPathOutput "out" "lib/dri" intel-driver;
        LD_LIBRARY_PATH=''${lib.makeLibraryPath mesa-drivers}:${lib.makeSearchPathOutput "lib"
        "lib/vdpau" libvdpau}:${glxindirect}/lib:${lib.makeLibraryPath [libglvnd]}'';a
        VK_LAYER_PATH=''${vulkan-validation-layers}/share/vulkan/explicit_layer.d'';
        VK_ICD_FILENAMES="$(cat ${icd})";
    };

    auto = let
    in rec {
      # The output derivation contains nixGL which point either to
      # nixGLNvidia or nixGLIntel using an heuristic.
      nixGLDefault = if nvidiaVersionAuto != null then
        nixGLCommon autoNvidia.nixGLNvidia
      else
        nixGLCommon nixGLIntel;
    } // autoNvidia;
  };
in  {} )
