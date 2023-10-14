{ config, pkgs, ... }:
{
  virtualisation.libvirtd = {
    enable = true;
    extraConfig = ''
      			uri_default = "qemu:///system"
      		'';
  };
  # virt-manager requires dconf to remember settings
  programs.dconf.enable = true;
}
