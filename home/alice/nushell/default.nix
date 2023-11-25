{ config, pkgs, ... }:
{
  programs.nushell = {
    enable = true;
    # The config.nu can be anywhere you want if you like to edit your Nushell with Nu
    # for editing directly to config.nu 
    extraConfig = ''
      def-env lfcd [] {
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
              let dark_theme = {
              separator: "#e5e9f0"
              leading_trailing_space_bg: { attr: "n" }
              header: { fg: "#a3be8c" attr: "b" }
              empty: "#81a1c1"
              bool: {|| if $in { "#88c0d0" } else { "light_gray" } }
              int: "#e5e9f0"
              filesize: {|e|
                  if $e == 0b {
                      "#e5e9f0"
                  } else if $e < 1mb {
                      "#88c0d0"
                  } else {{ fg: "#81a1c1" }}
              }
              duration: "#e5e9f0"
              date: {|| (date now) - $in |
                  if $in < 1hr {
                      { fg: "#bf616a" attr: "b" }
                  } else if $in < 6hr {
                      "#bf616a"
                  } else if $in < 1day {
                      "#ebcb8b"
                  } else if $in < 3day {
                      "#a3be8c"
                  } else if $in < 1wk {
                      { fg: "#a3be8c" attr: "b" }
                  } else if $in < 6wk {
                      "#88c0d0"
                  } else if $in < 52wk {
                      "#81a1c1"
                  } else { "dark_gray" }
              }
              range: "#e5e9f0"
              float: "#e5e9f0"
              string: "#e5e9f0"
              nothing: "#e5e9f0"
              binary: "#e5e9f0"
              cellpath: "#e5e9f0"
              row_index: { fg: "#a3be8c" attr: "b" }
              record: "#e5e9f0"
              list: "#e5e9f0"
              block: "#e5e9f0"
              hints: "dark_gray"
              search_result: { fg: "#bf616a" bg: "#e5e9f0" }

              shape_and: { fg: "#b48ead" attr: "b" }
              shape_binary: { fg: "#b48ead" attr: "b" }
              shape_block: { fg: "#81a1c1" attr: "b" }
              shape_bool: "#88c0d0"
              shape_custom: "#a3be8c"
              shape_datetime: { fg: "#88c0d0" attr: "b" }
              shape_directory: "#88c0d0"
              shape_external: "#88c0d0"
              shape_externalarg: { fg: "#a3be8c" attr: "b" }
              shape_filepath: "#88c0d0"
              shape_flag: { fg: "#81a1c1" attr: "b" }
              shape_float: { fg: "#b48ead" attr: "b" }
              shape_garbage: { fg: "#FFFFFF" bg: "#FF0000" attr: "b" }
              shape_globpattern: { fg: "#88c0d0" attr: "b" }
              shape_int: { fg: "#b48ead" attr: "b" }
              shape_internalcall: { fg: "#88c0d0" attr: "b" }
              shape_list: { fg: "#88c0d0" attr: "b" }
              shape_literal: "#81a1c1"
              shape_match_pattern: "#a3be8c"
              shape_matching_brackets: { attr: "u" }
              shape_nothing: "#88c0d0"
              shape_operator: "#ebcb8b"
              shape_or: { fg: "#b48ead" attr: "b" }
              shape_pipe: { fg: "#b48ead" attr: "b" }
              shape_range: { fg: "#ebcb8b" attr: "b" }
              shape_record: { fg: "#88c0d0" attr: "b" }
              shape_redirection: { fg: "#b48ead" attr: "b" }
              shape_signature: { fg: "#a3be8c" attr: "b" }
              shape_string: "#a3be8c"
              shape_string_interpolation: { fg: "#88c0d0" attr: "b" }
              shape_table: { fg: "#81a1c1" attr: "b" }
              shape_variable: "#b48ead"

              background: "#2e3440"
              foreground: "#e5e9f0"
              cursor: "#e5e9f0"
            }
              let carapace_completer = {|spans|
              carapace $spans.0 nushell $spans | from json
              }
              $env.config = {
               color_config: $dark_theme
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
