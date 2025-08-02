{ lib, ... }:
{
  specialisation =  {
    light.configuration = {
    };
    dark.configuration = {
      imports = [ ./niri.nix ];

      niriConfig = {
        ringColor = "#f38ba8";
      };

      programs.qutebrowser.settings = {
        colors.webpage.darkmode.enabled = lib.mkForce true;
      };
    };
  };
}
