{ config, pkgs, pkgs-77ed358, ... }:
{
  imports = [
    ./lf
    ./mako
    ./tmux
    ./direnv
    ./terminal
    ./pdf
    ./obs
		./qutebrowser
    ./misc
  ];

  home.packages = with pkgs;[
    # develop shit
    subversion

    # base shit
		bemenu
    pavucontrol
    sakura
    mpv
    imv
    chafa
    swappy
    swww
    wlr-randr
    wl-clipboard

    # daily use
		asciidoctor
		grc
		swaylock
		flameshot
    firefox
    appimage-run
    trayer
    go-musicfox
    tty-clock
    musescore
    acpi
    nur.repos.linyinfeng.wemeet

    # cli shit
		dogdns
		gping
		du-dust
		delta
		httpie
		cheat
		netcat
		htmlq
    devbox
    gh
    lynx
    browsh
    stress-ng
    psmisc
    sshfs
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
    btop # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files


  ]
  # ++ (with pkgs-77ed358 ; [
  #  ])
  ++ [
    (pkgs.callPackage ./bobibo { })
  ];
}
