{ config, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
		package = pkgs.neovim-nightly;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  home.file.".config/nvim" = {
    source = ./conf;
    recursive = true;
    #executable = true;  # 将其中所有文件添加「执行」权限
  };
}
