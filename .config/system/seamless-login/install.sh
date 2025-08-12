#!/bin/bash

# Install seamless-login for Hyprland auto-login
set -e

echo "Installing seamless-login..."

# Compile and install the binary
make
make install

# Install systemd service
sudo cp omarchy-seamless-login.service /etc/systemd/system/

# Configure Plymouth to wait for graphical target
sudo mkdir -p /etc/systemd/system/plymouth-quit.service.d
sudo cp plymouth-quit.service.d-wait-for-graphical.conf /etc/systemd/system/plymouth-quit.service.d/wait-for-graphical.conf

# Mask plymouth-quit-wait.service
sudo systemctl mask plymouth-quit-wait.service

# Reload systemd
sudo systemctl daemon-reload

# Enable the service
sudo systemctl enable omarchy-seamless-login.service

# Disable getty@tty1 to prevent conflicts
sudo systemctl disable getty@tty1.service

echo "Installation complete!"
echo "The system will now auto-login to Hyprland on next boot."
echo "Make sure to update your Hyprland config to use 'uwsm app --' for launching applications."