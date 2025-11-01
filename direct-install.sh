#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Please run with sudo: curl -fsSL https://raw.githubusercontent.com/mehtahrishi/knowme/main/direct-install.sh | sudo bash"
    exit 1
fi

echo "Installing knowme via direct method..."

# Clean up any existing installations
dpkg -r knowme 2>/dev/null || true
rm -f /usr/bin/knowme /usr/local/bin/knowme
rm -f /var/lib/dpkg/info/knowme.*

# Remove any duplicate entries from dpkg status
if [ -f /var/lib/dpkg/status ]; then
    grep -v "^Package: knowme" /var/lib/dpkg/status > /tmp/dpkg_status_clean || cp /var/lib/dpkg/status /tmp/dpkg_status_clean
    mv /tmp/dpkg_status_clean /var/lib/dpkg/status
fi

# Create temporary directory
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"

# Create deb package structure
mkdir -p knowme_1.0-1/{DEBIAN,usr/bin}

# Download knowme script
curl -fsSL https://raw.githubusercontent.com/mehtahrishi/knowme/main/knowme -o knowme_1.0-1/usr/bin/knowme
chmod +x knowme_1.0-1/usr/bin/knowme

# Create control file
cat > knowme_1.0-1/DEBIAN/control << 'EOF'
Package: knowme
Version: 1.0-1
Section: utils
Priority: optional
Architecture: all
Depends: bash, coreutils, procps, net-tools, curl
Maintainer: Hrishi Mehta <mehtahrishi@github.com>
Description: System information display tool
 A neofetch alternative that displays system information
 in a colorful tabular format with ASCII art logos.
EOF

# Build and install package
dpkg-deb --build knowme_1.0-1
dpkg -i knowme_1.0-1.deb

# Clean up
cd /
rm -rf "$TEMP_DIR"

echo "✅ knowme installed successfully via direct method!"
echo "Usage: knowme"
echo "Remove: sudo dpkg -r knowme"
