#!/bin/bash

echo -e "\n" 
echo -e "\n"
echo -e "Bridged network interface IPv4 information:\n"
echo "$(ifconfig eth1 | grep "inet addr:")"
echo -e "\n"
echo "Bridged network interface IPv6 information:"
echo "$(ifconfig eth1 | grep "inet6 addr:")"
echo -e "Access the SmokePing VM using http://ip.address/cgi-bin/smokeping.cgi"
