{ lib
, buildGoModule
, fetchFromGitHub
, pkg-config
, nix-update-script
}:

buildGoModule rec {
  pname = "bobibo";
  version = "1.4.0";

  src = fetchFromGitHub {
    owner = "msqtt";
    repo = pname;
    rev = "v${version}";
    hash = "";
  };

  deleteVendor = true;

  vendorHash = "";
  subPackages = [ "cli/cli.go" ];

  ldflags = [ "-s" "-w" "-X github.com/msqtt/bobbibo/pkg/constants.AppVersion=${version}" ];

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [];

  passthru.updateScript = nix-update-script { };

  meta = with lib; {
    description = "";
    homepage = "https://github.com/msqtt/bobibo";
    license = licenses.gpl3;
    mainProgram = "bobibo";
    maintainers = with maintainers; [ msqtt ];
  };
}
