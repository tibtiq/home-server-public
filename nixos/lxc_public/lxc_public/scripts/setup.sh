#!/bin/sh
NIX_CONFIG_PATH='/etc/nixos/configuration.nix'

# download config
curl \
  --show-error \
  --fail \
  https://raw.githubusercontent.com/tibtiq/home-server-public/refs/heads/main/nixos/lxc_public/lxc_public/proxmox_lxc_config.nix \
  >${NIX_CONFIG_PATH}

sudo nix-channel --update && sudo nixos-rebuild switch --upgrade
