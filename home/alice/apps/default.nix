{ config, pkgs, ... }:
{
  imports = [
    ./lf
    ./mako
    ./tmux
  ];

  # 通过 home.packages 安装一些常用的软件
  # 这些软件将仅在当前用户下可用，不会影响系统级别的配置
  # 建议将所有 GUI 软件，以及与 OS 关系不大的 CLI 软件，都通过 home.packages 安装
  home.packages = with pkgs;[
    # language shit
    nodejs
    gcc
    # base shit
    bemenu
    hikari
    pavucontrol
    sakura
    firefox
    v2raya
    lazygit
    # daily use
    go-musicfox
    tty-clock
    musescore
    telegram-desktop

    # 如下是我常用的一些命令行工具，你可以根据自己的需要进行增删
    neofetch
    wev
    lf
    wl-clipboard
    grim
    slurp
    brightnessctl

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
    nil

    # productivity
    glow # markdown previewer in terminal

    btop  # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files
  ];
}
