#!/bin/bash

# KnowMe Package Builder
# Builds packages for multiple package managers and operating systems

set -e

echo "🚀 Building KnowMe packages for all platforms..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Create build directory
mkdir -p build_output

echo -e "${BLUE}📦 Building Python packages...${NC}"

# Build Python wheel and source distribution
python -m build

echo -e "${GREEN}✅ Python packages built successfully${NC}"

# Build Debian package
echo -e "${BLUE}📦 Building Debian package...${NC}"
if command -v dpkg-deb &> /dev/null; then
    # Create directory structure
    mkdir -p debian_package/usr/local/bin
    
    # Copy the wheel to build output
    cp dist/*.whl build_output/
    cp dist/*.tar.gz build_output/
    
    # Build .deb package
    dpkg-deb --build debian_package build_output/knowme_1.0.0_all.deb
    echo -e "${GREEN}✅ Debian package built successfully${NC}"
else
    echo -e "${YELLOW}⚠️  dpkg-deb not found, skipping Debian package${NC}"
fi

# Build RPM package (if rpmbuild is available)
echo -e "${BLUE}📦 Building RPM package...${NC}"
if command -v rpmbuild &> /dev/null; then
    # Create RPM build directories
    mkdir -p ~/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
    
    # Copy spec file and source
    cp knowme.spec ~/rpmbuild/SPECS/
    cp dist/knowme-1.0.0.tar.gz ~/rpmbuild/SOURCES/
    
    # Build RPM
    rpmbuild -ba ~/rpmbuild/SPECS/knowme.spec
    
    # Copy built RPMs to output
    cp ~/rpmbuild/RPMS/noarch/knowme-*.rpm build_output/ 2>/dev/null || true
    cp ~/rpmbuild/SRPMS/knowme-*.src.rpm build_output/ 2>/dev/null || true
    
    echo -e "${GREEN}✅ RPM package built successfully${NC}"
else
    echo -e "${YELLOW}⚠️  rpmbuild not found, skipping RPM package${NC}"
fi

# Create AppImage (if appimagetool is available)
echo -e "${BLUE}📦 Building AppImage...${NC}"
if command -v appimagetool &> /dev/null; then
    # Create AppDir structure
    mkdir -p knowme.AppDir/usr/bin
    mkdir -p knowme.AppDir/usr/share/applications
    mkdir -p knowme.AppDir/usr/share/icons/hicolor/256x256/apps
    
    # Create desktop file
    cat > knowme.AppDir/usr/share/applications/knowme.desktop << EOF
[Desktop Entry]
Type=Application
Name=KnowMe
Comment=System information tool
Exec=knowme
Icon=knowme
Categories=System;
Terminal=true
EOF
    
    # Create AppRun script
    cat > knowme.AppDir/AppRun << 'EOF'
#!/bin/bash
HERE="$(dirname "$(readlink -f "${0}")")"
export PATH="${HERE}/usr/bin:${PATH}"
exec "${HERE}/usr/bin/python3" -m knowme "$@"
EOF
    chmod +x knowme.AppDir/AppRun
    
    # Copy Python and dependencies (simplified)
    echo -e "${YELLOW}⚠️  AppImage creation requires manual Python bundling${NC}"
else
    echo -e "${YELLOW}⚠️  appimagetool not found, skipping AppImage${NC}"
fi

# Create Snap package structure
echo -e "${BLUE}📦 Creating Snap package structure...${NC}"
mkdir -p snap_package
cat > snap_package/snapcraft.yaml << EOF
name: knowme
version: '1.0.0'
summary: Fast, offline system information tool
description: |
  KnowMe displays detailed system information with a classic, neofetch-style
  ASCII logo. It works completely offline and supports multiple platforms.

grade: stable
confinement: strict
base: core22

apps:
  knowme:
    command: bin/knowme
    plugs: [network, system-observe, hardware-observe]

parts:
  knowme:
    plugin: python
    source: .
    python-requirements:
      - psutil>=5.8.0
      - distro>=1.6.0
      - py-cpuinfo>=8.0.0
      - requests>=2.25.0
      - gputil>=1.4.0
      - screeninfo>=0.6.0
      - ifaddr>=0.1.7
EOF

echo -e "${GREEN}✅ Snap package structure created${NC}"

# Create Flatpak manifest
echo -e "${BLUE}📦 Creating Flatpak manifest...${NC}"
mkdir -p flatpak_package
cat > flatpak_package/com.mehtahrishi.KnowMe.yaml << EOF
app-id: com.mehtahrishi.KnowMe
runtime: org.freedesktop.Platform
runtime-version: '23.08'
sdk: org.freedesktop.Sdk
command: knowme

finish-args:
  - --share=network
  - --device=all
  - --filesystem=host:ro

modules:
  - name: python3-pip
    buildsystem: simple
    build-commands:
      - pip3 install --verbose --exists-action=i --no-index --find-links="file://\${PWD}" --prefix=\${FLATPAK_DEST} knowme
    sources:
      - type: file
        path: ../dist/knowme-1.0.0-py3-none-any.whl
EOF

echo -e "${GREEN}✅ Flatpak manifest created${NC}"

# Create Homebrew formula
echo -e "${BLUE}📦 Updating Homebrew formula...${NC}"
# Calculate SHA256 of the source tarball
SHA256=$(sha256sum dist/knowme-1.0.0.tar.gz | cut -d' ' -f1)
sed -i "s/YOUR_SHA256_HASH_HERE/$SHA256/g" Formula/knowme.rb
echo -e "${GREEN}✅ Homebrew formula updated with SHA256${NC}"

# Create Chocolatey package (Windows)
echo -e "${BLUE}📦 Creating Chocolatey package structure...${NC}"
mkdir -p chocolatey_package/knowme/tools
cat > chocolatey_package/knowme/knowme.nuspec << EOF
<?xml version="1.0" encoding="utf-8"?>
<package xmlns="http://schemas.microsoft.com/packaging/2015/06/nuspec.xsd">
  <metadata>
    <id>knowme</id>
    <version>1.0.0</version>
    <packageSourceUrl>https://github.com/mehtahrishi/knowme</packageSourceUrl>
    <owners>Hrishi Mehta</owners>
    <title>KnowMe</title>
    <authors>Mehta</authors>
    <projectUrl>https://github.com/mehtahrishi/knowme</projectUrl>
    <iconUrl>https://raw.githubusercontent.com/mehta/knowme/main/icon.png</iconUrl>
    <copyright>2024 Hrishi Mehta</copyright>
    <licenseUrl>https://github.com/mehtahrishi/knowme/blob/main/LICENSE</licenseUrl>
    <requireLicenseAcceptance>false</requireLicenseAcceptance>
    <projectSourceUrl>https://github.com/mehtahrishi/knowme</projectSourceUrl>
    <docsUrl>https://github.com/mehtahrishi/knowme#readme</docsUrl>
    <bugTrackerUrl>https://github.com/mehtahrishi/knowme/issues</bugTrackerUrl>
    <tags>system info cli terminal neofetch</tags>
    <summary>Fast, offline system information tool</summary>
    <description>KnowMe displays detailed system information with a classic, neofetch-style ASCII logo. It works completely offline and supports multiple platforms.</description>
    <dependencies>
      <dependency id="python3" version="3.7.0" />
    </dependencies>
  </metadata>
  <files>
    <file src="tools/**" target="tools" />
  </files>
</package>
EOF

cat > chocolatey_package/knowme/tools/chocolateyinstall.ps1 << 'EOF'
$ErrorActionPreference = 'Stop'

$packageName = 'knowme'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# Install via pip
& python -m pip install knowme

Write-Host "KnowMe has been installed successfully!" -ForegroundColor Green
Write-Host "Run 'knowme' to see your system information." -ForegroundColor Cyan
EOF

echo -e "${GREEN}✅ Chocolatey package structure created${NC}"

# Summary
echo -e "\n${GREEN}🎉 Package building complete!${NC}"
echo -e "${BLUE}📁 Built packages are available in:${NC}"
echo "  • build_output/ - Python wheels, source dist, and binary packages"
echo "  • snap_package/ - Snap package configuration"
echo "  • flatpak_package/ - Flatpak manifest"
echo "  • chocolatey_package/ - Chocolatey package"
echo "  • Formula/ - Homebrew formula"

echo -e "\n${YELLOW}📋 Next steps:${NC}"
echo "1. Upload to PyPI: twine upload dist/*"
echo "2. Submit to package repositories (AUR, Homebrew, etc.)"
echo "3. Build platform-specific packages using respective tools"
echo "4. Create GitHub releases with built packages"

echo -e "\n${BLUE}🔧 Installation methods for users:${NC}"
echo "• pip install knowme"
echo "• apt install ./knowme_1.0.0_all.deb"
echo "• yum install knowme-1.0.0-1.noarch.rpm"
echo "• brew install knowme"
echo "• choco install knowme"
echo "• snap install knowme"
echo "• flatpak install com.mehtahrishi.KnowMe"
