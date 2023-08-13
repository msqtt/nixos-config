{ pkgs, ... }:

let
  buildTmuxPlugin = pkgs.tmuxPlugins.mkTmuxPlugin;
in
{
  net-speed = buildTmuxPlugin {
    pluginName = "net-speed";
    version = "fork-2022-11-15";
    src = builtins.fetchTarball {
      name   = "Tmux-Net-Speed-2022-11-15";
      url    = "https://github.com/wfxr/tmux-net-speed/archive/bc91d6ea3b3b6c4d5f9367f0b543f0ae890ce521.tar.gz";
      sha256 = "025ai8cbzn4gvdjv3lcpnsq0lhm95024zyqjqzaisi9nv5q4v2z5";
    };
  };
}

