{ config, pkgs, ... } @inputs:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "bob";
  home.homeDirectory = "/home/bob";
  home.sessionVariables = {
    DEFAULT_BROWSER = "${pkgs.firefox}/bin/firefox";
  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = "firefox-esr.desktop";
    "x-scheme-handler/http" = "firefox-esr.desktop";
    "x-scheme-handler/https" = "firefox-esr.desktop";
    "x-scheme-handler/about" = "firefox-esr.desktop";
    "x-scheme-handler/unknown" = "firefox-esr.desktop";
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    figlet
    cowsay
    firefox
    chromium
    thunderbird
    vscode
    libreoffice-qt
    jetbrains.idea-ultimate
    obs-studio
    feishu

  ] ++ (with inputs.my-nur; [
    bobibo
    jbl
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
        let carapace_completer = {|spans|
            carapace $spans.0 nushell ...$spans | from json
        }
        $env.config = {
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
        prepend /home/bob/Bin |
        append /usr/bin/env
        )
      '';

      shellAliases = {
        ll = "ls -l";
        la = "ls -a";
        lla = "ls -la";
        lg = "lazygit";
        sudo = "doas";
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
        palette = "catppuccin_mocha";
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
        palettes.catppuccin_mocha = {
          rosewater = "#f5e0dc";
          flamingo = "#f2cdcd";
          pink = "#f5c2e7";
          mauve = "#cba6f7";
          red = "#f38ba8";
          maroon = "#eba0ac";
          peach = "#fab387";
          yellow = "#f9e2af";
          green = "#a6e3a1";
          teal = "#94e2d5";
          sky = "#89dceb";
          sapphire = "#74c7ec";
          blue = "#89b4fa";
          lavender = "#b4befe";
          text = "#cdd6f4";
          subtext1 = "#bac2de";
          subtext0 = "#a6adc8";
          overlay2 = "#9399b2";
          overlay1 = "#7f849c";
          overlay0 = "#6c7086";
          surface2 = "#585b70";
          surface1 = "#45475a";
          surface0 = "#313244";
          base = "#1e1e2e";
          mantle = "#181825";
          crust = "#11111b";
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

  };

  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local act = wezterm.action;

      wezterm.on('update-right-status', function(window, pane)
        window:set_right_status(window:active_workspace())
      end)

      return {
        color_scheme = "Catppuccin Mocha",

        window_padding = { left = 2, right = 2, top = 0, bottom = 0 },
        window_decorations = "NONE",

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
    ./plasma.nix
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
