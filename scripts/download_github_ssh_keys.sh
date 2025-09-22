#!/bin/bash

# The following command will download and immediately run the bash script.
# bash <(wget -qO- https://raw.githubusercontent.com/tibtiq/home-server-public/refs/heads/main/scripts/download_github_ssh_keys.sh)

set -euo pipefail
IFS=$'\n\t'

mkdir -p ~/.ssh && curl "https://github.com/tibtiq.keys" > ~/.ssh/authorized_keys
