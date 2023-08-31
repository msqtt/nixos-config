{ config, pkgs, pkgs-new, ... }:
{
  imports = [
    ./lf
    ./mako
    ./tmux
    ./direnv
    ./terminal
    ./pdf
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

    firefox
    appimage-run
    # daily use
    trayer
    go-musicfox
    tty-clock
    musescore
    telegram-desktop
    acpi


    # cli shit
		reptyr
    neofetch
		libnotify
    wev
    lf
    grim
    slurp
    brightnessctl
    any-nix-shell

    # archives
    zip
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


  ] ++ (with pkgs-new ; [
		# for new version
		wl-clipboard
  ]); 
}
