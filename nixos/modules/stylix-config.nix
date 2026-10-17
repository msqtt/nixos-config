{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.stylixConfig;
in
{
  options.stylixConfig = {
    scheme = mkOption {
      type = types.path;
      default = "${pkgs.base16-schemes}/share/themes/tokyo-night-light.yaml";
      description = "Base16 Scheme Yaml";
    };

    wallpaper = mkOption {
      type = types.path;
      default = "${builtins.path { path = ../../assets; }}/emoji-d5d6db-960x540@2x.png";
      description = "Wallpaper";
    };
  };

  config = {
    stylix = {
      enable = true;

      base16Scheme = cfg.scheme;
      image = cfg.wallpaper;

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
          package = pkgs.noto-fonts-color-emoji;
        };
        monospace = {
          name = "Fira Code";
          package = pkgs.fira-code;
        };
      };

      targets = {
        console.enable = false;
        nixvim.enable = true;
      };
    };
  };
}
