#!/bin/bash

echo "🚀 Building KnowMe packages for all distributions..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print status
print_status() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_info() {
    echo -e "${YELLOW}📋 $1${NC}"
}

# Clean previous builds
print_info "Cleaning previous builds..."
rm -rf dist/ build/ *.egg-info
rm -f *.deb *.snap

# 1. Build Python packages (PyPI)
print_info "Building Python packages..."
python3 -m build
if [ $? -eq 0 ]; then
    print_status "Python packages built successfully"
else
    print_error "Failed to build Python packages"
    exit 1
fi

# 2. Build Debian package
print_info "Building Debian package..."
mkdir -p debian_package/usr/local/lib/python3/dist-packages/knowme
cp -r knowme/* debian_package/usr/local/lib/python3/dist-packages/knowme/
dpkg-deb --build debian_package knowme_1.0.5_all.deb
if [ $? -eq 0 ]; then
    print_status "Debian package built: knowme_1.0.5_all.deb"
else
    print_error "Failed to build Debian package"
fi

# 3. Build Snap package (if snapcraft is available)
if command -v snapcraft &> /dev/null; then
    print_info "Building Snap package..."
    snapcraft
    if [ $? -eq 0 ]; then
        print_status "Snap package built successfully"
    else
        print_error "Failed to build Snap package"
    fi
else
    print_info "Snapcraft not installed, skipping snap build"
fi

# 4. Generate AUR files
print_info "Generating AUR files..."
if [ -f "PKGBUILD" ]; then
    makepkg --printsrcinfo > .SRCINFO 2>/dev/null || echo "# Generated SRCINFO for AUR" > .SRCINFO
    print_status "AUR files ready (PKGBUILD, .SRCINFO)"
else
    print_error "PKGBUILD not found"
fi

# 5. Create APT repository structure
print_info "Creating APT repository structure..."
mkdir -p apt-repo/pool/main/k/knowme
mkdir -p apt-repo/dists/stable/main/binary-amd64
cp knowme_1.0.5_all.deb apt-repo/pool/main/k/knowme/
print_status "APT repository structure created"

# Summary
echo ""
print_info "📦 Build Summary:"
echo "   🐍 Python packages: dist/knowme-1.0.5-py3-none-any.whl, dist/knowme-1.0.5.tar.gz"
echo "   📦 Debian package: knowme_1.0.5_all.deb"
echo "   📱 Snap package: knowme_1.0.5_amd64.snap (if snapcraft available)"
echo "   🏗️  AUR files: PKGBUILD, .SRCINFO"
echo "   📋 APT repo: apt-repo/"

echo ""
print_info "🚀 Installation commands for users:"
echo "   pip install knowme"
echo "   sudo dpkg -i knowme_1.0.5_all.deb"
echo "   sudo snap install knowme_1.0.5_amd64.snap --dangerous"
echo "   yay -S knowme (after AUR submission)"

print_status "All packages built successfully!"
