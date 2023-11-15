{ config, pkgs, ... }:
{
	# for firefox to show markdown
  home.file.".mime.types".text = ''type=text/plain exts=md,mkd,mkdn,mdwn,mdown,markdown, desc="Markdown document"'';
}
