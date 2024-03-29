{ config, pkgs, ... }:
{
  virtualisation =
    {
      docker = {
        enable = true;
        package = pkgs.docker_20_10;
        storageDriver = "btrfs";
      };
      podman = {
        enable = true;

        # Create a `docker` alias for podman, to use it as a drop-in replacement
        dockerCompat = false;

        # Required for containers under podman-compose to be able to talk to each other.
        defaultNetwork.settings.dns_enabled = true;
      };
      libvirtd = {
        enable = false;
        extraConfig = ''uri_default = "qemu:///system"'';
      };
    };
  # virt-manager requires dconf to remember settings
  programs.dconf.enable = true;
}
