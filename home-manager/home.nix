{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "bob";
  home.homeDirectory = "/home/bob";

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    fastfetch
    dust
    fzf
    firefox
    telegram-desktop
    thunderbird
    vscode
  ];

  programs.git = {
    enable = true;
    userName  = "msqtt";
    userEmail = "mosquito@email.cn";
    aliases = {
      ci = "commit";
      co = "checkout";
      s = "status";
    };

  };

  programs.gh = {
    enable = true;
    settings.git_protocol = "ssh";
  };


   i18n.inputMethod = {
      # type = "fcitx5";
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-mozc
        kdePackages.fcitx5-qt
        fcitx5-rime
        libsForQt5.fcitx5-configtool
      ];
  };


  imports = [

  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
