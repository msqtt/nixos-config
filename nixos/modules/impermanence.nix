{
  environment.persistence."/persist" = {
    enable = true; # NB: Defaults to true, not needed
    hideMounts = true;
    directories = [
      "/etc/nixos"
      "/var/log"
      "/var/lib/docker"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      # { directory = "/var/lib/colord"; user = "colord"; group = "colord"; mode = "u=rwx,g=rx,o="; }
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

        # { directory = ".gnupg"; mode = "0700"; }
        { directory = ".ssh"; mode = "0700"; }
        { directory = ".mozilla"; mode = "0700"; }
        { directory = ".thunderbird"; mode = "0700"; }
        # { directory = ".nixops"; mode = "0700"; }
        { directory = ".local/share/keyrings"; mode = "0700"; }
        #{ directory = ".local/share/TelegramDesktop"; mode = "0700"; }

        ".config/cosmic"
        ".config/cosmic-settings"
        ".config/JetBrains"
        ".config/Code"
        ".vscode" # plugin

        ".local/share/direnv"
        ".local/share/zoxide"
        ".local/share/flatpak"
        ".local/share/DBeaverData"

        # ".local/share/Steam"
        ".var/app/com.valvesoftware.Steam/.local/share/Steam"
      ];
      files = [
        # ".screenrc"
        "Makefile"
        "shell.nix"
        ".config/fcitx5/conf/classicui.conf"
        ".config/nushell/history.txt"
      ];
    };
  };
}
