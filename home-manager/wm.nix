{

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
        ];
        modules-right = [
          "network"
          # "temperature"
          "pulseaudio"
          "battery"
          "clock"
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
              ""
            ];
          };
          on-click = "pavucontrol";
        };
      };
    };
    style = ''
      * {
          font-family: "UbuntuMono Nerd Font";
          font-size: 16px;
      }


      window#waybar { 
          background-color: #225877; 
          color: #ffffff;    
      }


      .modules-left {
        background-color: #323232;
        padding: 0px 0px 0px 0px;
      }


      .modules-right {
        background-color: #323232;
        padding: 0px 5px 0px 0px;
      }

      #workspaces {
      }


      #workspaces button {
        padding: 0px 11px 0px 11px; 
        min-width: 1px;
        color: #888888;
      }


      #workspaces button.focused { 
        padding: 0px 11px 0px 11px; 
        background-color: #285577;
        color: #ffffff;
      }


      #mode { 
         background-color: #900000;
         color: #ffffff;
           padding: 0px 5px 0px 5px;
           border: 1px solid #2f343a;
      }


      #window {
         color: #ffffff;
         background-color: #285577;
           padding: 0px 10px 0px 10px;
      }


      window#waybar.empty #window {
        background-color: transparent;
        color: transparent;
      }


      window#waybar.empty {
        background-color: #323232;
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
         color: #ff5555;
      }


      #network.disconnected {
          color: #ff5555;
      }
    '';
  };
}
