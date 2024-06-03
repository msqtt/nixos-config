{ config, pkgs, ... }:
{
  services.mako = {
    enable = false;
    extraConfig = ''
      font=Noto Sans CJK SC
    '';
  };
}
