{
  description = "Msqt's NixOS Flake";
  nixConfig = {
    substituters = [
      # "https://mirror.sjtu.edu.cn/nix-channels/store"
      # "https://mirrors.ustc.edu.cn/nix-channels/store"
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
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-4469e2.url = "github:NixOS/nixpkgs/4469e22700c47792f93daa882786d36f9bf8bc2a";
    nur.url = "github:nix-community/NUR";
    # here is my owe nur.
    my-nur = {
      url = "github:msqtt/my-nur";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nixvim = {
      # If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
      url = "github:nix-community/nixvim/nixos-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nur, ... }@inputs:
    let
      overlays = with inputs; [
        # neovim-nightly-overlay.overlay
        nur.overlay
        (final: prev: {
          my-nur = inputs.my-nur.packages."${prev.system}";
        })
      ];
    in
    {
      nixosConfigurations = {
        bababoi = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";

          specialArgs = {
            pkgs-4469e2 = import inputs.nixpkgs-4469e2 {
              system = system;
              config.allowUnfree = true;
            };
          };
          modules = [
            ./hosts/bababoi

            (args: { nixpkgs.overlays = overlays ++ import ./overlays args; })

            home-manager.nixosModules.home-manager
            nur.nixosModules.nur
            inputs.nixvim.nixosModules.nixvim
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
