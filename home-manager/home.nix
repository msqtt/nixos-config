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
    telegram-desktop
    thunderbird
    vscode
    libreoffice-qt
    dbeaver-bin
    jetbrains.idea-ultimate

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
      };
    };

    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };

    thefuck = {
      enable = true;
      enableNushellIntegration = true;
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
          success_symbol = "[➜](bold green)";
          error_symbol = "[➜](bold red)";
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
      local wezterm = require("wezterm")
      return {
        color_scheme = "Hardcore",

        window_padding = {
          left = 2,
          right = 2,
          top = 0,
          bottom = 0,
        },

        font = wezterm.font_with_fallback({
          "Fira Code",
          { family = "Terminess Nerd Font Mono", scale = 1.5 },
        }),
        hide_mouse_cursor_when_typing = true,
        hide_tab_bar_if_only_one_tab = true,
        use_cap_height_to_scale_fallback_fonts = true,
        font_size = 12,
        scrollback_lines = 5000,
      }
    '';
  };

  imports = [
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
