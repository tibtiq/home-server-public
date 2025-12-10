#!/bin/sh

# The following command will download and immediately run the bash script.
# curl -fsSL https://raw.githubusercontent.com/tibtiq/home-server-public/refs/heads/main/nixos/proxmox_lxc/scripts/setup.sh | bash

NIX_CONFIG_PATH='/etc/nixos/configuration.nix'

# download config
curl \
  --show-error \
  --fail \
  https://raw.githubusercontent.com/tibtiq/home-server-public/refs/heads/main/nixos/proxmox_lxc/proxmox_lxc.nix \
  >${NIX_CONFIG_PATH}

nix-channel --update --sudo && nixos-rebuild switch --upgrade --option extra-experimental-features "nix-command flakes" --sudo
