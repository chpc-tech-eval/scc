#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <NFS_SERVER_IP>"
    exit 1
fi

NFS_SERVER_IP=$1

echo "Setting up NFS with server IP: $NFS_SERVER_IP"

# Install NFS client utilities
sudo dnf -y install nfs-utils || { echo "Failed to install nfs-utils"; exit 1; }

# Ensure necessary directories exist
if [ ! -d "/home" ]; then
    sudo mkdir -p /home
fi

# Mount the NFS directory
sudo mount -t nfs ${NFS_SERVER_IP}:/home /home || { echo "Failed to mount NFS"; exit 1; }

# Make the mount persistent (optional)
echo "${NFS_SERVER_IP}:/home /home nfs defaults 0 0" | sudo tee -a /etc/fstab

echo "NFS setup complete."
