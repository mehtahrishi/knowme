#!/bin/bash

echo "📱 Building Snap package..."

# Check if snapcraft is installed
if ! command -v snapcraft &> /dev/null; then
    echo "❌ Snapcraft not installed. Installing..."
    sudo snap install snapcraft --classic
fi

# Build snap package
echo "🔨 Building snap..."
snapcraft

if [ $? -eq 0 ]; then
    echo "✅ Snap package built successfully!"
    echo "📦 File: knowme_1.0.5_amd64.snap"
    echo ""
    echo "🚀 To publish to Snap Store:"
    echo "1. Create account at https://snapcraft.io/"
    echo "2. Run: snapcraft login"
    echo "3. Run: snapcraft upload knowme_1.0.5_amd64.snap"
    echo "4. Run: snapcraft release knowme 1 stable"
    echo ""
    echo "📋 Local installation:"
    echo "sudo snap install knowme_1.0.5_amd64.snap --dangerous"
else
    echo "❌ Snap build failed"
    echo "📋 Manual build: cd to project directory and run 'snapcraft'"
fi
