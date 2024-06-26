{ config, pkgs, lib, ... }:
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # environment and system default apps
      ./modules/env
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
    # initrd.kernelModules = [ "amdgpu" ];
    # extraModulePackages = with config.boot.kernelPackages; [
    #   v4l2loopback
    # ];
    # Use the systemd-boot EFI boot loader.
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
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

  i18n =
    let
      english = "en_US.UTF-8/UTF-8";
      chinese-utf = "zh_CN.UTF-8/UTF-8";
      chinese-gbk = "zh_CN.GBK/GBK";
    in
    {
      defaultLocale = "en_US.UTF-8";
      supportedLocales = [ english chinese-utf chinese-gbk ];
    };

  console = {
    font = "solar24x32";
    #keyMap = "us";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  nix = {
    optimise.automatic = true;
    settings = {
      substituters = [
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
  # nixpkgs.config.permittedInsecurePackages = [
  #   "nix-2.15.3"
  # ];
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "wemeet"
    "Oracle_VM_VirtualBox_Extension_Pack"
    "tabnine"
  ];

  powerManagement.enable = true;

  system.stateVersion = "23.05"; # Did you read the comment?
}

