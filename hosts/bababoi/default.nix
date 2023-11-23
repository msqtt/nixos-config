{ config, pkgs, lib, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/env.nix # environment and system default apps
      ./modules/service.nix
      ./modules/user.nix
      ./modules/font.nix
      ./modules/network.nix
      ./modules/virt.nix
    ];

  # hibernate resume config
  boot = {
    resumeDevice = "/dev/nvme0n1p5";
    supportedFilesystems = [ "ntfs" ];
    # for boot kernel modules
    initrd.kernelModules = [ "amdgpu" ];
    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
    # Use the systemd-boot EFI boot loader.
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
        # extraEntries = {
        #   "archlinux.conf" = ''
        #     title ArchLinux
        #     efi /efi/ARCH/grubx64.efi
        #   '';
        # };
      };
      efi.canTouchEfiVariables = true;
    };
  };


  swapDevices = [
    {
      device = "/dev/nvme0n1p5";
    }
  ];

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
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

  nix = {
    settings = {
      substituters = [
        # "https://mirror.sjtu.edu.cn/nix-channels/store"
        # "https://mirrors.ustc.edu.cn/nix-channels/store"
        "https://cache.nixos.org"
      ];
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
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
    "qq"
    "wemeet"
  ];

  powerManagement.enable = true;

  system.stateVersion = "23.05"; # Did you read the comment?
}

