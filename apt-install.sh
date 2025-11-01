#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Please run with sudo: curl -fsSL https://raw.githubusercontent.com/mehtahrishi/knowme/main/apt-install.sh | sudo bash"
    exit 1
fi

echo "Installing knowme via APT-style method..."

# Clean up any existing installations
dpkg -r knowme 2>/dev/null || true
rm -f /usr/bin/knowme /usr/local/bin/knowme
rm -f /var/lib/dpkg/info/knowme.*

# Remove any duplicate entries from dpkg status
if [ -f /var/lib/dpkg/status ]; then
    grep -v "^Package: knowme" /var/lib/dpkg/status > /tmp/dpkg_status_clean || cp /var/lib/dpkg/status /tmp/dpkg_status_clean
    mv /tmp/dpkg_status_clean /var/lib/dpkg/status
fi

# Download and install knowme
curl -fsSL https://raw.githubusercontent.com/mehtahrishi/knowme/main/knowme -o /usr/bin/knowme
chmod +x /usr/bin/knowme

# Create dpkg info files
mkdir -p /var/lib/dpkg/info
cat > /var/lib/dpkg/info/knowme.list << 'EOF'
/usr/bin/knowme
EOF

# Add to dpkg status
cat >> /var/lib/dpkg/status << 'EOF'
Package: knowme
Status: install ok installed
Priority: optional
Section: utils
Installed-Size: 32
Maintainer: Hrishi Mehta <mehtahrishi@github.com>
Architecture: all
Version: 1.0-1
Depends: bash, coreutils, procps, net-tools, curl
Description: System information display tool
 A neofetch alternative that displays system information
 in a colorful tabular format with ASCII art logos.

EOF

echo "✅ knowme installed successfully via APT method!"
echo "Usage: knowme"
echo "Remove: sudo apt remove knowme"
