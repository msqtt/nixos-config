{ config, pkgs, ... }:

{
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      libsForQt5.fcitx5-qt
      fcitx5-gtk
      fcitx5-lua
      fcitx5-rime
      fcitx5-configtool
    ];
  };

  # link do not work, just copy one.
  home.file.".local/share/fcitx5/themes/material-theme/theme.conf".text = builtins.readFile ./theme-indigo.conf;
}
