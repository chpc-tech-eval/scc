#!/bin/bash

echo "Changing NeedRestart behavior"
sudo sed -i 's/#\$nrconf{restart} = "i";/\$nrconf{restart} = "a";/' /etc/needrestart/needrestart.conf

sudo rm /etc/apt/source.list

sudo tee /etc/apt/sources.list <<EOF
deb http://old-releases.ubuntu.com/ubuntu mantic main restricted universe multiverse
deb http://old-releases.ubuntu.com/ubuntu mantic-security main restricted universe multiverse
deb http://old-releases.ubuntu.com/ubuntu mantic-updates main restricted universe multiverse
deb http://old-releases.ubuntu.com/ubuntu mantic-backports main restricted universe multiverse
EOF

sudo apt-get update
sudo NEEDRESTART_MODE=a apt-get dist-upgrade --yes

sudo apt update
sudo NEEDRESTART_MODE=a apt install nfs-common --yes

sudo mount -t nfs 10.100.50.172:/home /home
