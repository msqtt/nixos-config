{ config, pkgs, ... }:
{
  nix.settings.trusted-users = [ "root" "alice" ];
  security.sudo.wheelNeedsPassword = false;
  programs.fish.enable=true;
  users.users.alice = {
    shell = pkgs.fish;
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ]; # Enable ‘sudo’ for the user.
  };
}
