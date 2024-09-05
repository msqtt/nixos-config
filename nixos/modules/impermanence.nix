{
  environment.persistence."/nix/persist" = {
    enable = true;  # NB: Defaults to true, not needed
    hideMounts = true;
    directories = [
      "/etc/nixos"
      "/var/log"
      "/var/lib/docker"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      { directory = "/var/lib/colord"; user = "colord"; group = "colord"; mode = "u=rwx,g=rx,o="; }
      "/etc/daed"
      "/etc/NetworkManager/system-connections"
    ];
    files = [
      "/etc/machine-id"
      { file = "/var/keys/secret_file"; parentDirectory = { mode = "u=rwx,g=,o="; }; }
    ];
    users.bob = {
      directories = [
        "Bin"
        "Documents"
        "Projects"
        "VirtualBox VMs"

        { directory = ".gnupg"; mode = "0700"; }
        { directory = ".ssh"; mode = "0700"; }
        { directory = ".mozilla"; mode = "0700"; }
        { directory = ".thunderbird"; mode = "0700"; }
        # { directory = ".nixops"; mode = "0700"; }
        { directory = ".local/share/keyrings"; mode = "0700"; }
        { directory = ".local/share/TelegramDesktop"; mode = "0700"; }

        ".config/Code"
        ".local/share/direnv"
        
        ".vscode"
        ".local/share/zoxide"
      ];
      files = [
        # ".screenrc"
        "Makefile"
        ".config/fcitx5/conf/classicui.conf"
        ".config/nushell/history.txt"
      ];
    };
  };
}
