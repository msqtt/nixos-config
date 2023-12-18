{ config, pkgs, pkgs-4469e2, ... }:
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
  ];

  home.packages = with pkgs;[
    # my owe shit
    my-nur.bobibo
    my-nur.wpsoffice-cn-fix

    # develop shit
    subversion

    # base shit
    pavucontrol
    mpv
    imv
    chafa

    # daily use
    blueberry
    entr
    gomuks
    grc
    firefox
    appimage-run
    go-musicfox
    tty-clock
    musescore
    acpi
    nur.repos.linyinfeng.wemeet

    # cli shit
    dogdns
    du-dust
    delta
    httpie
    cheat
    netcat
    devbox
    lynx
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
    yq-go # yaml processer https://github.com/mikefarah/yq
    fzf # A command-line fuzzy finder
    fd
    zoxide


    # misc
    nerdfonts
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

    # productivity
    btop # replacement of htop/nmon
    lsof # list open files
  ]
  # ++ (with pkgs-4469e2 ; [
  # ])
  ;
}
