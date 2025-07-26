{ pkgs, config, ... }:
let
  theme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

  # wallpaper = config.lib.stylix.pixel "base0A";
  wallpaperDir = builtins.path { path = ../../assets; };
in
{
  stylix = {
    enable = true;
    # cursor.size = 48;
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
    image = "${wallpaperDir}/purple-3d.png";

    targets = {
      console.enable = false;
      nixvim.enable = false;
    };
  };
}
