{
  description = "Msqt's NixOS Flake";
  nixConfig = {
    substituters = [
      "https://mirror.sjtu.edu.cn/nix-channels/store"
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://cache.nixos.org/"
    ];
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://nixpkgs-wayland.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs-77ed358.url = "github:NixOS/nixpkgs/77ed358e3d7945116cd0641d10928b5ee14c4db1";
    nur.url = "github:nix-community/NUR";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { self, nixpkgs, home-manager, nur, ... }@inputs:
    let
      overlays = with inputs; [
        neovim-nightly-overlay.overlay
        nur.overlay
      ];
    in
    {
      nixosConfigurations = {
        bababoi = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";

          specialArgs = {
            # pkgs-77ed358 = import inputs.nixpkgs-77ed358 {
            #   system = system;
            #   config.allowUnfree = true;
            # };
          };
          modules = [
            ./hosts/bababoi

            (args: { nixpkgs.overlays = overlays ++ import ./overlays args; })

            home-manager.nixosModules.home-manager
            nur.nixosModules.nur
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.alice = import ./home/alice;
              # 使用 home-manager.extraSpecialArgs 自定义传递给 ./home.nix 的参数
              home-manager.extraSpecialArgs = specialArgs;
            }
          ];
        };
      };
    };
}
