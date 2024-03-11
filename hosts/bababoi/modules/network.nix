{ config, pkgs, ... }:
{
  networking = {
    hostName = "bababoi";
    wireless.iwd.enable = true;
    firewall.enable = true;
    firewall.allowedTCPPorts = [ 20170 20171 8080 4321 ];
    # this will proxy whole system.
    # proxy = { 
    #   default = "http://127.0.0.1:20171";
    #   noProxy = "127.0.0.1,localhost,internal.domain";
    # };
    extraHosts = ''
      125.217.53.138 mypi
      125.217.52.212 kexie2
      43.163.233.244 kexieserver
      107.174.247.79 ti
      114.132.248.191 xyzserver
      8.219.10.91 myserver
      172.16.77.63 xyz1
      172.16.77.166 xyz2
      172.16.77.180 xyz3
    '';
  };
}
