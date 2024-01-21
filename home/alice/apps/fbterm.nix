{ pkgs
, ...

}: {
  home.packages = with pkgs;[
    fbterm
    fbcat
  ];
  home.file.".config/fbtermrc".text = ''
    font-names=Source Code Pro
    font-size=26
    history-lines=65535
    cursor-shape=1
    cursor-interval=500
  '';
}
