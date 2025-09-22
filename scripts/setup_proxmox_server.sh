#!/bin/bash

# The following command will download and immediately run the bash script.
# curl -fsSL https://raw.githubusercontent.com/tibtiq/home-server-public/refs/heads/main/scripts/setup_proxmox_server.sh) | bash -s -- USERNAME

set -euo pipefail
IFS=$'\n\t'

curl -fsSL https://raw.githubusercontent.com/tibtiq/home-server-public/refs/heads/main/scripts/create_user.sh | bash -s -- "$@"
curl -fsSL https://raw.githubusercontent.com/tibtiq/home-server-public/refs/heads/main/scripts/download_github_ssh_keys.sh | bash