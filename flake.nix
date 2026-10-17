{
  description = "Configuration of My NixOS Foo";

  nixConfig = {
    # append the default substituters
    extra-substituters = [
      "https://cache.garnix.io"
      "https://niri.cachix.org"
      "https://cosmic.cachix.org/"

      # nix community's cache server
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
      "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-26.05";
    };

    nixpkgs-73cf49.url = "github:nixos/nixpkgs/73cf49b8ad837ade2de76f87eb53fc85ed5d4680";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      #url = "github:nix-community/nixvim";
      # If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
      url = "github:nix-community/nixvim/nixos-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # daeuniverse.url = "github:daeuniverse/flake.nix/refs/tags/dae-v0.8.0";
    daeuniverse.url = "github:daeuniverse/flake.nix";

    impermanence.url = "github:nix-community/impermanence";
    stylix.url = "github:danth/stylix/release-26.05";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    my-nur = {
      url = "github:msqtt/nur-packages";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri.url = "github:sodiboo/niri-flake";

    pi.url = "github:earendil-works/pi";

    hermes-agent.url = "github:NousResearch/hermes-agent";
  };

  outputs = { nixpkgs, home-manager, ... } @inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      pkgs-73cf49 = import inputs.nixpkgs-73cf49 { inherit system; };
      pkgs-unstable = import inputs.nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };

      my-nurpkgs = inputs.my-nur.legacyPackages.${system};
      overlays = builtins.attrValues my-nurpkgs.overlays
        ++ [ ] ++ (with inputs; [ niri.overlays.niri pi.overlays.default hermes-agent.overlays.default ]);

      specialArgs = {
        inherit inputs;
        my-nur = my-nurpkgs;
        pkgs-73cf49 = pkgs-73cf49;
        pkgs-unstable = pkgs-unstable;
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
              config = {
                allowUnfree = true;
                permittedInsecurePackages = [
                  "electron-39.8.10"
                ];
                allowUnfreePredicate = pkg: builtins.elem (inputs.lib.getName pkg) [
                 "cmp-emoji"
                ];
              };
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
            home-manager.sharedModules = [ ];
          }

        ] ++ (with inputs; [
          # other nixos modules
          daeuniverse.nixosModules.daed
          impermanence.nixosModules.impermanence
          nixvim.nixosModules.nixvim
          niri.nixosModules.niri
          stylix.nixosModules.stylix
          inputs.nur.modules.nixos.default
          # nixos-cosmic.nixosModules.default
        ]);
      };
    };
}
