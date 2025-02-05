{
  description = "Configuration of My NixOS Foo";

  nixConfig = {
    # append the default substituters
    extra-substituters = [
      "https://cache.garnix.io"
      "https://niri.cachix.org"

      # nix community's cache server
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-c9faf2.url = "github:nixos/nixpkgs/c9faf24cd379be7e66de824393cc2584c025febe";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      #url = "github:nix-community/nixvim";
      # If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
      url = "github:nix-community/nixvim/nixos-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    daeuniverse.url = "github:daeuniverse/flake.nix";

    impermanence.url = "github:nix-community/impermanence";

    my-nur = {
      url = "github:msqtt/nur-packages";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri.url = "github:sodiboo/niri-flake";
  };

  outputs = { nixpkgs, home-manager, ... } @inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      pkgs-unstable = import inputs.nixpkgs-unstable { inherit system; };
      pkgs-c9faf2 = import inputs.nixpkgs-c9faf2 { inherit system; };

      my-nurpkgs = inputs.my-nur.legacyPackages.${system};
      overlays = builtins.attrValues my-nurpkgs.overlays
        ++ [
        (final: prev:
          let pkgs-unstable = (import inputs.nixpkgs-unstable { system = final.system; }); in {
            plasmusic-toolbar = pkgs-unstable.plasmusic-toolbar;
            application-title-bar = pkgs-unstable.application-title-bar;
            polonium = pkgs-unstable.polonium;
          })
      ] ++ (with inputs; [ niri.overlays.niri ]);

      specialArgs = { inherit inputs;
      my-nur = my-nurpkgs;
      pkgs-unstable = pkgs-unstable;
      pkgs-c9faf2 = pkgs-c9faf2;
      };
    in
    {
      formatter.x86_64-linux = pkgs.nixpkgs-fmt;

      nixosConfigurations.foo = nixpkgs.lib.nixosSystem {
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
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = specialArgs;
            home-manager.users.bob.imports = [ ./home-manager/home.nix ];
            home-manager.sharedModules = with inputs; [
              plasma-manager.homeManagerModules.plasma-manager
            ];
          }

        ] ++ (with inputs; [
          # other nixos modules
          daeuniverse.nixosModules.daed
          impermanence.nixosModules.impermanence
          nixvim.nixosModules.nixvim
          niri.nixosModules.niri
        ]);
      };
    };
}
