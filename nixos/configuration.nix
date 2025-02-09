# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/daed.nix
      ./modules/impermanence.nix
      ./modules/nixvim.nix
      ./modules/stylix.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  zramSwap.enable = true;

  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking = {
    hostName = "foo"; # Define your hostname.
    networkmanager.enable = true; # Easiest to use and most distros use this by default.
    # proxy = {
    #  default = "socks5+h://192.168.100.5:20170";
    # noProxy = "127.0.0.1,localhost,internal.domain";
    # };

    # Open ports in the firewall.
    # firewall.allowedTCPPorts = [ ... ];
    # firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    firewall.enable = false;


    extraHosts = ''
      192.168.100.5 mypi
      125.217.52.212 kexie2
      43.163.233.244 kexieserver
      107.174.247.79 ti
      114.132.248.191 xyzserver
      8.219.10.91 myserver
    '';
  };

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Select internationalisation properties.

  documentation.dev.enable = true;

  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        # plasma6Support = true;
        addons = with pkgs; [
          kdePackages.fcitx5-qt
          fcitx5-lua
          fcitx5-rime # table input method support
          libsForQt5.fcitx5-configtool
          fcitx5-material-color
        ];
        settings.inputMethod = {
          "Groups/0" = {
            Name = "Default";
            "Default Layout" = "us";
            DefaultIM = "rime";
          };
          "Groups/0/Items/0" = {
            Name = "keyboard-us";
            Layout = "";
          };
          "Groups/0/Items/1" = {
            Name = "rime";
            Layout = "";
          };
          GroupOrder = {
            "0" = "Default";
          };
        };
      };
    };
  };
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      wqy_zenhei
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      source-han-sans
      source-han-serif
      fira-code
      terminus-nerdfont
    ];
    fontconfig = {
      defaultFonts = {
        emoji = [ "Noto Color Emoji" ];
        monospace = [
          "Fira Code"
          "Noto Sans Mono CJK SC"
        ];
        sansSerif = [
          "Noto Sans CJK SC"
          "Source Han Sans SC"
          "DejaVu Sans"
        ];
        serif = [
          "Noto Serif CJK SC"
          "Source Han Serif SC"
          "DejaVu Serif"
        ];
      };
    };
  };

  # List services that you want to enable:
  services = {

    # Enable the OpenSSH daemon.
    openssh = {
      enable = true;
    };

    pipewire = {
      enable = true;
      pulse.enable = true;
      jack.enable = true;
    };

    libinput.enable = true;

    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "workman";
        options = "ctrl:nocaps";
      };
    };

    displayManager = {
      # sddm = {
      #   enable = true;
      #   wayland.enable = true;
      # };

      cosmic-greeter.enable = true;
    };

    desktopManager = {
      # plasma6.enable = true;
      cosmic.enable = true;
    };

    # Configure keymap in X11
    # xserver.xkb.layout = "us";
    # xserver.xkb.options = "eurosign:e,caps:escape";

    # Enable the X11 windowing system.
    # xserver.enable = true;

    # Copy the NixOS configuration file and link it from the resulting system
    # (/run/current-system/configuration.nix). This is useful in case you
    # accidentally delete configuration.nix.
    # system.copySystemConfiguration = true;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  security = {
    # duosec.allowTcpForwarding = true;
    pam.services.swaylock = { };

    # memory unlimited for jack audio group 
    pam.loginLimits = [
      {
        domain = "@audio";
        item = "rtprio";
        type = "-";
        value = "95";
      }
      {
        domain = "@audio";
        item = "memlock";
        type = "-";
        value = "unlimited";
      }
    ];

    # rtkit is optional but recommended for pipewire
    rtkit.enable = true;

    doas = {
      enable = true;
      wheelNeedsPassword = false;

      extraRules = [{
        # Optional, retains environment variables while running commands
        # e.g. retains your NIX_PATH when applying your config
        keepEnv = true;
        persist = true; # Optional, only require password verification a single time
      }];
    };
    sudo.enable = false;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    bob = {
      shell = pkgs.nushell;
      isNormalUser = true;
      extraGroups = [ "wheel" "audio" "video" "docker" "vboxusers" ];

      # To generate a hash to put in initialHashedPassword
      # you can do this:
      # $ nix-shell --run 'mkpasswd -m SHA-512 -s' -p mkpasswd
      initialHashedPassword = "$6$XlEEZPaxFP3XSnyU$9EWsAnGIVP3fPCegIrkvizhSGjUiKfknyP36HuhyDV6oQKnleGwgkE56qMy/LHITZkLb1sG7Xfx5TubyqKLUT.";
    };
    root.initialHashedPassword = "$6$VwGsxXTCOsNMIswT$av.cN.8UcXhSPofVWcceQSe41p1iVlhkwYfHoJgJx4LDUzy8ekg5HZ956lgRmlafjpGttWmuRUOmsrkpaiy6/0";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {
    # plasma6.excludePackages = with pkgs.kdePackages; [
    #   konsole
    #   oxygen
    #   kate
    #   elisa
    # ];

    variables = {
      EDITOR = "nvim";
      # LIBSEAT_BACKEND = "logind";
      NIXOS_OZONE_WL = "1";
    };
    systemPackages = with pkgs; [
      # for linux man doc
      man-pages
      man-pages-posix

      # basic tools
      tree
      gnumake
      wget
      curl
      git

      # for monitor
      btop
      iotop

      # useful cli tools
      tldr
      dust
      delta
      fzf
      bat
      fd
      ripgrep
      zrythm
      # zellij

      unar
      xz
      p7zip

      # podman-compose
      docker-compose
      distrobox
      pfetch

      #  wayland composer
      wl-clipboard
      xsel
      cage
      xwayland-satellite-unstable
      libsecret
      gammastep
      mako
      swaybg
      swaylock
      mpv
      imv
    ];
  };

  programs = {
    niri = {
      enable = true;
      #package = pkgs.niri;
    };

    wshowkeys = {
      enable = true;
    };
  };

  virtualisation = {
    docker = {
      enable = true;
      storageDriver = "btrfs";
    };
    podman = {
      enable = false;
      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
    virtualbox.host = {
      enable = true;
      enableExtensionPack = true;
    };
  };


  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

}
