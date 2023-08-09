{ config, pkgs, ... }:

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
    };
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "bababoi";
    wireless.iwd.enable = true;
  };

  time.timeZone = "Asia/Shanghai";

  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  console = {
    font = "sun12x22";
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

  system.stateVersion = "23.05"; # Did you read the comment?
}

