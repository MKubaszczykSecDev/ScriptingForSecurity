#!/bin/bash

ipv6_addr=$(ip -6 addr show ens33 | grep inet6 | awk '{print $2}')
echo $ipv6_addr > addr.txt

hash=$(sha256sum addr.txt | awk '{print $1}')

echo " "
echo "**************************************************************************************"
echo " "
echo "The IPV6 address is: " $ipv6_addr
echo "The sha256 hash is : " $hash
echo " "
echo "**************************************************************************************"
echo " "
