{ config, pkgs, pkgs-ad97212, ... }:
{
  imports = [
    ./lf
    ./mako
    ./tmux
    ./direnv
    ./terminal
    ./pdf
		./obs
  ];

  home.packages = with pkgs;[
    # develop shit
    gcc
    subversion

    # base shit
		wayfire
    bemenu
    pavucontrol
    sakura
    mpv
    imv
    chafa
    swappy
    swww
    wlr-randr

    # daily use
    firefox
    appimage-run
    trayer
    go-musicfox
    tty-clock
    musescore
    telegram-desktop
    acpi
		nur.repos.linyinfeng.wemeet
		
    # cli shit
		stress-ng
		psmisc
    sshfs
    fbterm
    translate-shell
    reptyr
    neofetch
    libnotify
    inotify-tools
    wev
    lf
    grim
    slurp
    brightnessctl
    any-nix-shell

    # archives
    zip
    unar
    xz
    unzip
    p7zip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processer https://github.com/mikefarah/yq
    fzf # A command-line fuzzy finder
    fd


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
    glow # markdown previewer in terminal

    btop # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files


  ] ++ (with pkgs-ad97212 ; [
    # for a special version
    wl-clipboard
  ])
  ++ [
    # (pkgs.callPackage ./spotifox { })
  ];
}
