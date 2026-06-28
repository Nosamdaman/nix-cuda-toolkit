{
    description = "A flake providing a more traditional CUDA Toolkit Experience";

    inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    outputs = { self, nixpkgs }: let
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
        builder = import ./toolkit-builder.nix;
        env-builder = import ./env-builder.nix;
    in {
        packages.${system} = {
            default = self.packages.${system}.cuda-devenv_13_3;
            cuda-toolkit_13_3 = builder {
                inherit pkgs;
                version = "13.3.0";
                url = "https://developer.download.nvidia.com/compute/cuda/13.3.0/local_installers/cuda_13.3.0_610.43.02_linux.run";
                hash = "sha256-X3lIi1f+aTa8laVvm34oOKsvLuMxOxAIlCIG7r4GNS0=";
            };
            cuda-devenv_13_3 = env-builder {
                inherit pkgs;
                toolkit-pkg = self.packages.${system}.cuda-toolkit_13_3;
                suffix = "_13_3";
            };
            cuda-toolkit_13_0 = builder {
                inherit pkgs;
                version = "13.0.3";
                url = "https://developer.download.nvidia.com/compute/cuda/13.0.3/local_installers/cuda_13.0.3_580.126.20_linux.run";
                hash = "sha256-ecgsZSnSrfwyIzbzeyp6hWZVzXObSAPQr3NE21ppY4s=";
            };
            cuda-devenv_13_0 = env-builder {
                inherit pkgs;
                toolkit-pkg = self.packages.${system}.cuda-toolkit_13_0;
                suffix = "_13_0";
            };
            cuda-toolkit_12_8 = builder {
                inherit pkgs;
                version = "12.8.2";
                url = "https://developer.download.nvidia.com/compute/cuda/12.8.2/local_installers/cuda_12.8.2_570.211.01_linux.run";
                hash = "sha256-g25JhoGWbPRLa5+zTWX2ck/pqNG2RHCgQNRtEkIc3iI=";
            };
            cuda-devenv_12_8 = env-builder {
                inherit pkgs;
                toolkit-pkg = self.packages.${system}.cuda-toolkit_12_8;
                suffix = "_12_8";
            };
        };
    };
}
