{ config, pkgs, ... }:
{

  home.file.".config/fish" = {
    source = ./conf;
    recursive = true;
  };

  programs.starship = {
    enable = true;
    catppuccin.enable = true;
    settings = {
      add_newline = false;
    };
  };
  programs.fish = {
    enable = true;
    loginShellInit = ''
      # set fish_greeting # Disable greeting
      # environment
      # set -x LF_BOOKMARK_PATH $HOME/.bookmark
      # set PATH $HOME/bin $PATH
    '';
    interactiveShellInit = ''
      # init shit
      # if test -n "$IN_NIX_SHELL"
      #   any-nix-shell fish --info-right | source
      # end
      direnv hook fish | source
      set -x LF_BOOKMARK_PATH $HOME/.bookmark
      fish_add_path $HOME/bin
      zoxide init fish | source
    '';
    shellAbbrs =
      let
        nix-path = "~/nixos#bababoi";
      in
      {
        nbsf = "doas nixos-rebuild switch --flake ${nix-path}";
        nsw = "doas nixos-rebuild switch";
        tclk = "tty-clock -cs -C 5";
        nsh = "IN_NIX_SHELL=1 nix shell";
        nrun = "IN_NIX_SHELL=1 nix run";
      };

    shellAliases =
      let
        host = "127.0.0.1";
        http_port = "20171";
        socks5_port = "20170";
        http_proxy = "http://${host}:${http_port}";
        socks5_proxy = "socks5://${host}:${socks5_port}";
      in
      rec {
        ap = "http_proxy=${http_proxy} https_proxy=${http_proxy} all_proxy=${socks5_proxy}";
        eap = "export ${ap}";
        tm = "tmux";
        fetch = "fastfetch";
        ns = "notify-send";
        "2z" = "${ap} trans :zh";
        "2e" = "${ap} trans :en";
        lg = "lazygit";
      };
    plugins = [
      { name = "grc"; src = pkgs.fishPlugins.grc.src; }
      { name = "done"; src = pkgs.fishPlugins.done.src; }
      { name = "autopair"; src = pkgs.fishPlugins.autopair.src; }
      { name = "fzf"; src = pkgs.fishPlugins.fzf-fish.src; }
    ];
  };
}

