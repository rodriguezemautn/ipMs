#!/bin/bash
# Script to display hostname, IP, network interfaces, and proxy information in a table format

echo -e "Hostname:\t\t\t$(hostname)"
echo -e "Public IP:\t\t\t$(curl ifconfig.me)"
echo -e "Proxy server:\t\t\t$(env | grep -i proxy | awk '{print $2}')"
echo -e "DNS servers:\t\t\t$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}')"
echo

echo -e "Interface\tIP\t\t\tMAC\t\tNetmask\t\tCIDR\t\tsubnet_mask\t\tNetwork\t\tBroadcast\tGateway\t\tNameserver\tDomainsearch"

for i in $(ip addr show | grep -o "^[0-9]*: [a-z0-9]*" | awk '{print $2}')
do
    iface=$i
    ip=$(ip addr show $i | grep "inet " | awk '{print $2}')
    mac=$(ip link show $i | grep link/ether | awk '{print $2}')        
    netmask=$(ip addr show $i | grep "inet " | awk '{print $4}')
    cidr=$(echo $ip | cut -d '/' -f2)
    ip=$( echo $ip | cut -d '/' -f1 )
    network=$(ip route show dev $i | grep "src" | awk '{print $1}' | cut -d '/' -f1)
    broadcast=$(ip addr show $i | grep "inet " | awk '{print $4}' | cut -d '/' -f1 | awk -F. '{print $1"."$2"."$3".255"}')
    gateway=$(ip route show dev $i | grep default | awk '{print $3}')
    nameserver=$(grep $i /etc/resolv.conf | grep nameserver | awk '{print $2}')
    domainsearch=$(grep $i /etc/resolv.conf | grep search | awk '{print $2}')

    if [ -z "$ip" ]; then ip="Sin informar"; fi
    if [ -z "$mac" ]; then mac="Sin informar"; fi
    if [ -z "$netmask" ]; then netmask="Sin informar"; fi    
    if [ -z "$network" ]; then network="Sin informar"; fi
    if [ -z "$broadcast" ]; then broadcast="Sin informar"; fi
    if [ -z "$gateway" ]; then gateway="Sin informar"; fi
    if [ -z "$nameserver" ]; then nameserver="Sin informar"; fi
    if [ -z "$domainsearch" ]; then domainsearch="Sin informar"; fi

   case $cidr in
            16) subnet_mask="255.255.0.0";;
            17) subnet_mask="255.255.128.0";;
            18) subnet_mask="255.255.192.0";;
            19) subnet_mask="255.255.224.0";;
            20) subnet_mask="255.255.240.0";;
            21) subnet_mask="255.255.248.0";;
            22) subnet_mask="255.255.252.0";;
            23) subnet_mask="255.255.254.0";;
            24) subnet_mask="255.255.255.0";;
            25) subnet_mask="255.255.255.128";;
            26) subnet_mask="255.255.255.192";;
            27) subnet_mask="255.255.255.224";;
            28) subnet_mask="255.255.255.240";;
            29) subnet_mask="255.255.255.248";;
            30) subnet_mask="255.255.255.252";;
            31) subnet_mask="255.255.255.254";;
            *) subnet_mask="Sin informar";;
        esac

    echo -e "$iface \t $ip \t $mac \t $netmask \t $cidr \t $subnet_mask \t  $network \t $broadcast \t  $gateway \t $nameserver \t $domainserch "
done

exit 0