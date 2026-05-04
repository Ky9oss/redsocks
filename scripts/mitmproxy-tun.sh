#!/bin/bash
#
# Mitmproxy with TUN
#
# By Ky9oss

if [ "$(id -u)" -ne 0 ]; then
    printf "ERROR: %s\n" "$0"
    echo "Permission denied: Run this scirpt in sudo"
    exit 1
fi

ip address | grep tun0

if [[ $? -ne 0 ]]; then
    printf "ERROR: %s\n" "$0"
    echo "Mitmproxy is not Runing: Run \"sudo mitmdump --mode tun\" first."
    exit 1
fi

# Disable reverse path filtering.
sysctl -w net.ipv4.conf.all.rp_filter=0
sysctl -w net.ipv4.conf.tun0.rp_filter=0

# TODO: route for limited ip sets: ipset + iptables + fmark
# ipset create mydomains hash:ip
# ipset add mydomains 93.184.xxx.xxx OR dnsmasq --ipset=/example.com/mydomains
# iptables -t mangle -A OUTPUT -m set --match-set mydomains dst -j MARK --set-mark 20
# ip rule add fwmark 20 lookup 20

# Route
ip route add default dev tun0 table 20
ip rule add lookup 20 pref 20
ip -6 route add default dev tun0 table 20
ip -6 rule add lookup 20 pref 20

# Delete Route
ip rule del lookup 20 pref 20
ip route del default dev tun0 table 20
ip -6 rule del lookup 20 pref 20
ip -6 route del default dev tun0 table 20
