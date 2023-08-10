{ config, pkgs, ... }:
{
  security.sudo.wheelNeedsPassword = false;
  programs.fish.enable=true;
  users.users.alice = {
    shell = pkgs.fish;
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ]; # Enable ‘sudo’ for the user.
  };
}
