#!/bin/bash

# Add a new user

#sudo useradd -m -s /bin/bash vrajesh

# Set a password for the new user
#echo "vrajesh:newpassword" | sudo chpasswd

# Create SSH directory for the new user
sudo mkdir -p /home/patelvrajeshazure/.ssh

# Copy your public SSH key to the new user's authorized_keys file
sudo cp /home/adminuser/.ssh/authorized_keys /home/patelvrajeshazure/.ssh/
sudo chown patelvrajeshazure:patelvrajeshazure /home/patelvrajeshazure/.ssh/authorized_keys
sudo chmod 600 /home/patelvrajeshazure/.ssh/authorized_keys