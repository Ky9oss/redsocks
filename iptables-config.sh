#!/bin/bash
#
# Enable Linux kernel REDIRECT rule by iptables for tranparent proxy
# $1: on | off
#
# By Ky9oss

REDSOCKS_PORT=12345
REDIRECT_USER=root

if [ "$(id -u)" -ne 0 ]; then
    printf "ERROR: %s\n" "$0"
    echo "Permission denied: Run this scirpt in sudo"
    exit 1
fi

action="on"

if [[ -n $1 ]]; then
    action="$1"
fi

# sudo -u "$SUDO_USER" whoami
# sudo -u "$USER" whoami

if [ "$action" = on ]; then
    iptables -L REDSOCKS -t nat | grep RETURN
    if [ $? -eq 1 ]; then
        iptables -t nat -N REDSOCKS 2>/dev/null

        iptables -t nat -A REDSOCKS -d 0.0.0.0/8 -j RETURN
        iptables -t nat -A REDSOCKS -d 10.0.0.0/8 -j RETURN
        iptables -t nat -A REDSOCKS -d 100.64.0.0/10 -j RETURN
        iptables -t nat -A REDSOCKS -d 127.0.0.0/8 -j RETURN
        iptables -t nat -A REDSOCKS -d 169.254.0.0/16 -j RETURN
        iptables -t nat -A REDSOCKS -d 172.16.0.0/12 -j RETURN
        iptables -t nat -A REDSOCKS -d 192.168.0.0/16 -j RETURN
        iptables -t nat -A REDSOCKS -d 198.18.0.0/15 -j RETURN
        iptables -t nat -A REDSOCKS -d 224.0.0.0/4 -j RETURN
        iptables -t nat -A REDSOCKS -d 240.0.0.0/4 -j RETURN

        iptables -t nat -A REDSOCKS -p tcp -j REDIRECT --to-ports $REDSOCKS_PORT

        # iptables -t nat -A OUTPUT -p tcp -m owner --uid-owner $SUDO_USER -j REDSOCKS
        iptables -t nat -A OUTPUT -p tcp -m owner --uid-owner $REDIRECT_USER -j REDSOCKS

        # groupadd redsocks 2>/dev/null
        # usermod --append --groups redsocks $SUDO_USER 2>/dev/null
        # iptables -t nat -A OUTPUT -p tcp -m owner --gid-owner redsocks -j REDSOCKS

        # iptables -L REDSOCKS -t nat
        echo "Done: Rules have added"
    else
        printf "ERROR: %s\n" "$0"
        echo "The rules in iptables had set. Run \"./iptables-config.sh off\" to clean them."
        exit 1
    fi
elif [ "$action" = off ]; then
    iptables -t nat -F REDSOCKS
    # iptables -t nat -D OUTPUT -p tcp -m owner --uid-owner $SUDO_USER -j REDSOCKS
    iptables -t nat -D OUTPUT -p tcp -m owner --uid-owner $REDIRECT_USER -j REDSOCKS
    # iptables -t nat -D OUTPUT -p tcp -m owner --gid-owner redsocks -j REDSOCKS

    # iptables -L REDSOCKS -t nat
    echo "Done: Rules have removed"
else
    printf "ERROR: %s\n" "$0"
    echo "$1 is not a valid parameter."
    exit 1
fi

exit 0
