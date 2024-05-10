{ config, ... }:
{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require("wezterm")
      local c = wezterm.config_builder()

      -- build your config according to
      -- https://wezfurlong.org/wezterm/config/lua/wezterm/config_builder.html

      -- the plugin is currently made for Catppuccin only
      c.color_scheme = "Catppuccin Mocha"

      c.use_fancy_tab_bar = false

      c.window_padding = {
        left = 2,
        right = 2,
        top = 0,
        bottom = 0,
      }

      -- then finally apply the plugin
      -- these are currently the defaults:
      return c
    '';
  };
}

