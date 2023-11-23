{ ... }:

(self: super: {
  rime-data = ./rime;
  fcitx5-rime = super.fcitx5-rime.override {
    rimeDataPkgs = [ ./rime ];
  };
})
