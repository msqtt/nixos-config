{ config, pkgs,  ... }:
{
  imports = [
    ./lf
    ./tmux
    ./misc
    ./direnv
    ./mako.nix
    ./foot.nix
    ./zathura.nix
    ./obs.nix
    ./qutebrowser.nix
    ./fbterm.nix
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
    ytfzf
    pulsemixer
    blueberry
    entr
    gomuks
    grc
    firefox
    appimage-run
    musescore
    nur.repos.linyinfeng.wemeet

    # cli shit
    caddy
    distrobox
    dogdns
    du-dust
    delta
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
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    fzf # A command-line fuzzy finder
    fd

    # misc
    cowsay
    file
    tree
    which
    zstd

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor
    rnix-lsp
    home-manager

    # productivity
    btop # replacement of htop/nmon
    lsof # list open files
  ]
  # ++ (with pkgs-4469e2 ; [
  # ])
  ;
}
