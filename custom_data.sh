#!/bin/bash

# Add a new user
sudo useradd -m -s /bin/bash newuser

# Set a password for the new user
echo "newuser:newpassword" | sudo chpasswd

# Create SSH directory for the new user
sudo mkdir -p /home/newuser/.ssh

# Copy your public SSH key to the new user's authorized_keys file
sudo cp /home/adminuser/.ssh/authorized_keys /home/newuser/.ssh/
sudo chown newuser:newuser /home/newuser/.ssh/authorized_keys
sudo chmod 600 /home/newuser/.ssh/authorized_keys