#!/bin/bash

# The following command will download and immediately run the bash script.
# curl -fsSL https://raw.githubusercontent.com/tibtiq/home-server-public/refs/heads/main/scripts/setup_proxmox_server.sh | bash -s -- USERNAME

set -euo pipefail
IFS=$'\n\t'

if [[ $# -eq 0 || -z "$1" ]]; then
    echo "Usage: $0 <username>"
    exit 1
fi
username="$1"

curl -fsSL https://raw.githubusercontent.com/tibtiq/home-server-public/refs/heads/main/scripts/create_user.sh | bash -s -- "$username"
su - ""$username" -c "curl -fsSL https://raw.githubusercontent.com/tibtiq/home-server-public/refs/heads/main/scripts/download_github_ssh_keys.sh | bash