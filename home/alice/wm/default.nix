{ config, pkgs, ... }:
{
  # 直接将当前文件夹的配置文件，链接到 Home 目录下的指定位置
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;
  home.file.".config/hikari" = {
    source = ./hikari;
    recursive = true;
  };

  # 设置鼠标指针大小以及字体 DPI（适用于 4K 显示器）
  # xresources.properties = {
  #   "Xcursor.size" = 16;
  #   "Xft.dpi" = 172;
  # };
}
