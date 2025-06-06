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

# setup group that can sudo with no password
groupadd sudo_no_password

# update group to allow passwordless sudo
LINE='%sudo_no_password ALL=(ALL) NOPASSWD: ALL'
FILE='/etc/sudoers'
if sudo grep -Fxq "$LINE" "$FILE"; then
    echo "Passwordless sudo setting for group sudo_no_password already exists in $FILE"
fi
echo "$LINE" | sudo EDITOR='tee -a' visudo

# add them to the group
usermod -aG sudo_no_password "$username"

# install sudo
apt install sudo

# set a password (if you want, not required if using ssh keys to log in)
# passwd "$username"
