{ config, pkgs, pkgs-4469e2, ... }:
{
  # git 相关配置
  programs.git = {
    enable = true;
    userName = "msqtt";
    userEmail = "mosquito@email.cn";
  };

  # cli 
  programs.gh = {
    enable = true;
    package = pkgs-4469e2.gh;
    settings = {
      git_protocol = "ssh";
      editor = "vim";
      aliases = {
        co = "pr checkout";
        pv = "pr view";
      };
    };
  };

  # lazygit tui 工具配置
  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        showIcons = true;
        # nerdFontsVersion = "3";
      };
      keybinding = {
        universal = {
          prevItem-alt = "e"; # go one line up
          nextItem-alt = "n"; # go one line down
          scrollLeft = "Y";
          scrollRight = "O";
          prevBlock-alt = "y"; # goto the previous block / panel
          nextBlock-alt = "o"; # goto the next block / panel
          nextMatch = "j";
          prevMatch = "J";
          new = "c";
          edit = "";
          openFile = "x";
        };
        branches = {
          createPullRequest = "";
          viewPullRequestOptions = "";
        };
      };
    };
  };
}

