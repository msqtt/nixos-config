{ config, pkgs, lib, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/env.nix # environment and system default apps
      ../../modules/service.nix
      ../../modules/user.nix
      ../../modules/font.nix
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
  hardware.opengl = {
		enable = true;
    driSupport = true; 
    driSupport32Bit = true; 
	};

  networking = {
    hostName = "bababoi";
    wireless.iwd.enable = true;
    firewall.enable = true;
    firewall.allowedTCPPorts = [ 2017 20170 20171 ];
    extraHosts = ''
      			125.217.53.138 mypi
      			125.217.53.186 kexie2
      			43.163.233.244 kexieserver	
      			107.174.247.79 ti
						114.132.248.191 xyzserver
						172.16.77.63 xyz1
						172.16.77.166 xyz2
						172.16.77.180 xyz3
      		'';
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
    xkbOptions = "ctrl:nocaps,altwin:swap_lalt_lwin";
    libinput = {
      enable = false;
      touchpad = {
        tapping = false;
        disableWhileTyping = true;
      };
    };
  };

  nix = {
    settings = {
      substituters = [ "https://mirrors.ustc.edu.cn/nix-channels/store" ];
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
    # "qq"
		"wemeet"
  ];

  # install docker
  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";
  };

  powerManagement.enable = true;

  system.stateVersion = "23.05"; # Did you read the comment?
}

