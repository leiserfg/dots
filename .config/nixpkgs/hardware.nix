{
enable32bits ? true
, runCommand, linuxPackages
, fetchurl, lib, runtimeShell, libglvnd, vulkan-validation-layers
, mesa, libvdpau-va-gl, intel-media-driver, vaapiIntel, pkgsi686Linux, driversi686Linux,
vulkan-loader , xorg, libICE, intel-compute-runtime
}:
rec {
    /*
    It contains the builder for different nvidia configuration, parametrized by
    the version of the driver and sha256 sum of the driver installer file.
    */
    nvidiaVersion = let
        data = builtins.readFile "/proc/driver/nvidia/version";
        versionMatch = builtins.match ".*Module  ([0-9.]+)  .*" data;
    in if versionMatch != null then builtins.head versionMatch else null;
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

      nvidiaVars = {
            VK_LAYER_PATH="${vulkan-validation-layers}/share/vulkan/explicit_layer.d";
            VK_ICD_FILENAMES=''${nvidiaLibsOnly}/share/vulkan/icd.d/nvidia_icd.x86_64.json${
                  lib.optionalString enable32bits
                  ":${nvidiaLibsOnly.lib32}/share/vulkan/icd.d/nvidia_icd.i686.json"
                }'';
            OCL_ICD_VENDORS="${nvidiaLibsOnly}/etc/OpenCL/vendors/";
            LD_LIBRARY_PATH=''${
                lib.makeLibraryPath ([ libglvnd nvidiaLibsOnly  vulkan-validation-layers]
                  ++ lib.optionals enable32bits [
                    nvidiaLibsOnly.lib32
                    pkgsi686Linux.libglvnd
                    vulkan-loader
                    libICE
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
        "lib/vdpau" libvdpau}:${lib.makeLibraryPath [glxindirect libglvnd  vulkan-loader libICE]}'';
        VK_LAYER_PATH=''${vulkan-validation-layers}/share/vulkan/explicit_layer.d'';
        VK_ICD_FILENAMES="$(cat ${icd})";
        OCL_ICD_VENDORS="${intel-compute-runtime}/etc/OpenCL/vendors/";
    };
    productName = builtins.replaceStrings ["\n"] [""] (lib.readFile "/sys/class/dmi/id/product_name");
}
