#!/bin/bash

# Obtener el hostname
hostname=$(hostname)

# Obtener la IP pública
ip_publica=$(curl ipinfo.io/ip)

# Obtener el servidor proxy
proxy=$(grep -i "http_proxy" /etc/environment | awk -F "=" '{print $2}')

# Obtener el DNS
dns=$(cat /etc/resolv.conf | grep -i "nameserver" | awk '{print $2}')

# Obtener la información de la interfaz de red
interfaz=$(ip route | awk '{print $3}')
ip_local=$(ip addr show $interfaz | grep -i "inet" | awk '{print $2}')
mac_address=$(ip link show $interfaz | grep -i "link/ether" | awk '{print $2}')
netmask=$(ip addr show $interfaz | grep -i "inet" | awk '{print $4}')
network=$(ip route | grep -i "src" | awk '{print $1}')
broadcast=$(ip addr show $interfaz | grep -i "inet" | awk '{print $4}')
gateway=$(ip route | grep -i "default" | awk '{print $3}')
nameserver=$(cat /etc/resolv.conf | grep -i "nameserver" | awk '{print $2}')
domainsearch=$(cat /etc/resolv.conf | grep -i "search" | awk '{print $2}')

# Imprimir la tabla
echo "hostname     IP Pública     Servidor proxy     DNS"
echo "---------------------------------------------------"
echo "$hostname    $ip_publica    $proxy    $dns"
echo ""
echo "Interfaz     IP Local     MAC Address     Netmask     Network     Broadcast     Gateway     Nameserver     Domainsearch"
echo "----------------------------------------------------------------------------------------------------------------------------"
if [ -z "$interfaz" ]; then
    interfaz="Sin informar"
fi
if [ -z "$ip_local" ]; then
    ip_local="Sin informar"
fi
if [ -z "$mac_address" ]; then
    mac_address="Sin informar"
fi
if [ -z "$netmask" ]; then
    netmask="Sin informar"
fi
if [ -z "$network" ]; then
    network="Sin informar"
fi
if [ -z "$broadcast" ]; then
    broadcast="Sin informar"
fi
if [ -z "$gateway" ]; then
    gateway="Sin informar"
fi
if [ -z "$nameserver" ]; then
    nameserver="Sin informar"
fi
