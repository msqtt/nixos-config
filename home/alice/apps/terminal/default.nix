{pkgs, ... }:
{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        term = "xterm-256color";
        font = "monospace:size=12";
        dpi-aware = "yes";
      };

      mouse = {
        hide-when-typing = "yes";
      };

      key-bindings = {
        spawn-terminal="Control+Shift+t";
        scrollback-up-page="Control+Shift+e";
        scrollback-down-page="Control+Shift+n";
      };
      
      colors = {
        alpha="1.0";
        background="000000";
      };

      cursor = {
        style="block";
        blink="yes";
      };
    };
  };
}
