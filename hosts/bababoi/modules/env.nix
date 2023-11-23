{ config, pkgs, ... }:
{
  environment = {
    variables = rec {
      EDITOR = "nvim";
      # LIBSEAT_BACKEND = "logind";
      LIBVIRT_DEFAULT_URI = "qemu:///system";
    };
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    systemPackages = with pkgs; [
      gcc
      git
      wget
      docker-compose
      virt-manager
      qemu_kvm

      (
        let base = pkgs.appimageTools.defaultFhsEnvArgs; in
        pkgs.buildFHSUserEnv (base // {
          name = "fhs";
          targetPkgs = pkgs: (
            with pkgs; [
              pkg-config
              ncurses
              # 如果你的 FHS 程序还有其他依赖，把它们添加在这里
            ]
          );
          profile = "export IN_NIX_SHELL=1";
          runScript = "fish";
          extraOutputsToInstall = [ "dev" ];
        })
      )
    ];
  };
}
