#!/bin/bash
#
# Process network capture
# Return: protocal-domain-ip-port
#
# By Ky9oss

# TODO:  What network requests did a process make in total?
# iptables + tcpdump: add mark for process
#   iptables -t mangle -A OUTPUT -m owner --uid-owner 1000 -j MARK --set-mark 100
#   tcpdump -i any 'fwmark 100'
# OR ebpf?
#   sudo bpftrace -e '
#   tracepoint:syscalls:sys_enter_connect
#   /comm == "curl"/
#    {
#     printf("PID %d connecting\n", pid);
#   }
#   '
# OR network namespace isolation + tcpdump?
#   ip netns add testns
#   ip netns exec testns your_program
#   tcpdump -i <veth>


