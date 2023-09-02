{ config, pkgs, ... }:
{
  home.file.".config/lf/lfrc".source = ./conf/lfrc;
  home.file.".config/lf/previewer" = {
		text = builtins.readFile ./conf/previewer;
    executable = true;
	};
  home.file.".config/lf/cleaner" = {
		text = builtins.readFile ./conf/cleaner;
    executable = true;
	};
}
