# Function that builds the FHS environments
{ pkgs, toolkit-pkg, suffix }: pkgs.buildFHSEnv {
    name = "enter-cuda" + suffix;

    targetPkgs = pkgs: (with pkgs; [
        toolkit-pkg
        coreutils-full
        dbus
        elfutils
        fish
        fontconfig
        gcc
        glib
        libcap
        libglvnd
        libpng
        libtinfo
        libtree
        libx11
        libxcb
        libXi
        libxkbcommon
        libxkbfile
        libxml2_13
        ncurses
        nspr
        nss
        openssl
        python3
        (python314.withPackages (python-pkgs: with python-pkgs; [ virtualenv pip ]))
        (python313.withPackages (python-pkgs: with python-pkgs; [ virtualenv pip ]))
        (python312.withPackages (python-pkgs: with python-pkgs; [ virtualenv pip ]))
        qt6.qtbase
        qt6.qtwayland
        wayland
        which
        zstd
    ]);

    runScript = "fish";
}
