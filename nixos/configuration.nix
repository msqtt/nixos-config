# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/daed.nix
      ./modules/impermanence.nix
      ./modules/nixvim.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking = {
    hostName = "foobar"; # Define your hostname.
    networkmanager.enable = true;  # Easiest to use and most distros use this by default.
    # proxy = {
    #  default = "socks5+h://192.168.100.5:20170";
    # noProxy = "127.0.0.1,localhost,internal.domain";
    # };

    # Open ports in the firewall.
    # firewall.allowedTCPPorts = [ ... ];
    # firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    firewall.enable = false;
  };

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Select internationalisation properties.

  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      enabled = "fcitx5";
      fcitx5 = {
        plasma6Support = true;
        addons = with pkgs; [
          kdePackages.fcitx5-qt
          fcitx5-lua
          fcitx5-rime  # table input method support
          libsForQt5.fcitx5-configtool
          fcitx5-material-color
        ];
        settings.inputMethod = {
          "Groups/0" = {
            Name = "Default";
            "Default Layout"="us";
            DefaultIM ="rime";
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
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        source-han-sans
        source-han-serif
        fira-code
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

  environment = {
    variables = {
      EDITOR = "nvim";
      # LIBSEAT_BACKEND = "logind";
    };
  };

  # List services that you want to enable:
  services = {
    pipewire = {
      enable = true;
      pulse.enable = true;
    };

    libinput.enable = true;

    xserver.enable = true;
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    desktopManager.plasma6.enable = true;

    # Configure keymap in X11
    # services.xserver.xkb.layout = "us";
    # services.xserver.xkb.options = "eurosign:e,caps:escape";


    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;

    # Enable the X11 windowing system.
    # services.xserver.enable = true;

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
    doas = {
      enable = true;
      wheelNeedsPassword = false;

      extraRules = [{
        # Optional, retains environment variables while running commands
        # e.g. retains your NIX_PATH when applying your config
        keepEnv = true;
        persist = true;  # Optional, only require password verification a single time
      }];
    };
    sudo.enable = false;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    bob = {
      shell = pkgs.nushell;
      isNormalUser = true;
      extraGroups = [ "wheel" "audio" "video" "docker" ]; # Enable ‘sudo’ for the user.

      # To generate a hash to put in initialHashedPassword
      # you can do this:
      # $ nix-shell --run 'mkpasswd -m SHA-512 -s' -p mkpasswd
      initialHashedPassword = "$6$XlEEZPaxFP3XSnyU$9EWsAnGIVP3fPCegIrkvizhSGjUiKfknyP36HuhyDV6oQKnleGwgkE56qMy/LHITZkLb1sG7Xfx5TubyqKLUT.";
    };
    root.initialHashedPassword = "$6$VwGsxXTCOsNMIswT$av.cN.8UcXhSPofVWcceQSe41p1iVlhkwYfHoJgJx4LDUzy8ekg5HZ956lgRmlafjpGttWmuRUOmsrkpaiy6/0";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wl-clipboard
    tree
    gnumake
    wget
    curl
    git
    tldr
    btop
    iotop
    dust
    delta
    fzf
    bat
    fd
    ripgrep
    fastfetch
    # podman-compose
    docker-compose
  ];

  virtualisation = {
    docker.enable = true;
    podman = {
      enable = false;
      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
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