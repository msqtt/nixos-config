{ config, pkgs, ... }:
{

  systemd.services.nix-daemon.environment = {
    socks5_proxy = "socks5://127.0.0.1:20170";
    http_proxy = "http://127.0.0.1:20171";
    https_proxy = "http://127.0.0.1:20171";
  };
  environment.plasma5.excludePackages = with pkgs.libsForQt5; [
    oxygen
    konsole
  ];
  services = {
    # List services that you want to enable:
    # Enable the OpenSSH daemon.
    xserver = {
      enable = true;
      displayManager.sddm.enable = true;
      # running on wayland
      displayManager.defaultSession = "plasmawayland";
      desktopManager.plasma5.enable = true;
    };
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };
    #
    # for audio editting
    pipewire.jack.enable = false;
    jack.jackd.enable = false;
    # v2raya proxy
    v2raya.enable = true;
    tlp.enable = false;
    tailscale.enable = true;
    # keybord layout shit.
    xserver = {
      layout = "us";
      xkbVariant = "workman";
      xkbOptions = "ctrl:nocaps";
      libinput = {
        enable = false;
        touchpad = {
          tapping = false;
          disableWhileTyping = true;
        };
      };
    };
  };

}
