{ config, pkgs, ... }:
{
  networking = {
    hostName = "bababoi";
    wireless.iwd.enable = true;
    firewall.enable = true;
    firewall.allowedTCPPorts = [ 2017 20170 20171 8080 ];
    extraHosts = ''
      125.217.53.138 mypi
      125.217.53.186 kexie2
      43.163.233.244 kexieserver
      107.174.247.79 ti
      114.132.248.191 xyzserver
      8.219.10.91 myserver
      172.16.77.63 xyz1
      172.16.77.166 xyz2
      172.16.77.180 xyz3
      172.17.0.3 master.krejcmat.com
      172.17.0.4 slave1.krejcmat.com
    '';
  };
}
