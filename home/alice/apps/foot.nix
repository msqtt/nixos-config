{ pkgs, ... }:
{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        term = "xterm-256color";
        font = "Source Code Pro:size=12";
        dpi-aware = "yes";
      };

      mouse = {
        hide-when-typing = "yes";
      };

      key-bindings = {
        spawn-terminal = "Control+Shift+t";
        scrollback-up-page = "Control+Shift+e";
        scrollback-down-page = "Control+Shift+n";
      };

      colors = {
        alpha = "1.0";
        background = "000000";
        foreground = "ffffff";
        # flash = "d0d0d0";
        # flash-alpha=0.5

        ## Normal/regular colors (color palette 0-7)
        # regular0 = "45475a"; # black
        # regular1 = "f38ba8"; # red
        # regular2 = "a6e3a1"; # green
        # regular3 = "f9e2af"; # yellow
        regular4 = "c9cbfe"; # blue
        # regular5 = "f5c2e7"; # magenta
        # regular6 = "94e2d5"; # cyan
        # regular7 = "bac2de"; # white
        #
        # ## Bright colors (color palette 8-15)
        # bright0 = "585b70"; # bright black
        # bright1 = "f38ba8"; # bright red
        # bright2 = "d8fa3b"; # bright green
        # bright3 = "f9e2af"; # bright yellow
        # bright4 = "89b4fa"; # bright blue
        # bright5 = "f5c2e7"; # bright magenta
        # bright6 = "94e2d5"; # bright cyan
        # bright7 = "a6adc8"; # bright white
      };

      cursor = {
        style = "block";
        blink = "yes";
      };
    };
  };
}
