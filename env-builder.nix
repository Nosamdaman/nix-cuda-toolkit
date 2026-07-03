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
        glew
        glfw
        glib
        glm
        gmp
        libcap
        libGLU
        libglut
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
        mpi
        ncurses
        nspr
        nss
        openssl
        pkg-config
        python3
        (python312.withPackages (python-pkgs: with python-pkgs; [ virtualenv pip ]))
        (python313.withPackages (python-pkgs: with python-pkgs; [ virtualenv pip ]))
        (python314.withPackages (python-pkgs: with python-pkgs; [ virtualenv pip ]))
        qt6.qtbase
        qt6.qtwayland
        vulkan-headers
        vulkan-loader
        wayland
        which
        xorgproto
        zstd
    ]);

    extraOutputsToInstall = [ "dev" ];

    runScript = "env CMAKE_INCLUDE_PATH=/usr/include CMAKE_LIBRARY_PATH=/usr/lib CUDA_HOME=${toolkit-pkg}/cuda PATH=${toolkit-pkg}/cuda/bin:$PATH CC=gcc CXX=g++ fish";
}
