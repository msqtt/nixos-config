{ config, pkgs, ... }:
{
  imports = [
    ./lf
    ./tmux
    ./misc
    ./direnv
    # ./mako.nix
    # ./foot.nix
    # ./zathura.nix
    ./wezterm.nix
    ./obs.nix
    ./qutebrowser.nix
    # ./fbterm.nix
  ];

  home.packages = with pkgs;[
    # my owe shit
    my-nur.bobibo
    my-nur.listenme
    # my-nur.wpsoffice-cn-fix

    # develop shit
    subversion

    # base shit
    ffmpeg
    gnumake
    pavucontrol
    mpv
    imv
    chafa

    # daily use
    telegram-desktop
    gimp
    flameshot
    thunderbird
    pulsemixer
    blueberry
    gomuks
    grc
    firefox
    appimage-run
    musescore
    nur.repos.linyinfeng.wemeet

    # cli shit
    pv
    bat
    du-dust
    delta
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    fzf # A command-line fuzzy finder
    fd
    cowsay
    zoxide
    entr


    xclip
    caddy
    distrobox
    dogdns
    httpie
    cheat
    netcat
    devbox
    stress-ng
    psmisc
    sshfs
    translate-shell
    reptyr
    fastfetch
    libnotify
    brightnessctl

    # archives
    zip
    unar
    xz
    # unzip eeeee dont send GBK to me
    p7zip

    # utils

    # misc
    file
    tree
    which
    zstd
    yewtube

    # nix related
    #
    home-manager

    # productivity
    btop # replacement of htop/nmon
    lsof # list open files
  ]
    # ++ (with pkgs-4469e2 ; [
    # ])
  ;
}
