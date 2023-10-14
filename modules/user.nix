{ config, pkgs, ... }:
{
  nix.settings.trusted-users = [ "root" "alice" ];
	security.sudo.enable = false;
	security.doas = {
		enable = true;
		wheelNeedsPassword = false;
	};
  programs.fish.enable=true;
  users.users.alice = {
    shell = pkgs.fish;
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "libvirtd" ];
		openssh.authorizedKeys.keys = [];
  };
}
