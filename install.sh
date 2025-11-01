#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Please run with sudo: curl -fsSL https://raw.githubusercontent.com/mehtahrishi/knowme/main/install.sh | sudo bash"
    exit 1
fi

echo "Installing knowme..."

# Download and install
curl -fsSL https://raw.githubusercontent.com/mehtahrishi/knowme/main/knowme -o /usr/local/bin/knowme
chmod +x /usr/local/bin/knowme

# Create uninstaller
cat > /usr/local/bin/uninstall-knowme << 'EOF'
#!/bin/bash
if [ "$EUID" -ne 0 ]; then
    echo "Please run with sudo: sudo uninstall-knowme"
    exit 1
fi
rm -f /usr/local/bin/knowme /usr/local/bin/uninstall-knowme
rm -rf /tmp/knowme* /var/cache/knowme* 2>/dev/null || true
echo "knowme removed completely."
EOF

chmod +x /usr/local/bin/uninstall-knowme

echo "✅ knowme installed successfully!"
echo "Usage: knowme"
echo "Remove: sudo uninstall-knowme"
