#!/bin/bash
#
# Dubug with tcpdump
# $1: socks ip
#
# By Ky9oss

if [ "$(id -u)" -ne 0 ]; then
    printf "ERROR: %s\n" "$0"
    echo "Permission denied: Run this scirpt in sudo"
    exit 1
fi

PCAP_FILE="capture.pcap"

tcpdump -i 1 ip proto 6 -w "$PCAP_FILE" &
# tcpdump -i 1 host docker.io -w "$PCAP_FILE" &

# $! only used for background process
pid=$!

podman run docker.io/library/hello-world

kill $pid

# -vvv   Even more verbose output.
# -XX    print the data of each packet in hex and ASCII.
# -tttt  Print a human-readable timestamp
# tcpdump -r "$PCAP_FILE" -vvv -XX -tttt

tshark -r capture.pcap -Y "ip.addr == $1" -V

# $ getent protocols
# ip                    0 IP
# hopopt                0 HOPOPT
# icmp                  1 ICMP
# igmp                  2 IGMP
# ggp                   3 GGP
# ipencap               4 IP-ENCAP
# st                    5 ST
# tcp                   6 TCP
# egp                   8 EGP
# igp                   9 IGP
# pup                   12 PUP
# udp                   17 UDP
# hmp                   20 HMP
# xns-idp               22 XNS-IDP
# rdp                   27 RDP
# iso-tp4               29 ISO-TP4
# dccp                  33 DCCP
# xtp                   36 XTP
# ddp                   37 DDP
# idpr-cmtp             38 IDPR-CMTP
# ipv6                  41 IPv6
# ipv6-route            43 IPv6-Route
# ipv6-frag             44 IPv6-Frag
# idrp                  45 IDRP
# rsvp                  46 RSVP
# gre                   47 GRE
# esp                   50 IPSEC-ESP
# ah                    51 IPSEC-AH
# skip                  57 SKIP
# ipv6-icmp             58 IPv6-ICMP
# ipv6-nonxt            59 IPv6-NoNxt
# ipv6-opts             60 IPv6-Opts
# rspf                  73 RSPF CPHB
# vmtp                  81 VMTP
# eigrp                 88 EIGRP
# ospf                  89 OSPFIGP
# ax.25                 93 AX.25
# ipip                  94 IPIP
# etherip               97 ETHERIP
# encap                 98 ENCAP
# pim                   103 PIM
# ipcomp                108 IPCOMP
# vrrp                  112 VRRP
# l2tp                  115 L2TP
# isis                  124 ISIS
# sctp                  132 SCTP
# fc                    133 FC
# mobility-header       135 Mobility-Header
# udplite               136 UDPLite
# mpls-in-ip            137 MPLS-in-IP
# manet                 138
# hip                   139 HIP
# shim6                 140 Shim6
# wesp                  141 WESP
# rohc                  142 ROHC
# ethernet              143 Ethernet
# mptcp                 262 MPTCP
