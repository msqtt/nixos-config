{ config, pkgs, ... }:
{
  services.mako = {
    enable = true;
    extraConfig = ''
      font=Noto Sans CJK SC
    '';
  };
}
