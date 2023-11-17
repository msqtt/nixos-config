{ config, pkgs, ... }:
{
  services = {
    # List services that you want to enable:
    # Enable the OpenSSH daemon.
    openssh={
			enable = true;
			settings = {
				PasswordAuthentication = false;
				PermitRootLogin = "no";
			};
		};
    # Enable CUPS to print documents.
    printing.enable = true;
    # v2raya proxy
    v2raya.enable = true;
    tlp.enable = true;
		tailscale.enable = true;
    eternal-terminal.enable = true;
  };

}
