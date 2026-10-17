# nixos/modules/hermes-agent.nix
#
# Hermes Agent as a SYSTEM-level systemd service running as root.
#
# Rationale: user wants hermes to fully manage this NixOS machine and
# self-compile (make os / nixos-rebuild switch / nix flake update ...).
# This gives hermes root from birth so it never needs setuid escalation.
# Blast radius matches the doas wheelNeedsPassword=false the user
# already accepted in the prior turn ("这是你配置组合的预期效果").
#
# What we deliberately disable vs the upstream nixosModules.default:
#   - dedicated hermes user/group (we run as root)
#   - OCI container mode (root on host is enough)
#   - stateDir/tmpfiles juggling (we keep HERMES_HOME at /home/bob/.hermes
#     so existing sessions/skills/memory carry over)
#
{ config, lib, pkgs, inputs, ... }:

with lib;

let
  cfg = config.services.hermes-agent;
  hermesPkg = inputs.hermes-agent.packages.${pkgs.stdenv.hostPlatform.system}.default;
  hermesHome = "/home/bob/.hermes";
in
{
  options.services.hermes-agent = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Run hermes-agent as a system-level systemd service (User=root).";
    };
    environment = mkOption {
      type = types.attrsOf types.str;
      default = { };
      description = "Extra environment variables for the hermes-agent service.";
    };
    environmentFile = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = "Path to a systemd EnvironmentFile (one KEY=VALUE per line).";
    };
  };

  config = mkIf cfg.enable {

    # Put hermes CLI on the system PATH for any shell.
    environment.systemPackages = [ hermesPkg ];

    # One-time migration: the old user-level service ran as bob, so
    # /home/bob/.hermes is bob-owned (often mode 0600). Take ownership
    # so the root-running service has uniform read/write access.
    system.activationScripts.hermes-agent-migrate = {
      text = ''
        mkdir -p ${hermesHome}
        if [ "$(stat -c %u ${hermesHome} 2>/dev/null)" != "0" ]; then
          chown -R root:root ${hermesHome} || true
        fi
        # Ensure root can read+write every file (bob may have left some
        # at mode 0600).
        find ${hermesHome} -type f -exec chmod u+rw {} + 2>/dev/null || true
        find ${hermesHome} -type d -exec chmod u+rwx {} + 2>/dev/null || true
      '';
    };

    systemd.services.hermes-agent = {
      description = "Hermes Agent Gateway (system, User=root)";
      wantedBy = [ "multi-user.target" ];
      after = [ "network-online.target" "nix-daemon.socket" ];
      wants = [ "network-online.target" ];

      serviceConfig = {
        Type = "simple";
        User = "root";
        Group = "root";
        WorkingDirectory = "/home/bob";
        ExecStart = "${hermesPkg}/bin/hermes gateway";
        Restart = "on-failure";
        RestartSec = "5s";

        # As root we want the full machine accessible by design.
        NoNewPrivileges = false;
        ProtectSystem = "no";
        ProtectHome = "no";
        PrivateTmp = false;

        # Inject the secret env file when configured.
        EnvironmentFile = mkIf (cfg.environmentFile != null) cfg.environmentFile;

        # Inline environment (sd-directive form: list of KEY=VAL).
        Environment = [
          "HOME=/home/bob"
          "HERMES_HOME=${hermesHome}"
          "HERMES_MANAGED=nixos"
          "PATH=${lib.makeBinPath [
            pkgs.bash pkgs.coreutils pkgs.findutils pkgs.gnugrep pkgs.gnused
            pkgs.git pkgs.gnumake pkgs.nix pkgs.ripgrep pkgs.fd pkgs.bat
            hermesPkg
          ]}:/run/current-system/sw/bin:/run/wrappers/bin"
        ] ++ (mapAttrsToList (k: v: "${k}=${v}") cfg.environment);
      };
    };
  };
}
