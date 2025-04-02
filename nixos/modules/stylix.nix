{ pkgs, config, ... }:
let
  # theme = "${pkgs.base16-schemes}/share/themes/catppuccin-latte.yaml";
  theme = "${pkgs.base16-schemes}/share/themes/tokyo-night-light.yaml";

  # wallpaper = config.lib.stylix.pixel "base0A";
  wallpaperDir = builtins.path { path = ../../assets; };
in
{
  stylix = {
    enable = true;
    cursor.size = 48;
    fonts = {
      serif = {
        package = pkgs. noto-fonts-cjk-serif;
        name = "Noto CJK Serif";
      };
      sansSerif = {
        package = pkgs.noto-fonts-cjk-sans;
        name = "Noto CJK Sans";
      };
      emoji = {
        name = "Noto Color Emoji";
        package = pkgs.noto-fonts-emoji;
      };
      monospace = {
        name = "Fira Code";
        package = pkgs.fira-code;
      };
    };

    base16Scheme = theme;
    image = "${wallpaperDir}/emoji-d5d6db-960x540@2x.png";
  };
}
