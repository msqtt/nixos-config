{ config, pkgs, ... }:

{
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
        fcitx5-rime
        fcitx5-configtool
        fcitx5-chinese-addons
      ];
  };
   
  home.file.".local/share/fcitx5/rime" = {
    source = ./rime;
    recursive = true;
  };

	# link do not work, just copy one.
  home.file.".local/share/fcitx5/themes/material-theme/theme.conf".text
    = builtins.readFile ./themes/material-theme/theme-indigo.conf;

}
