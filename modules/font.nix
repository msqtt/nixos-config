{ config, pkgs, ... }:
{
  fonts = {
		packages = with pkgs; [
			noto-fonts
			noto-fonts-cjk
			noto-fonts-emoji
			source-han-sans
			source-han-serif
			source-code-pro
			maple-mono
			maple-mono-NF
			jetbrains-mono
		];
	};
}
