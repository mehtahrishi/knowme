#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Please run with sudo: sudo bash apt-install.sh"
    exit 1
fi

echo "Installing knowme via APT-like method..."

# Download the deb package
wget -q https://github.com/mehtahrishi/knowme/raw/main/deb/knowme_1.0-1_all.deb -O /tmp/knowme.deb

# Install it
dpkg -i /tmp/knowme.deb

# Fix any dependency issues
apt-get install -f -y

# Clean up
rm -f /tmp/knowme.deb

echo "✅ knowme installed successfully via APT method!"
echo "Usage: knowme"
echo "Remove: sudo apt remove knowme"
