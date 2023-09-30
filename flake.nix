{
  description = "Msqt's NixOS Flake";
  nixConfig = {
    substituters = [
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://cache.nixos.org/"
    ];
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-ad97212.url = "github:NixOS/nixpkgs/ad97212346a23bd1c1a47f8c34429bb55ea9b5c2";
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
            pkgs-ad97212 = import inputs.nixpkgs-ad97212 {
              system = system;
              # 允许安装非自由软件
              # config.allowUnfree = true;
            };
          };
          modules = [
            ./hosts/bababoi
            ({ nixpkgs.overlays = overlays; })
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
