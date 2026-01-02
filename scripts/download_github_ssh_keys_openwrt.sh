#!/bin/bash

# The following command will download and immediately run the bash script.
# curl -fsSL https://raw.githubusercontent.com/tibtiq/home-server-public/refs/heads/main/scripts/download_github_ssh_keys_openwrt.sh | bash

set -euo pipefail
IFS=$'\n\t'

curl "https://github.com/tibtiq.keys" >/etc/dropbear/authorized_keys
