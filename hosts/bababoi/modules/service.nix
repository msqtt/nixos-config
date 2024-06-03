{ config, pkgs, ... }:
{

  systemd.services.nix-daemon.environment = {
    http_proxy = "http://127.0.0.1:20171";
    https_proxy = "http://127.0.0.1:20171";
  };
  services = {
    # List services that you want to enable:
    xserver.enable = true;

    # running on wayland
    displayManager.sddm.enable = true;
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
    tlp.enable = false;
    tailscale.enable = true;
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

