#!/bin/bash
# Update system
sudo dnf update -y

# Install tools
sudo dnf install -y net-tools iproute vim nfs-utils

# Set hostname
sudo hostnamectl set-hostname computenode

# Detect NAT and internal network interfaces automatically
NAT_IF=$(ip -o link show | awk -F': ' '{print $2}' | grep -E 'enp0s3|eth0' | head -n1)
INT_IF=$(ip -o link show | awk -F': ' '{print $2}' | grep -E 'enp0s[0-9]+|eth[0-9]+' | tail -n1)

# Disable NAT interface so it doesn't interfere
sudo ip link set $NAT_IF down

# Configure internal network
sudo ip addr add 10.0.0.2/24 dev $INT_IF
sudo ip link set $INT_IF up

# Set default route via headnode
sudo ip route add default via 10.0.0.1 dev $INT_IF

# Add /etc/hosts entries for cluster nodes
echo "10.0.0.1 headnode" | sudo tee -a /etc/hosts
echo "10.0.0.2 computenode" | sudo tee -a /etc/hosts
