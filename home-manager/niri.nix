{
  services.mako.enable = true;
  programs.niri.config = ''
     spawn-at-startup "xwayland-satellite"
     // spawn-at-startup "gammastep" "-O" "6000K" "-b" "0.9"
     // spawn-at-startup "mako"
     // spawn-at-startup "mako" "--background-color=#1e1e2e" "--text-color=#cdd6f4" "--border-color=#f5c2e7" "--progress-color=#313244" "--border-size=2" "--max-icon-size=32" "--border-radius=4"
     spawn-at-startup "swaybg" "-m" "fill" "-i" "/etc/nixos/assets/purple-3d.png"
     spawn-at-startup "waybar"
     spawn-at-startup "rfkill" "unblock" "all"

     input {
       keyboard {
           xkb {
             layout "us"
             variant "workman"
             options "ctrl:nocaps"
           }

           repeat-delay 250
           repeat-rate 30
           track-layout "global"
       }

       touchpad {
         // on
         // tap
          dwt
         // dwtp
         natural-scroll
         // accel-speed 0.2
         // accel-profile "flat"
         // scroll-method "two-finger"
         // tap-button-map "left-middle-right"
         // click-method "clickfinger"
         // left-handed
         // disabled-on-external-mouse
         // middle-emulation
       }

     }

    // output "HDMI-A-1" {
    //   mode "1920x1080@75"
    //   transform "270"
    //   scale 1.5
    //   position x=720 y=0
    //   variable-refresh-rate // on-demand=true
    //   background-color "black"
    // }

    output "HDMI-A-1" {
      mode "1920x1080@75"
      scale 1.25
      // transform "270"
      // position x=0 y=-720
      position x=1536 y=0
      variable-refresh-rate on-demand=true
      background-color "black"
    }

     output "eDP-1" {
       background-color "black"
       position x=0 y=0
     }

     window-rule {
        // match app-id=r#"^org\.wezfurlong\.wezterm$"#
        // default-column-width {}
     }

     environment {
         DISPLAY ":0"
         ELECTRON_OZONE_PLATFORM_HINT "auto"
         NIXOS_OZONE_WL "1"
         QT_QPA_PLATFORM "wayland"
     }

     cursor {
        // xcursor-theme "breeze_cursors"
         xcursor-size 64

         // hide-on-key-press
         hide-after-inactive-ms 1000
     }

     binds {
       Mod+l { open-overview; }
       Mod+Shift+Slash { show-hotkey-overlay; }

       Mod+Shift+C { spawn "sh" "-c" "env DISPLAY=:0 xsel -ob | wl-copy"; }
       Mod+Shift+V { spawn "sh" "-c" "wl-paste -n | env DISPLAY=:0 xsel -ib"; }
       Mod+Escape { toggle-keyboard-shortcuts-inhibit; }

       // Mod+T { spawn "sh" "-c" "alacritty msg create-window -e fish -C t || alacritty -e fish -C t"; }
       // Mod+Shift+T { spawn "sh" "-c" "alacritty msg create-window || alacritty"; }
       // Mod+Return { spawn "~/arst"; }
       // Mod+Return { do-screen-transition; }
       // Mod+T { spawn "flatpak" "run" "org.gnome.Ptyxis.Devel" "-s"; }
       // Mod+T { spawn "~/.local/bin/spawn-ptyxis.sh"; }
       // Mod+T { spawn "bash" "-c" "notify-send hello && exec alacritty"; }
       // Mod+T { spawn "kgx" "-e" "fish -C t"; }

       Mod+Space { spawn "fuzzel"; }
       Mod+Return { spawn "wezterm"; }
       Mod+B {spawn "sh" "-c" "pgrep waybar > /dev/null && pkill waybar || waybar"; }

       XF86AudioRaiseVolume allow-when-locked=true repeat=false { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+"; }
       XF86AudioLowerVolume allow-when-locked=true repeat=false { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-"; }
       XF86AudioMute        allow-when-locked=true repeat=false { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }
       XF86AudioMicMute     allow-when-locked=true repeat=false { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"; }

       Mod+Q { close-window; }
       Mod+BackSpace { close-window; }

       Mod+Y     { focus-column-left; }
       Mod+D     { focus-window-down; }
       Mod+U     { focus-window-up; }
       Mod+O     { focus-column-right; }
       Mod+Left  { focus-column-left; }
       Mod+Down  { focus-window-down; }
       Mod+Up    { focus-window-up; }
       Mod+Right { focus-column-right; }

       Mod+Ctrl+Y     { move-column-left; }
       Mod+Ctrl+D     { move-window-down; }
       Mod+Ctrl+U     { move-window-up; }
       Mod+Ctrl+O     { move-column-right; }
       Mod+Ctrl+Left  { move-column-left; }
       Mod+Ctrl+Down  { move-window-down; }
       Mod+Ctrl+Up    { move-window-up; }
       Mod+Ctrl+Right { move-column-right; }

       Mod+Home { focus-column-first; }
       Mod+End  { focus-column-last; }
       Mod+Ctrl+Home { move-column-to-first; }
       Mod+Ctrl+End  { move-column-to-last; }

       Mod+Shift+Y     { focus-monitor-left; }
       Mod+Shift+D     { focus-monitor-down; }
       Mod+Shift+U     { focus-monitor-up; }
       Mod+Shift+O     { focus-monitor-right; }
       Mod+Shift+Left  { focus-monitor-left; }
       Mod+Shift+Down  { focus-monitor-down; }
       Mod+Shift+Up    { focus-monitor-up; }
       Mod+Shift+Right { focus-monitor-right; }

       Mod+Shift+Ctrl+Y     { move-column-to-monitor-left; }
       Mod+Shift+Ctrl+D     { move-column-to-monitor-down; }
       Mod+Shift+Ctrl+U     { move-column-to-monitor-up; }
       Mod+Shift+Ctrl+O     { move-column-to-monitor-right; }
       Mod+Shift+Ctrl+Left  { move-column-to-monitor-left; }
       Mod+Shift+Ctrl+Down  { move-column-to-monitor-down; }
       Mod+Shift+Ctrl+Up    { move-column-to-monitor-up; }
       Mod+Shift+Ctrl+Right { move-column-to-monitor-right; }

       Mod+Shift+Alt+Y     { move-workspace-to-monitor-left; }
       Mod+Shift+Alt+D     { move-workspace-to-monitor-down; }
       Mod+Shift+Alt+U     { move-workspace-to-monitor-up; }
       Mod+Shift+Alt+O     { move-workspace-to-monitor-right; }
       Mod+Shift+Alt+Left  { move-workspace-to-monitor-left; }
       Mod+Shift+Alt+Down  { move-workspace-to-monitor-down; }
       Mod+Shift+Alt+Up    { move-workspace-to-monitor-up; }
       Mod+Shift+Alt+Right { move-workspace-to-monitor-right; }

       Mod+N              { focus-workspace-down; }
       Mod+E              { focus-workspace-up; }
       Mod+Page_Down      { focus-workspace-down; }
       Mod+Page_Up        { focus-workspace-up; }
       Mod+Ctrl+N         { move-column-to-workspace-down; }
       Mod+Ctrl+E         { move-column-to-workspace-up; }
       Mod+Ctrl+Page_Down { move-column-to-workspace-down; }
       Mod+Ctrl+Page_Up   { move-column-to-workspace-up; }

       Mod+WheelScrollDown            cooldown-ms=150 { focus-workspace-down; }
       Mod+WheelScrollUp              cooldown-ms=150 { focus-workspace-up; }
       Mod+Ctrl+WheelScrollDown       cooldown-ms=150 { move-column-to-workspace-down; }
       Mod+Ctrl+WheelScrollUp         cooldown-ms=150 { move-column-to-workspace-up; }

       Mod+WheelScrollRight           { focus-column-right; }
       Mod+WheelScrollLeft            { focus-column-left; }
       Mod+Ctrl+WheelScrollRight      { move-column-right; }
       Mod+Ctrl+WheelScrollLeft       { move-column-left; }

       Mod+Shift+WheelScrollDown      { focus-column-right; }
       Mod+Shift+WheelScrollUp        { focus-column-left; }
       Mod+Ctrl+Shift+WheelScrollDown { move-column-right; }
       Mod+Ctrl+Shift+WheelScrollUp   { move-column-left; }

       Mod+TouchpadScrollUp   allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.02-"; }
       Mod+TouchpadScrollDown allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.02+"; }
       // Mod+TouchpadScrollLeft  { focus-column-left; }
       // Mod+TouchpadScrollRight { focus-column-right; }

       Mod+Shift+N         { move-workspace-down; }
       Mod+Shift+E         { move-workspace-up; }
       Mod+Shift+Page_Down { move-workspace-down; }
       Mod+Shift+Page_Up   { move-workspace-up; }

       Mod+1 { focus-workspace 1; }
       Mod+2 { focus-workspace 2; }
       Mod+3 { focus-workspace 3; }
       Mod+4 { focus-workspace 4; }
       Mod+5 { focus-workspace 5; }
       Mod+6 { focus-workspace 6; }
       Mod+7 { focus-workspace 7; }
       Mod+8 { focus-workspace 8; }
       Mod+9 { focus-workspace 9; }
       Mod+Ctrl+1 { move-column-to-workspace 1; }
       Mod+Ctrl+2 { move-column-to-workspace 2; }
       Mod+Ctrl+3 { move-column-to-workspace 3; }
       Mod+Ctrl+4 { move-column-to-workspace 4; }
       Mod+Ctrl+5 { move-column-to-workspace 5; }
       Mod+Ctrl+6 { move-column-to-workspace 6; }
       Mod+Ctrl+7 { move-column-to-workspace 7; }
       Mod+Ctrl+8 { move-column-to-workspace 8; }
       Mod+Ctrl+9 { move-column-to-workspace 9; }

       // Mod+Tab { focus-workspace-previous; }

       Mod+Comma  { consume-window-into-column; }
       Mod+Period { expel-window-from-column; }

       Mod+BracketLeft  { consume-or-expel-window-left; }
       Mod+BracketRight { consume-or-expel-window-right; }
       // Mod+BracketLeft  { focus-column-or-monitor-left; }
       // Mod+BracketRight { focus-column-or-monitor-right; }
       // Mod+BracketLeft  { focus-window-or-monitor-up; }
       // Mod+BracketRight { focus-window-or-monitor-down; }

       Mod+R { switch-preset-column-width; }
       Mod+Shift+R { switch-preset-window-height; }
       Mod+Ctrl+R { reset-window-height; }
       Mod+M { maximize-column; }
       Mod+Shift+F { fullscreen-window; }
       Mod+C { center-column; }

       Mod+Minus { set-column-width "-10%"; }
       Mod+Equal { set-column-width "+10%"; }
       Mod+Ctrl+Minus { set-column-width "-1"; }
       Mod+Ctrl+Equal { set-column-width "+1"; }

       Mod+Shift+Minus      { set-window-height "-10%"; }
       Mod+Shift+Equal      { set-window-height "+10%"; }
       Mod+Shift+Ctrl+Minus { set-window-height "-1"; }
       Mod+Shift+Ctrl+Equal { set-window-height "+1"; }

       Mod+0            { set-column-width "960"; }
       Mod+Shift+0      { set-window-height "540"; }
       Mod+Alt+0        { set-column-width "1280"; }
       Mod+Shift+Alt+0  { set-window-height "720"; }
       Mod+Ctrl+0       { set-column-width "1920"; }
       Mod+Shift+Ctrl+0 { set-window-height "1080"; }

       Mod+Tab       { switch-layout "next"; }
       Mod+Shift+Tab { switch-layout "prev"; }

       Mod+Shift+L { spawn "swaylock"; }

       Print { screenshot; }
       Ctrl+Print { screenshot-screen; }
       Alt+Print { screenshot-window; }

       Mod+P { screenshot; }

       Mod+Shift+BackSpace { quit; }
       Mod+Shift+P { power-off-monitors; }

       Mod+Shift+Ctrl+T { toggle-debug-tint; }
       Mod+Shift+Ctrl+R { debug-toggle-opaque-regions; }
       Mod+Shift+Ctrl+M { debug-toggle-damage; }
     }

     layout {
       gaps 8
       always-center-single-column
       background-color "transparent"

       focus-ring {
         // off
         width 2
         // dwm color
         // active-color "#225877"
          active-color "#f38ba8"
         // inactive-color "#505050"
         // active-gradient from="#80c8ff" to="#bbddff" angle=45
         // inactive-gradient from="#505050" to="#808080" angle=45 relative-to="workspace-view"
       }
     }
  '';


  # services.mako.enable = true;

  programs.fuzzel = {
    enable = true;
  };


  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 25;
        modules-left = [
          "niri/workspaces"
          "niri/window"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "network"
          # "temperature"
          "pulseaudio"
          "battery"
          "tray"
        ];
        "niri/workspaces" = {
          disable-markup = true;
          format = "{index}";
        };
        "niri/window" = {
          format = "{}";
          icon = true;
        };
        tray = {
          icon-size = 18;
          spacing = 15;
        };
        clock = {
          format = "{:%a %b %e  %R}";
          interval = 30;
        };
        battery = {
          bat = "BAT0";
          states = {
            full = 99;
            good = 98;
            normal = 98;
            warning = 20;
            critical = 20;
          };
          format = "{icon}   {capacity}%";
          format-good = "{icon}   {capacity}%";
          format-full = "   {capacity}%";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
          interval = 30;
        };

        network = {
          interface = "wlp1s0";
          format-wifi = "   WiFi-On";
          format-disconnected = "😵   Disconnected";
          interval = 60;
        };
        temperature = {
          thermal-zone = 0;
          format = "{icon} {temperatureC}°C";
          format-icons = [
            ""
          ];
          interval = 30;
        };
        pulseaudio = {
          format = "{icon}  {volume}%  ";
          format-bluetooth = "  {volume}%  ";
          format-muted = "🔇  Mute  ";
          interval = 60;
          format-icons = {
            default = [
              " "
            ];
          };
          on-click = "pavucontrol";
        };
      };
    };
    # style = ''
    #   * {
    #       font-family: "UbuntuMono Nerd Font";
    #       font-size: 16px;
    #   }
    #
    #
    #   window#waybar { 
    #       background-color: #225877; 
    #       color: #ffffff;    
    #   }
    #
    #
    #   .modules-left {
    #     background-color: #323232;
    #     padding: 0px 0px 0px 0px;
    #   }
    #
    #
    #   .modules-right {
    #     background-color: #323232;
    #     padding: 0px 5px 0px 0px;
    #   }
    #
    #   #workspaces {
    #   }
    #
    #
    #   #workspaces button {
    #     padding: 0px 11px 0px 11px; 
    #     min-width: 1px;
    #     color: #888888;
    #   }
    #
    #
    #   #workspaces button.focused { 
    #     padding: 0px 11px 0px 11px; 
    #     background-color: #285577;
    #     color: #ffffff;
    #   }
    #
    #
    #   #mode { 
    #      background-color: #900000;
    #      color: #ffffff;
    #        padding: 0px 5px 0px 5px;
    #        border: 1px solid #2f343a;
    #   }
    #
    #
    #   #window {
    #      color: #ffffff;
    #      background-color: #285577;
    #        padding: 0px 10px 0px 10px;
    #   }
    #
    #
    #   window#waybar.empty #window {
    #     background-color: transparent;
    #     color: transparent;
    #   }
    #
    #
    #   window#waybar.empty {
    #     background-color: #323232;
    #   }
    #
    #
    #   #network, #temperature, #backlight, #pulseudio, #battery {
    #       padding: 0px 15px 0px 15px;
    #   }
    #       
    #
    #   #clock {
    #     margin: 0px 15px 0px 15px;
    #   }
    #
    #
    #   #tray{
    #      padding: 0px 8px 0px 5px;
    #      margin: 0px 5px 0px 5px;
    #   }
    #
    #
    #   #battery.critical {
    #      color: #ff5555;
    #   }
    #
    #
    #   #network.disconnected {
    #       color: #ff5555;
    #   }
    # '';
    style = ''
      * {
          font-family: "UbuntuMono Nerd Font";
          font-size: 16px;
      }


      window#waybar { 
      }


      .modules-left {
        padding: 0px 0px 0px 0px;
      }


      .modules-right {
        padding: 0px 5px 0px 0px;
      }

      #workspaces {
      }


      #workspaces button {
        padding: 0px 11px 0px 11px; 
        min-width: 1px;
      }


      #workspaces button.focused { 
        padding: 0px 11px 0px 11px; 
      }


      #mode { 
           padding: 0px 5px 0px 5px;
           border: 1px solid #2f343a;
      }


      #window {
           padding: 0px 10px 0px 10px;
      }


      window#waybar.empty #window {
        background-color: transparent;
        color: transparent;
      }


      window#waybar.empty {
      }


      #network, #temperature, #backlight, #pulseudio, #battery {
          padding: 0px 15px 0px 15px;
      }

      #clock {
        margin: 0px 15px 0px 15px;
      }


      #tray{
         padding: 0px 8px 0px 5px;
         margin: 0px 5px 0px 5px;
      }


      #battery.critical {
      }


      #network.disconnected {
      }
    '';
  };

}
