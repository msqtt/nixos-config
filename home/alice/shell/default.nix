{ config, pkgs, ... }: 
{

  home.file.".config/fish" = {
    source = ./fish;
    recursive = true;
  };

  programs.fish = {
    enable = true;
    loginShellInit = ''
      # set fish_greeting # Disable greeting
      # environment
      set -x LF_BOOKMARK_PATH ~/.bookmark
      set PATH $HOME/bin $PATH
    '';
    interactiveShellInit = ''
      # init shit
      if test -n "$IN_NIX_SHELL"
        any-nix-shell fish --info-right | source
      end
      set_color -i cyan
        echo (direnv hook fish | source)
      set_color normal
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

