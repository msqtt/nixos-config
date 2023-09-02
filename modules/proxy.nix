{ config, pkgs, ... }:
{
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  programs.proxychains = {
    enable = true;
    quietMode = true;
    proxies = {
      v2raya-socks5 = {
        enable = true;
        type = "socks5";
        host = "127.0.0.1";
        port = 20170;
      };
    };
  };
}
