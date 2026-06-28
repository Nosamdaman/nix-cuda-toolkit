# This file contains a template for building a cuda toolkit package
{ pkgs, version, url, hash }: let
        install-env = pkgs.buildFHSEnv {
            name = "install-env";

            targetPkgs = pkgs: (with pkgs; [
                coreutils-full
                libxml2_13
                libtinfo
                ncurses
                gcc
                which
            ]);
        };
in pkgs.stdenv.mkDerivation {
    pname = "cuda-toolkit";
    version = version;

    src = pkgs.fetchurl {
        url = url;
        hash = hash;
    };

    nativeBuildInputs = with pkgs; [ autoPatchelfHook qt6.wrapQtAppsHook autoAddDriverRunpath ];

    buildInputs = with pkgs; [
        dbus
        fontconfig
        gcc
        glib
        gmp
        libgcc
        libglvnd
        libibmad
        libpng
        libtinfo
        libxkbfile
        libxml2_13
        libxshmfence
        ncurses
        nss
        numactl
        python311
        python312
        python313
        qt6.qtbase
        qt6.qtwayland
        wayland
        rdma-core
    ];

    autoPatchelfIgnoreMissingDeps = [
        "libcuda.so.1"
        "libnvidia-ml.so.1"
        "libpython3.8.so.1.0"
        "libpython3.9.so.1.0"
        "libpython3.10.so.1.0"
    ];

    dontUnpack = true;
    dontWrapQtApps = true;

    installPhase = ''
        runHook preInstall
        ${install-env}/bin/install-env $src --silent --no-man-page --toolkit --toolkitpath=$out
        runHook postInstall
    '';
}
