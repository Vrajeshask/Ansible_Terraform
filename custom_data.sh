#!/bin/bash

# Add a new user
sudo useradd -m -s /bin/bash patelvrajeshazure

# Set a password for the new user
echo "patelvrajeshazure:newpassword" | sudo chpasswd

# Create SSH directory for the new user
sudo mkdir -p /home/patelvrajeshazure/.ssh

# Copy your public SSH key to the new user's authorized_keys file
sudo cp /home/adminuser/.ssh/authorized_keys /home/patelvrajeshazure/.ssh/
sudo chown patelvrajeshazure:patelvrajeshazure /home/patelvrajeshazure/.ssh/authorized_keys
sudo chmod 600 /home/patelvrajeshazure/.ssh/authorized_keys