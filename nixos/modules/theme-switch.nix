{ pkgs, ... }:
{
  specialisation = {
    light = {
      inheritParentConfig = true;
    };
    dark = {
      inheritParentConfig = true;
      configuration = {
        imports = [ ./stylix-config.nix ];
        stylixConfig = {
          scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
          wallpaper = "${builtins.path { path = ../../assets; }}/number18-adj-right.png";
        };
      };
    };
  };
}
