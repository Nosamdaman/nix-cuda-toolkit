{
    description = "A flake providing a more traditional CUDA Toolkit Experience";

    inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    outputs = { self, nixpkgs }: let
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
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
    in {
        packages.${system} = {
            default = self.packages.${system}.cuda-toolkit_13_0;
            cuda-toolkit_13_3 = pkgs.stdenv.mkDerivation {
                pname = "cuda-toolkit";
                version = "13.3.0";

                src = pkgs.fetchurl {
                    url = "https://developer.download.nvidia.com/compute/cuda/13.3.0/local_installers/cuda_13.3.0_610.43.02_linux.run";
                    hash = "sha256-X3lIi1f+aTa8laVvm34oOKsvLuMxOxAIlCIG7r4GNS0=";
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
            };
        };
    };
}
