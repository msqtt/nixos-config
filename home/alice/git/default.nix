{ config, pkgs, ... }:
{
  # git 相关配置
  programs.git = {
    enable = true;
    userName = "mosquito";
    userEmail = "mosquito@email.cn";
  };
}

