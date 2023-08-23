{ config, pkgs, ... }:
{
  environment = {
    variables = rec {
      WLR_NO_HARDWARE_CURSORS="1";
      EDITOR="nvim";
    };
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    systemPackages = with pkgs; [
      git
      wget
      docker-compose

      (let base = pkgs.appimageTools.defaultFhsEnvArgs; in
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
        extraOutputsToInstall = ["dev"];
      }))
    ];
  };

}
