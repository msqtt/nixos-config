{ config, pkgs, ... }:
{
  services.mako = {
    enable = true;
    extraConfig = ''
      default-timeout=5000
      font=Noto Serif Display
      # Colors

      background-color=#080808
      text-color=#ffffff
      border-color=#ff0000
      progress-color=over #313244

      [urgency=high]
      border-color=#fab387
      ignore-timeout=1

    '';
  };
}
