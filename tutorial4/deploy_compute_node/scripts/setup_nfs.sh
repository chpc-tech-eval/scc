#!/bin/bash

# Ensure an NFS IP is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <NFS_SERVER_IP>"
  exit 1
fi

NFS_SERVER_IP="$1"

# Install NFS common utilities
echo "Installing NFS utilities..."
sudo apt update
sudo NEEDRESTART_MODE=a apt install nfs-common --yes

# Mount the NFS share
echo "Mounting NFS share from $NFS_SERVER_IP..."
sudo mount -t nfs ${NFS_SERVER_IP}:/home /home

if [ $? -eq 0 ]; then
  echo "NFS setup completed successfully."
else
  echo "NFS setup failed."
  exit 1
fi
