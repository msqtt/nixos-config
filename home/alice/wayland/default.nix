{ config, pkgs, ... }:
{
  imports = [
    ./sway
  ];

  home.packages = with pkgs;[
    swappy
    swww
    bemenu
    sakura
    wlr-randr
    wl-clipboard
    wl-mirror
    grim
    slurp
    swaylock
    wev
    hyprpicker # color picker
  ];
  # 直接将当前文件夹的配置文件，链接到 Home 目录下的指定位置
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # imports = [
  # 		hyprland.homeManagerModules.default
  # ];
  # wayland.windowManager.hyprland = {
  # 	enable = true;
  # 	extraConfig = builtins.readFile ./hyprland/hyprland.conf;
  # };

  # home.file.".config/wayfire.ini" = {
  #   source = ./wayfire/wayfire.ini;
  #   recursive = true;
  # };


  # 设置鼠标指针大小以及字体 DPI（适用于 4K 显示器）
  # xresources.properties = {
  #   "Xcursor.size" = 16;
  #   "Xft.dpi" = 172;
  # };
}
