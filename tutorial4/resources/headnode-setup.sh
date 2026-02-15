#!/bin/bash
# Update system
sudo dnf update -y

# Install necessary tools
sudo dnf install -y net-tools iproute traceroute vim nfs-utils iptables-services

# Set hostname (optional if done in Vagrantfile)
sudo hostnamectl set-hostname headnode

# Configure internal network
sudo ip addr add 10.0.0.1/24 dev enp0s8
sudo ip link set enp0s8 up

# Enable IP forwarding immediately and permanently
sudo sysctl -w net.ipv4.ip_forward=1
sudo bash -c "echo 'net.ipv4.ip_forward=1' >> /etc/sysctl.conf"
sudo sysctl -p

# Clear existing rules to avoid conflicts
sudo iptables -F
sudo iptables -t nat -F
sudo iptables -X

# Set default policies
sudo iptables -P FORWARD ACCEPT

# NAT for compute nodes to reach the internet
sudo iptables -t nat -A POSTROUTING -s 10.0.0.0/24 -o enp0s3 -j MASQUERADE
sudo iptables -A FORWARD -i enp0s8 -o enp0s3 -j ACCEPT
sudo iptables -A FORWARD -i enp0s3 -o enp0s8 -m state --state RELATED,ESTABLISHED -j ACCEPT

# Save rules persistently
sudo service iptables save
sudo systemctl enable iptables
sudo systemctl restart iptables

# Add /etc/hosts entries for cluster nodes
echo "10.0.0.1 headnode" | sudo tee -a /etc/hosts
echo "10.0.0.2 computenode" | sudo tee -a /etc/hosts
