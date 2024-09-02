{ config, pkgs, ... }:
{

  # systemd.services.nix-daemon.environment = {
  #   http_proxy = "http://127.0.0.1:20171";
  #   https_proxy = "http://127.0.0.1:20171";
  # };
  services = {
    # List services that you want to enable:
    xserver.enable = true;

    # running on wayland
    displayManager.sddm= {
      enable = true;
      catppuccin = {
        enable = true;
        background = /home/alice/Pictures/bg/nixos-wallpaper-catppuccin-mocha.png;
      };
    };

    desktopManager.plasma6.enable = true;

    # Enable the OpenSSH daemon.
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };
    #
    # v2raya proxy
    v2raya.enable = true;
    # daed - dae with a web dashboard
    daed = {
       enable = true;

       openFirewall = {
         enable = true;
         port = 12345;
       };

       /* default options

       package = inputs.daeuniverse.packages.x86_64-linux.daed;
       configDir = "/etc/daed";
       listen = "127.0.0.1:2023";

       */
    };

    tlp.enable = false;
    tailscale.enable = false;
    # keybord layout shit.
    xserver.xkb = {
      layout = "us";
      variant = "workman";
      options = "ctrl:nocaps";
    };
    libinput = {
      enable = true;
      touchpad = {
        tapping = true;
        disableWhileTyping = true;
      };
    };
  };

}

