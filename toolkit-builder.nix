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

    dontUnpack = true;
    dontFixup = true;

    installPhase = ''
        runHook preInstall
        ${install-env}/bin/install-env $src --silent --no-man-page --toolkit --toolkitpath=$out/cuda
        runHook postInstall
    '';

}
