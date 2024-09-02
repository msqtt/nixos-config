{ config, pkgs, ... }:
{
  documentation = {
    enable = true;
    man.enable = true;
    info.enable = true;
    dev.enable = true;
  };
}
