{ config, pkgs, ... }:
{
  environment = {
    variables = rec {
      WLR_NO_HARDWARE_CURSORS="1";
      EDITOR="nvim";
    };
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    systemPackages = with pkgs; [
      git
      wget
    ];
  };

}
