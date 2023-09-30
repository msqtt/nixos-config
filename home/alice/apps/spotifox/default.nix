{ lib
, buildGoModule
, fetchFromGitHub
, pkg-config
, alsa-lib
, flac
, nix-update-script
}:

buildGoModule rec {
  pname = "spotifox";
  version = "1.0.1";

  src = fetchFromGitHub {
    owner = "go-musicfox";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-UTBHNTmjv20L27Eyb2XYm2cd+vXg7lPW0WNbLzHb6aM=";
  };

  deleteVendor = true;

  vendorHash = "sha256-MLCF+gaOqyS1GdzRvOLXScV7nFmzSirMhRvKj6M+GPE=";
  subPackages = [ "cmd/spotifox.go" ];

  ldflags = [
    "-s"
    "-w"
    "-X github.com/go-musicfox/spotifox/pkg/constants.AppVersion=${version}"
  ];

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    alsa-lib
    flac
  ];

  passthru.updateScript = nix-update-script { };

  meta = with lib; {
    description = "Spotifox is yet another spotify CLI client similar to go-mousicfox.";
    homepage = "https://github.com/go-musicfox/spotifox";
    license = licenses.mit;
    mainProgram = "spotifox";
    maintainers = with maintainers; [ zendo Ruixi-rebirth aleksana ];
  };
}
