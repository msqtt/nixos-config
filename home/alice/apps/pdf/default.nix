{ pkgs, ...}:
{
	programs.zathura = {
		enable = true;
		mappings = {
			N = "half-down";
			E = "half-up";
			Y = "previous";
			O = "next";
		};
		options = {
			selection-clipboard="clipboard";
		};
	};
}

