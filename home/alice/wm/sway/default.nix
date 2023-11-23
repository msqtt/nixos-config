{ config, pkgs, lib, ... }:
{
  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4";
      input = {
        "*" = {
					repeat_delay = "250";
					repeat_rate = "40";
          xkb_layout = "us";
          xkb_variant = "workman";
          # xkb_options = "ctrl:nocaps,altwin:swap_lalt_lwin";
          xkb_options = "ctrl:nocaps";
        };
      };
      terminal = "footclient";
			menu = "bemenu-run  --fn='SourceCodePro[14]'";
      startup = [
        # Launch Firefox on start
        { command = "foot --server"; }
        { command = "fcitx5 -d"; }
      ];
      keybindings =
        let
					cfg = config.wayland.windowManager.sway;
        in {
					"${modifier}+Shift+l" = ''exec swaylock'';
					"${modifier}+Shift+a" = ''exec grim -g "$(slurp)" - | swappy -f -'';
          "${modifier}+Return" = "exec ${cfg.config.terminal}";
					"${modifier}+Shift+q" = "kill";
          "${modifier}+Shift+Return" = "exec ${cfg.config.menu}";
          "${modifier}+Shift+k" = "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";
					"${modifier}+${cfg.config.left}" = "focus left";
					"${modifier}+${cfg.config.down}" = "focus down";
					"${modifier}+${cfg.config.up}" = "focus up";
					"${modifier}+${cfg.config.right}" = "focus right";
					"${modifier}+Shift+${cfg.config.left}" = "move left";
					"${modifier}+Shift+${cfg.config.down}" = "move down";
					"${modifier}+Shift+${cfg.config.up}" = "move up";
					"${modifier}+Shift+${cfg.config.right}" = "move right";
					"${modifier}+b" = "splith";
          "${modifier}+v" = "splitv";
          "${modifier}+f" = "fullscreen toggle";
          "${modifier}+a" = "focus parent";

          "${modifier}+s" = "layout stacking";
          "${modifier}+w" = "layout tabbed";
          "${modifier}+k" = "layout toggle split";

          "${modifier}+Shift+space" = "floating toggle";
          "${modifier}+space" = "focus mode_toggle";

          "${modifier}+1" = "workspace number 1";
          "${modifier}+2" = "workspace number 2";
          "${modifier}+3" = "workspace number 3";
          "${modifier}+4" = "workspace number 4";
          "${modifier}+5" = "workspace number 5";
          "${modifier}+6" = "workspace number 6";
          "${modifier}+7" = "workspace number 7";
          "${modifier}+8" = "workspace number 8";
          "${modifier}+9" = "workspace number 9";

          "${modifier}+Shift+1" =
            "move container to workspace number 1";
          "${modifier}+Shift+2" =
            "move container to workspace number 2";
          "${modifier}+Shift+3" =
            "move container to workspace number 3";
          "${modifier}+Shift+4" =
            "move container to workspace number 4";
          "${modifier}+Shift+5" =
            "move container to workspace number 5";
          "${modifier}+Shift+6" =
            "move container to workspace number 6";
          "${modifier}+Shift+7" =
            "move container to workspace number 7";
          "${modifier}+Shift+8" =
            "move container to workspace number 8";
          "${modifier}+Shift+9" =
            "move container to workspace number 9";

          "${modifier}+Shift+minus" = "move scratchpad";
          "${modifier}+minus" = "scratchpad show";

          "${modifier}+Shift+c" = "reload";
        };
      left = "y";
      down = "n";
      up = "e";
      right = "o";
    };
  };
}
