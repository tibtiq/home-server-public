#!/bin/bash

# The following command will download and immediately run the bash script.
# bash <(wget -qO- https://raw.githubusercontent.com/tibtiq/home-server-public/refs/main/publish-files-from-private/scripts/create_user.sh)

if [[ -z "$1" ]]; then
    echo "Usage: $0 <username>"
    exit 1
fi

username="$1"

# create the user with the default home directory location and bash shell.
if useradd -m -s /bin/bash "$username" 2>&1 | grep -q "already exists"; then
    echo "User $username already exists."
    exit 1
fi

# add them to the sudo group
usermod -aG sudo "$username"

# set a password (if you want, not required if using ssh keys to log in)
# passwd "$username"
