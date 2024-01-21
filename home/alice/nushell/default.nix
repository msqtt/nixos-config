{ config, pkgs, ... }:
{
  programs.nushell = {
    enable = true;
    # The config.nu can be anywhere you want if you like to edit your Nushell with Nu
    # for editing directly to config.nu 
    extraConfig = ''
        def --env lt [] {
          let tmp = (mktemp)
          lf -last-dir-path $tmp
          try {
            let target_dir = (open --raw $tmp)
            rm -f $tmp
            try {
                if ($target_dir != $env.PWD) { cd $target_dir }
            } catch { |e| print -e $'lfcd: Can not change to ($target_dir): ($e | get debug)' }
          } catch {
            |e| print -e $'lfcd: Reading ($tmp) returned an error: ($e | get debug)'
          }
        }
      let carapace_completer = {|spans|
      carapace $spans.0 nushell $spans | from json
      }
      $env.config = {
       # color_config: $dark_theme
       show_banner: false,
       completions: {
       case_sensitive: false # case-sensitive completions
       quick: true    # set to false to prevent auto-selecting completions
       partial: true    # set to false to prevent partial filling of the prompt
       algorithm: "fuzzy"    # prefix or fuzzy
       external: {
       # set to false to prevent nushell looking into $env.PATH to find more suggestions
           enable: true 
       # set to lower can improve completion performance at the cost of omitting some options
           max_results: 100 
           completer: $carapace_completer # check 'carapace_completer' 
         }
       }
      } 
      $env.PATH = ($env.PATH | 
      split row (char esep) |
      prepend /home/myuser/.apps |
      append /usr/bin/env
      )

    '';
    environmentVariables = {
      LF_BOOKMARK_PATH = "~/.bookmark";
      PATH = "$HOME/bin;$PATH";
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
        tm = "tmux";
        fetch = "fastfetch";
        nsw = "doas nixos-rebuild switch";
        ns = "notify-send";
        "2z" = "${ap} trans :zh";
        "2e" = "${ap} trans :en";
      };
  };

  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };
}
