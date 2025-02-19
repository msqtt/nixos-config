{ pkgs, config, ... }:
let
  # theme = "${pkgs.base16-schemes}/share/themes/catppuccin-latte.yaml";
  theme = "${pkgs.base16-schemes}/share/themes/tokyo-night-light.yaml";

  wallpaper = config.lib.stylix.pixel "base0A";
  # wallpaper = "/etc/nixos/assets/nix-wallpaper-watersplash.png";
in
{
  stylix = {
    enable = true;
    cursor.size = 48;
    fonts = {
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
    image = wallpaper;
  };
}
