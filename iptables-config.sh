#!/bin/bash
#
# Configure iptables rules for current user. 
# This is used for redsocks.
#
# By Ky9oss

if [ "$(id -u)" -ne 0 ]; then
    echo "Permission denied: Run this scirpt in sudo"
    echo "Example: sudo $0"
    exit
fi

sudo -u "$SUDO_USER" whoami
sudo -u "$USER" whoami
