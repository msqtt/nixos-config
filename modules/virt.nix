{ config, pkgs, ... }:
{
  virtualisation.libvirtd.enable = true;
  # virt-manager requires dconf to remember settings
  programs.dconf.enable = true;
}
