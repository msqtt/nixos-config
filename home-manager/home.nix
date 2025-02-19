{ config, pkgs, ... } @inputs:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "bob";
  home.homeDirectory = "/home/bob";

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    firefox
    chromium
    thunderbird
    vscode.fhs
    libreoffice-qt
    jetbrains.idea-ultimate
    obs-studio
    feishu
    gimp
    pavucontrol
    blueberry
    zrythm
  ] ++ (with inputs.my-nur; [
    bobibo
    jbl
  ]) ++ (with inputs.pkgs-c9faf2; [
    musescore
  ]);
  programs = {
    git = {
      enable = true;
      userName = "msqtt";
      userEmail = "mosquito@email.cn";
      aliases = {
        ci = "commit";
        co = "checkout";
        s = "status";
      };
    };

    gh = {
      enable = true;
      settings.git_protocol = "ssh";
    };

    lazygit = {
      enable = true;
      settings = {
        gui.showIcons = false;
      };
    };
  };


  programs = {
    nushell = {
      enable = true;
      # The config.nu can be anywhere you want if you like to edit your Nushell with Nu
      # configFile.source = ./.../config.nu;
      # for editing directly to config.nu 
      extraConfig = ''
        let catppuccin = {
          latte: {
            rosewater: "#dc8a78"
            flamingo: "#dd7878"
            pink: "#ea76cb"
            mauve: "#8839ef"
            red: "#d20f39"
            maroon: "#e64553"
            peach: "#fe640b"
            yellow: "#df8e1d"
            green: "#40a02b"
            teal: "#179299"
            sky: "#04a5e5"
            sapphire: "#209fb5"
            blue: "#1e66f5"
            lavender: "#7287fd"
            text: "#4c4f69"
            subtext1: "#5c5f77"
            subtext0: "#6c6f85"
            overlay2: "#7c7f93"
            overlay1: "#8c8fa1"
            overlay0: "#9ca0b0"
            surface2: "#acb0be"
            surface1: "#bcc0cc"
            surface0: "#ccd0da"
            crust: "#dce0e8"
            mantle: "#e6e9ef"
            base: "#eff1f5"
          }
          mocha: {
            rosewater: "#f5e0dc"
            flamingo: "#f2cdcd"
            pink: "#f5c2e7"
            mauve: "#cba6f7"
            red: "#f38ba8"
            maroon: "#eba0ac"
            peach: "#fab387"
            yellow: "#f9e2af"
            green: "#a6e3a1"
            teal: "#94e2d5"
            sky: "#89dceb"
            sapphire: "#74c7ec"
            blue: "#89b4fa"
            lavender: "#b4befe"
            text: "#cdd6f4"
            subtext1: "#bac2de"
            subtext0: "#a6adc8"
            overlay2: "#9399b2"
            overlay1: "#7f849c"
            overlay0: "#6c7086"
            surface2: "#585b70"
            surface1: "#45475a"
            surface0: "#313244"
            base: "#1e1e2e"
            mantle: "#181825"
            crust: "#11111b"
          }
        }

        # Regenerate with `run-external --redirect-stdout "nix" "run" "nixpkgs#vivid" "--" "generate" "catppuccin-mocha" | str trim | xclip -sel cl`
        # $env.LS_COLORS = ((cat ~/.config/nushell/ls-colors) | str trim)

        let stheme = $catppuccin.mocha
        let theme = {
          separator: $stheme.overlay0
          leading_trailing_space_bg: $stheme.overlay0
          header: $stheme.green
          date: $stheme.mauve
          filesize: $stheme.blue
          row_index: $stheme.pink
          bool: $stheme.peach
          int: $stheme.peach
          duration: $stheme.peach
          range: $stheme.peach
          float: $stheme.peach
          string: $stheme.green
          nothing: $stheme.peach
          binary: $stheme.peach
          cellpath: $stheme.peach
          hints: dark_gray

          shape_garbage: { fg: $stheme.crust bg: $stheme.red attr: b }
          shape_bool: $stheme.blue
          shape_int: { fg: $stheme.mauve attr: b}
          shape_float: { fg: $stheme.mauve attr: b}
          shape_range: { fg: $stheme.yellow attr: b}
          shape_internalcall: { fg: $stheme.blue attr: b}
          shape_external: { fg: $stheme.blue attr: b}
          shape_externalarg: $stheme.text 
          shape_literal: $stheme.blue
          shape_operator: $stheme.yellow
          shape_signature: { fg: $stheme.green attr: b}
          shape_string: $stheme.green
          shape_filepath: $stheme.yellow
          shape_globpattern: { fg: $stheme.blue attr: b}
          shape_variable: $stheme.text
          shape_flag: { fg: $stheme.blue attr: b}
          shape_custom: {attr: b}
        }



        let carapace_completer = {|spans|
            carapace $spans.0 nushell ...$spans | from json
        }
        $env.config = {
         show_banner: false,
         rm: {
           always_trash: true
         },
         # color_config: $theme,
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
          prepend /home/bob/Bin |
          append /usr/bin/env
        )
        $env.TERM = 'screen-256color'

        # define custom command
        def ginit [] {
          mkdir bare
          ls -a | get name | filter {|file| $file != 'bare'} | each {|file| mv $file bare/}
          ln -s bare/.git .git
        }

        def dockerimgs [] {
          docker images | lines | parse -r '(?P<REPOSITORY>\S+)\s+(?P<TAG>\S+)\s+(?P<IMAGE_ID>\S+)\s+(?P<CREATED>\S+ \S+ ago)\s+(?P<SIZE>\S+)' | select REPOSITORY IMAGE_ID CREATED SIZE
        }
        def dockerps [--all (-a)] {
          if $all {
            docker ps -a | lines | parse -r '(?P<CONTAINER_ID>\S+)\s+(?P<IMAGE>\S+)\s+(?P<COMMAND>".+")\s+(?P<CREATED>\S+ \S+ ago)\s+(?P<STATUS>(Up|Exited \(\d+\)|Restarting \(\d+\)|Paused)( \d+ (minutes|hours|seconds)( ago|( \(.+\)))?)?)\s+(?P<PORTS>(\S+, )+\S+)\s+(?P<NAMES>\S+)' | select CONTAINER_ID IMAGE COMMAND CREATED STATUS PORTS NAMES
          } else {
            docker ps | lines | parse -r '(?P<CONTAINER_ID>\S+)\s+(?P<IMAGE>\S+)\s+(?P<COMMAND>".+")\s+(?P<CREATED>\S+ \S+ ago)\s+(?P<STATUS>(Up|Exited \(\d+\)|Restarting \(\d+\)|Paused)( \d+ (minutes|hours|seconds)( ago|( \(.+\)))?)?)\s+(?P<PORTS>(\S+, )+\S+)\s+(?P<NAMES>\S+)' | select CONTAINER_ID IMAGE COMMAND CREATED STATUS PORTS NAMES
          }
        }
      '';

      shellAliases = {
        ll = "ls -l";
        la = "ls -a";
        lla = "ls -la";
        lg = "lazygit";
        sudo = "doas";
        fcd = "cd (fzf --walker dir)";
      };
    };

    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };

    thefuck = {
      enable = true;
      enableNushellIntegration = true;
      enableInstantMode = true;
    };

    direnv = {
      enable = true;
      enableNushellIntegration = true;
    };

    zoxide = {
      enable = true;
      enableNushellIntegration = true;
    };

    starship = {
      enable = true;
      enableNushellIntegration = true;
      settings = {
        add_newline = true;
        character = {
          success_symbol = "[[󰄛](green) ❯](peach)";
          error_symbol = "[[󰄛](red) ❯](peach)";
          vimcmd_symbol = "[󰄛 ❮](subtext1)"; # For use with zsh-vi-mode
        };
        git_branch.style = "bold mauve";
        directory = {
          truncation_length = 4;
          style = "bold lavender";
        };
      };
    };

    yazi = {
      enable = true;
      enableNushellIntegration = true;
      keymap = {
        manager.prepend_keymap = [
          { on = [ "e" ]; run = "arrow -1"; desc = "Move cursor up"; }
          { on = [ "n" ]; run = "arrow 1"; desc = "Move cursor down"; }
          { on = [ "E" ]; run = "seek -5"; desc = "Seek up 5 units in the preview"; }
          { on = [ "N" ]; run = "seek 5"; desc = "Seek down 5 units in the preview"; }
          { on = [ "y" ]; run = "leave"; desc = "Go back to the parent directory"; }
          { on = [ "o" ]; run = "enter"; desc = "Enter the child directory"; }
          { on = [ "Y" ]; run = "back"; desc = "Go back to the previous directory"; }
          { on = [ "O" ]; run = "forward"; desc = "Go forward to the next directory"; }

          { on = [ "j" ]; run = "find_arrow"; desc = "Go to the next found"; }
          { on = [ "J" ]; run = "find_arrow --previous"; desc = "Go to the previous found"; }
          { on = [ "h" ]; run = "yank"; desc = "Yank selected files (copy)"; }
          { on = [ "H" ]; run = "unyank"; desc = "Cancel the yank status"; }
          { on = [ "l" ]; run = "open"; desc = "Open selected files"; }
          { on = [ "L" ]; run = "open --interactive"; desc = "Open selected files interactively"; }
        ];
        tasks.prepend_keymap = [
          { on = [ "e" ]; run = "arrow -1"; desc = "Move cursor up"; }
          { on = [ "n" ]; run = "arrow 1"; desc = "Move cursor down"; }
        ];
        select.prepend_keymap = [
          { on = [ "e" ]; run = "arrow -1"; desc = "Move cursor up"; }
          { on = [ "n" ]; run = "arrow 1"; desc = "Move cursor down"; }
        ];
        input.prepend_keymap = [
          { on = [ "<C-c>" ]; run = "close"; desc = "Cancel input"; }
        ];
      };
    };

    btop = {
      enable = true;
      # settings = {
      #   color_theme = "TTY";
      #   theme_background = true;
      #   truecolor = true;
      # };
    };

  };

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    extraConfig = ''
      set-option -g focus-events on
      set -g mouse on
      set -g set-clipboard on
      set -g history-limit 10000

      set -g default-terminal "screen-256color"
      set-option -a terminal-features 'screen-256color:RGB'
      set-option -a terminal-overrides 'screen-256color:Tc'

  
      bind -n M-v copy-mode

      bind -T copy-mode-vi v send-keys -X begin-selection
      bind -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind -T copy-mode-vi y send-keys -X cursor-left
      bind -T copy-mode-vi o send-keys -X cursor-right
      bind -T copy-mode-vi e send-keys -X cursor-up
      bind -T copy-mode-vi n send-keys -X cursor-down
      bind -T copy-mode-vi k send-keys -X next-word-end
      bind -T copy-mode-vi E send-keys -N 5 -X cursor-up
      bind -T copy-mode-vi N send-keys -N 7 -X cursor-down
      bind -T copy-mode-vi Y send-keys -X start-of-line
      bind -T copy-mode-vi I send-keys -X end-of-line
      bind -T copy-mode-vi H send-keys -X copy-end-of-line
      bind -T copy-mode-vi h send-keys -X copy-selection-and-cancel
      bind -T copy-mode-vi j send-keys -X search-again

      # for system copy
      bind -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel "wl-copy"
      bind -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "wl-copy"
    '';
  };

  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      main = {
        # term = "xterm-256color";
        term = "screen-256color";
        # font = "Fira Code:size=13";
        # dpi-aware = "yes";
      };
      colors = {
        # background= "000000";
      };
      mouse = {
        hide-when-typing = "yes";
      };
    };
  };

  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local act = wezterm.action;

      wezterm.on('update-right-status', function(window, pane)
        window:set_right_status("  "..window:active_workspace().." 💬  ")
      end);

      wezterm.on(
        'format-window-title',
        function(tab, tabs, panes, config, hover, max_width)
          return ""
        end
      );

      return {
        color_scheme = "Catppuccin Mocha",

        window_padding = { left = 2, right = 2, top = 0, bottom = 0 },
        -- window_decorations = "NONE",


        font = wezterm.font_with_fallback({
          "Fira Code",
          { family = "Terminess Nerd Font Mono", scale = 1.5 },
        }),
        hide_mouse_cursor_when_typing = true,
        hide_tab_bar_if_only_one_tab = true,
        use_cap_height_to_scale_fallback_fonts = true,
        font_size = 12,
        scrollback_lines = 5000,

        leader = { key = 's', mods = 'ALT', timeout_milliseconds = 1000 },

        keys = {
          -- splitting
          { mods = "LEADER", key = "-", action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
          { mods = "LEADER", key = "=", action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
          { mods = 'LEADER', key = 'm', action = act.TogglePaneZoomState },
          { mods = "LEADER", key = "s", action = act.PaneSelect },
          -- show the pane selection mode, but have it swap the active and selected panes
          { mods = 'LEADER', key = '0', action = act.PaneSelect { mode = 'SwapWithActive' } },
          { mods = 'LEADER', key = 'Enter', action = act.ActivateCopyMode },
          { mods = 'LEADER', key = 'x', action = wezterm.action.CloseCurrentPane { confirm = true }, },
          {
            key = "w",
            mods = "LEADER",
            action = act.PromptInputLine({
              description = wezterm.format({
                { Attribute = { Intensity = "Bold" } },
                { Foreground = { AnsiColor = "Fuchsia" } },
                { Text = "Enter name for new workspace" },
              }),
              action = wezterm.action_callback(function(window, pane, line)
                -- line will be `nil` if they hit escape without entering anything
                -- An empty string if they just hit enter
                -- Or the actual line of text they wrote
                if line then
                  window:perform_action(
                    act.SwitchToWorkspace({
                      name = line,
                    }),
                    pane
                  )
                end
              end),
            }),
          },
          { key = 'p', mods = 'LEADER', action = act.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' }, },
        },

        key_tables = {
          copy_mode = {
            { key = 'Tab', mods = 'NONE', action = act.CopyMode 'MoveForwardWord' },
            { key = 'Tab', mods = 'SHIFT', action = act.CopyMode 'MoveBackwardWord', },
            { key = 'Enter', mods = 'NONE', action = act.CopyMode 'MoveToStartOfNextLine', },
            {
              key = 'Escape',
              mods = 'NONE',
              action = act.Multiple {
                { CopyMode = 'Close' },
              },
            },
            { key = 'Space', mods = 'NONE', action = act.CopyMode { SetSelectionMode = 'Cell' }, },
            { key = '$', mods = 'NONE', action = act.CopyMode 'MoveToEndOfLineContent', },
            { key = '$', mods = 'SHIFT', action = act.CopyMode 'MoveToEndOfLineContent', },
            { key = ',', mods = 'NONE', action = act.CopyMode 'JumpReverse' },
            { key = '0', mods = 'NONE', action = act.CopyMode 'MoveToStartOfLine' },
            { key = ';', mods = 'NONE', action = act.CopyMode 'JumpAgain' },
            { key = 'F', mods = 'NONE', action = act.CopyMode { JumpBackward = { prev_char = false } }, },
            { key = 'F', mods = 'SHIFT', action = act.CopyMode { JumpBackward = { prev_char = false } }, },
            { key = 'G', mods = 'NONE', action = act.CopyMode 'MoveToScrollbackBottom', },
            { key = 'G', mods = 'SHIFT', action = act.CopyMode 'MoveToScrollbackBottom', },
            { key = 'H', mods = 'NONE', action = act.CopyMode 'MoveToViewportTop' },
            { key = 'H', mods = 'SHIFT', action = act.CopyMode 'MoveToViewportTop', },
            { key = 'O', mods = 'NONE', action = act.CopyMode 'MoveToViewportBottom', },
            { key = 'O', mods = 'SHIFT', action = act.CopyMode 'MoveToViewportBottom', },
            { key = 'M', mods = 'NONE', action = act.CopyMode 'MoveToViewportMiddle', },
            { key = 'M', mods = 'SHIFT', action = act.CopyMode 'MoveToViewportMiddle', },
            { key = 'L', mods = 'NONE', action = act.CopyMode 'MoveToSelectionOtherEndHoriz', },
            { key = 'L', mods = 'SHIFT', action = act.CopyMode 'MoveToSelectionOtherEndHoriz', },
            { key = 'T', mods = 'NONE', action = act.CopyMode { JumpBackward = { prev_char = true } }, },
            { key = 'T', mods = 'SHIFT', action = act.CopyMode { JumpBackward = { prev_char = true } }, },
            { key = 'V', mods = 'NONE', action = act.CopyMode { SetSelectionMode = 'Line' }, },
            { key = 'V', mods = 'SHIFT', action = act.CopyMode { SetSelectionMode = 'Line' }, },
            { key = '^', mods = 'NONE', action = act.CopyMode 'MoveToStartOfLineContent', },
            { key = '^', mods = 'SHIFT', action = act.CopyMode 'MoveToStartOfLineContent', },
            { key = 'b', mods = 'NONE', action = act.CopyMode 'MoveBackwardWord' },
            { key = 'b', mods = 'ALT', action = act.CopyMode 'MoveBackwardWord' },
            { key = 'b', mods = 'CTRL', action = act.CopyMode 'PageUp' },
            {
              key = 'c',
              mods = 'CTRL',
              action = act.Multiple {
                { CopyMode = 'Close' },
              },
            },
            { key = 'd', mods = 'CTRL', action = act.CopyMode { MoveByPage = 0.5 }, },
            { key = 'k', mods = 'NONE', action = act.CopyMode 'MoveForwardWordEnd', },
            { key = 'f', mods = 'NONE', action = act.CopyMode { JumpForward = { prev_char = false } }, },
            { key = 'f', mods = 'ALT', action = act.CopyMode 'MoveForwardWord' },
            { key = 'f', mods = 'CTRL', action = act.CopyMode 'PageDown' },
            { key = 'g', mods = 'NONE', action = act.CopyMode 'MoveToScrollbackTop', },
            {
              key = 'g',
              mods = 'CTRL',
              action = act.Multiple {
                { CopyMode = 'Close' },
              },
            },
            { key = 'y', mods = 'NONE', action = act.CopyMode 'MoveLeft' },
            { key = 'n', mods = 'NONE', action = act.CopyMode 'MoveDown' },
            { key = 'e', mods = 'NONE', action = act.CopyMode 'MoveUp' },
            { key = 'o', mods = 'NONE', action = act.CopyMode 'MoveRight' },

            { key = 'm', mods = 'ALT', action = act.CopyMode 'MoveToStartOfLineContent', },
            { key = 'l', mods = 'NONE', action = act.CopyMode 'MoveToSelectionOtherEnd', },
            { key = 'q', mods = 'NONE',
              action = act.Multiple {
                { CopyMode = 'Close' },
              },
            },
            { key = 't', mods = 'NONE', action = act.CopyMode { JumpForward = { prev_char = true } }, },
            { key = 'u', mods = 'CTRL', action = act.CopyMode { MoveByPage = -0.5 }, },
            { key = 'v', mods = 'NONE', action = act.CopyMode { SetSelectionMode = 'Cell' }, },
            { key = 'v', mods = 'CTRL', action = act.CopyMode { SetSelectionMode = 'Block' }, },
            { key = 'w', mods = 'NONE', action = act.CopyMode 'MoveForwardWord' },
            {
              key = 'h',
              mods = 'NONE',
              action = act.Multiple {
                { CopyTo = 'ClipboardAndPrimarySelection' },
                { CopyMode = 'Close' },
              },
            },
            { key = 'PageUp', mods = 'NONE', action = act.CopyMode 'PageUp' },
            { key = 'PageDown', mods = 'NONE', action = act.CopyMode 'PageDown' },
            { key = 'End', mods = 'NONE', action = act.CopyMode 'MoveToEndOfLineContent', },
            { key = 'Home', mods = 'NONE', action = act.CopyMode 'MoveToStartOfLine', },
            { key = 'LeftArrow', mods = 'NONE', action = act.CopyMode 'MoveLeft' },
            { key = 'LeftArrow', mods = 'ALT', action = act.CopyMode 'MoveBackwardWord', },
            { key = 'RightArrow', mods = 'NONE', action = act.CopyMode 'MoveRight', },
            { key = 'RightArrow', mods = 'ALT', action = act.CopyMode 'MoveForwardWord', },
            { key = 'UpArrow', mods = 'NONE', action = act.CopyMode 'MoveUp' },
            { key = 'DownArrow', mods = 'NONE', action = act.CopyMode 'MoveDown' },
          },
        }
      }
    '';
  };

  imports = [
    ./niri.nix
    ./wm.nix
    ./vimrc.nix
    # ./plasma.nix
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = false;

}
