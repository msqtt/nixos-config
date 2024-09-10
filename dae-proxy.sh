#!/usr/bin/env bash
# for install system
cat << EOF >/run/systemd/system/nix-daemon.service.d/override.conf
[Service]
Environment="https_proxy=socks5h://192.168.100.5:20170"
EOF
sudo systemctl daemon-reload
sudo systemctl restart nix-daemon
