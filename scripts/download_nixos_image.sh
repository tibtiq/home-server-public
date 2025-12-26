#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# The following command will download and immediately run the bash script.
# curl -fsSL https://raw.githubusercontent.com/tibtiq/home-server-public/refs/heads/main/scripts/download_nixos_iamge.sh | bash

IMAGE_STORAGE_PATH="/var/lib/vz/template/cache"
URL="https://hydra.nixos.org/build/283416299/download/1/nixos-system-x86_64-linux.tar.xz"

# Construct the new filename: nixos-system-283416299.tar.xz
FULL_BASENAME=$(basename "$URL")
BASENAME_ONLY="${FULL_BASENAME%%.*}"
BUILD_ID=$(echo "$URL" | grep -oP '/build/\K\d+')
EXTENSION=".tar.xz"
NEW_FILENAME="${BASENAME_ONLY}-${BUILD_ID}${EXTENSION}"

TEMPLATE_PATH="${IMAGE_STORAGE_PATH}/${NEW_FILENAME}"
if [ -f "$TEMPLATE_PATH" ]; then
    echo "Error: The LXC template with that build ID already exists: $(basename "$TEMPLATE_PATH")"
    exit 1
fi

mkdir -p "$IMAGE_STORAGE_PATH"
curl -fL "$URL" -o "$TEMPLATE_PATH"

chmod 0644 "$TEMPLATE_PATH"
echo "Successfully download NixOS LXC image"
