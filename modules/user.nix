{ config, pkgs, ... }:
{
  security.sudo.wheelNeedsPassword = false;
  programs.fish.enable=true;
  users.users.alice = {
    shell = pkgs.fish;
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };
}
