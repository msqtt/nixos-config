#!/usr/bin/env bash
sudo nix --experimental-features "nix-command flakes" run --option substituters "https://mirrors.ustc.edu.cn/nix-channels/store" github:nix-community/disko -- --mode disko ./disko-config.nix
