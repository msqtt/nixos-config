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
      set PATH $HOME/bin $PATH
    '';
    shellAbbrs =
    let
      nix-path = "~/nixos";
    in {
      nbsf="sudo nixos-rebuild switch --flake ${nix-path}";
      tclk="tty-clock -cs -C 5";
      nsh="IN_NIX_SHELL=1 nix shell";
      nrun="IN_NIX_SHELL=1 nix run";
    };
    shellAliases = {
      tm="tmux";
      pc="proxychains4";
    };
  };
}

