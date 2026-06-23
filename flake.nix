{
    description = "A flake for developing with CUDA";

    inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    outputs = { self, nixpkgs, ... }: let
        system = "x86_64-linux";
        pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
        };
        cuda-installer = pkgs.buildFHSEnv {
            pname = "cuda-installer";
            version = "13.3.0";

            targetPkgs = pkgs: (with pkgs; [
                coreutils-full
                libxml2
                libtinfo
                ncurses
                gcc
                which
            ]);

            runScript = "bash ${./cuda_13.3.0_610.43.02_linux.run}";
        };
    in {
        packages.${system}.default = pkgs.stdenv.mkDerivation {
            pname = "cuda-toolkit";
            version = "13.3.0";

            src = ./cuda_13.3.0_610.43.02_linux.run;

            nativeBuildInputs = with pkgs; [
                autoPatchelfHook
                cuda-installer
                dbus
                fontconfig
                gcc
                glib
                gmp
                libgcc
                libGL
                libibmad
                libpng
                libtinfo
                libxkbfile
                libxml2_13
                libxshmfence
                linuxPackages.nvidiaPackages.stable
                ncurses
                nss
                numactl
                python311
                python312
                python313
                qt6.qtbase
                qt6.wrapQtAppsHook
                rdma-core
            ];

            autoPatchelfIgnoreMissingDeps = [
                "libpython3.8.so.1.0"
                "libpython3.9.so.1.0"
                "libpython3.10.so.1.0"
            ];

            dontUnpack = true;

            installPhase = ''
                runHook preInstall
                ${cuda-installer}/bin/cuda-installer --silent --toolkit --toolkitpath=$out
                runHook postInstall
            '';
        };
    };
}
