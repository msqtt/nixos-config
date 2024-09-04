{
  description = "Configuration of Bob's NixOS";

  nixConfig = {
    # append the default substituters
    extra-substituters = [
      "https://cache.garnix.io"

      # nix community's cache server
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    daeuniverse.url = "github:daeuniverse/flake.nix";

    impermanence.url = "github:nix-community/impermanence";

    my-nur = {
      url = "github:msqtt/nur-packages";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... } @inputs:
    let
      system = "x86_64-linux";
      overlays = builtins.attrValues inputs.my-nur.legacyPackages.${system}.overlays;
      specialArgs = { inherit inputs ; };
    in {
      nixosConfigurations.foobar = nixpkgs.lib.nixosSystem {
          specialArgs = specialArgs;
          modules = [
            # substituters
            {
              nix.settings.trusted-users = [ "bob" ];
              nix.settings = {
                substituters = [
                  # cache mirror located in China
                  # status: https://mirror.sjtu.edu.cn/
                  # "https://mirror.sjtu.edu.cn/nix-channels/store"
                  # status: https://mirrors.ustc.edu.cn/status/
                  "https://mirrors.ustc.edu.cn/nix-channels/store"
                  "https://cache.nixos.org"
                ];
              };
              
            }

            { 
              nixpkgs = {
                config.allowUnfree = true;
                overlays = overlays;
              };
            }

            # system config
            ./nixos/configuration.nix

            # home config
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.extraSpecialArgs = specialArgs;
              home-manager.users.bob.imports= [ ./home-manager/home.nix ];
            }

          ] ++ (with inputs; [
              daeuniverse.nixosModules.daed
              impermanence.nixosModules.impermanence
          ]);
      };
  };
}
