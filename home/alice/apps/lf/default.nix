{ config, pkgs, ... }:
{
  home.file.".config/lf" = {
    source = ./conf;
    recursive = true;
    executable = true;
  };
}
