{ config, pkgs, ... }: 
{

  home.file.".config/fish" = {
    source = ./fish;
    recursive = true;
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      #set fish_greeting # Disable greeting
      set -x LF_BOOKMARK_PATH ~/.bookmark
    '';
    shellAbbrs =
    let
      nix-path = "~/nixos";
    in {
      nbsf="sudo nixos-rebuild switch --flake ${nix-path}";
      tclk="tty-clock -cs -C 5";
      tm="tmux";
    };
    shellAliases = {
      tm="tmux";
    };
  };
}

