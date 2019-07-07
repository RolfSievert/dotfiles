#! /bin/sh

# Install general packages

# Install i3

# Install i3 packages

# Copy services
cp ~/.scripts/system/services/* ~/.config/systemd/user

# Enable services
systemctl --user enable battery-monitor.service
systemctl --user enable lock@hitsnapper.service
systemctl --user start battery-monitor.service
systemctl --user start lock@hitsnapper.service
