{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/env.nix # environment and system default apps
      ../../modules/service.nix
      ../../modules/user.nix
      ../../modules/font.nix
      ../../modules/proxy.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot = {
      enable = true; 
      configurationLimit = 10;
      extraEntries = {
        "archlinux.conf" = ''
          title ArchLinux
          efi /efi/ARCH/grubx64.efi
        '';
      };

    };
    efi.canTouchEfiVariables = true;
  };

  # hibernate resume config
  boot.resumeDevice = "/dev/nvme0n1p5";

  networking = {
    hostName = "bababoi";
    wireless.iwd.enable = true;
  };

  time.timeZone = "Asia/Shanghai";

  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  console = {
    font = "solar24x32";
    #keyMap = "us";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  # keybord layout shit.
  services.xserver = {
      layout = "us";
      xkbVariant = "workman";
      xkbOptions = "ctrl:nocaps";
    };

  nix = {
    settings = {
      substituters = [ "https://mirrors.ustc.edu.cn/nix-channels/store" ]; 
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1w";
    };
  };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
  };

  # Enable bluetooth
  hardware.bluetooth.enable = true;

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    # "qq"
  ];

  # install docker
  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";
  };

  powerManagement.enable = true;

  system.stateVersion = "23.05"; # Did you read the comment?
}

