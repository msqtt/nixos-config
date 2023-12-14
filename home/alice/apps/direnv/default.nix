{ pkgs, ... }:
{
  home.file.".envrc".source = ./envrc;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
