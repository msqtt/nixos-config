{ config, pkgs, ... } @inputs:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "bob";
  home.homeDirectory = "/home/bob";

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    lolcat
    figlet
    cowsay
    firefox
    google-chrome
    telegram-desktop
    thunderbird
    vscode
  ] ++ (with inputs.my-nur; [
    bobibo
  ]);

  programs.git = {
    enable = true;
    userName  = "msqtt";
    userEmail = "mosquito@email.cn";
    aliases = {
      ci = "commit";
      co = "checkout";
      s = "status";
    };

  };

  programs.gh = {
    enable = true;
    settings.git_protocol = "ssh";
  };

  programs = {
    nushell = { 
      enable = true;
      # The config.nu can be anywhere you want if you like to edit your Nushell with Nu
      # configFile.source = ./.../config.nu;
      # for editing directly to config.nu 
      extraConfig = ''
       let carapace_completer = {|spans|
       carapace $spans.0 nushell $spans | from json
       }
       $env.config = {
        show_banner: false,
        completions: {
          case_sensitive: false # case-sensitive completions
          quick: true    # set to false to prevent auto-selecting completions
          partial: true    # set to false to prevent partial filling of the prompt
          algorithm: "fuzzy"    # prefix or fuzzy
          external: {
            # set to false to prevent nushell looking into $env.PATH to find more suggestions
            enable: true 
            # set to lower can improve completion performance at the cost of omitting some options
            max_results: 100 
            completer: $carapace_completer # check 'carapace_completer' 
          }
        }
       } 
       $env.PATH = ($env.PATH | 
       split row (char esep) |
       prepend /home/bob/Bin |
       append /usr/bin/env
       )
       $env.EDITOR = "code"
       '';
      shellAliases = {
        ll = "ls -l";
        la = "ls -a";
        lla = "ls -la";
      };
   };  

  carapace = {
    enable = true;
    enableNushellIntegration = true;
  };
  
  thefuck = {
    enable = true;
    enableNushellIntegration = true;
  };

  direnv = {
    enable = true;
    enableNushellIntegration = true;
  };

  zoxide = {
    enable = true;
    enableNushellIntegration = true;
  };
   starship = {
      enable = true;
      enableNushellIntegration = true;
       settings = {
         add_newline = true;
         character = { 
          success_symbol = "[➜](bold green)";
          error_symbol = "[➜](bold red)";
       };
      };
  };
};

  imports = [
    ./plasma.nix
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
