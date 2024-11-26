#!/bin/bash

# Fix NeedRestart behavior to automatically restart services
echo "Changing NeedRestart behavior..."
sudo sed -i 's/#\$nrconf{restart} = "i";/\$nrconf{restart} = "a";/' /etc/needrestart/needrestart.conf

# Update the apt sources list for the Mantic repository
echo "Updating apt sources..."
sudo rm -f /etc/apt/sources.list

sudo tee /etc/apt/sources.list <<EOF
deb http://old-releases.ubuntu.com/ubuntu mantic main restricted universe multiverse
deb http://old-releases.ubuntu.com/ubuntu mantic-security main restricted universe multiverse
deb http://old-releases.ubuntu.com/ubuntu mantic-updates main restricted universe multiverse
deb http://old-releases.ubuntu.com/ubuntu mantic-backports main restricted universe multiverse
EOF

# Update and upgrade the system
echo "Updating and upgrading the system..."
sudo apt-get update
sudo NEEDRESTART_MODE=a apt-get dist-upgrade --yes

echo "System fix completed."
