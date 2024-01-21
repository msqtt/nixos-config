{ config, pkgs, ... }:
{
  nix.settings.trusted-users = [ "root" "alice" ];
  security.polkit.enable = true;
  security.pam.services.swaylock = { };
  security.sudo.enable = false;
  security.doas = {
    enable = true;
    wheelNeedsPassword = false;
  };
  programs.fish.enable = true;
  users.users.alice = {
    shell = pkgs.fish;
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "libvirtd" "video" ];
    openssh.authorizedKeys.keys = [ ];
  };
}
