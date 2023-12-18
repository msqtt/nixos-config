{ config, pkgs, ... }:
{
  virtualisation = {
    docker = {
      enable = true;
      package = pkgs.docker_20_10;
      storageDriver = "btrfs";
    };

    libvirtd = {
      enable = true;
      extraConfig = ''uri_default = "qemu:///system"'';
    };
  };
  # virt-manager requires dconf to remember settings
  programs.dconf.enable = true;
}
