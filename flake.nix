{
    description = "A flake providing a more traditional CUDA Toolkit Experience";

    inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    outputs = { self, nixpkgs }: let
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
        builder = import ./template.nix;
    in {
        packages.${system} = {
            default = self.packages.${system}.cuda-toolkit_13_3;
            cuda-toolkit_13_3 = builder {
                inherit pkgs;
                version = "13.3.0";
                url = "https://developer.download.nvidia.com/compute/cuda/13.3.0/local_installers/cuda_13.3.0_610.43.02_linux.run";
                hash = "sha256-X3lIi1f+aTa8laVvm34oOKsvLuMxOxAIlCIG7r4GNS0=";
            };
        };
    };
}
