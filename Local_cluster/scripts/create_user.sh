#!/bin/bash

# Enable ssh password authentication
sudo sed -i 's/^PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
sudo systemctl reload sshd

# Set Root password
sudo echo -e "kubeadmin\nkubeadmin" | passwd root >/dev/null 2>&1