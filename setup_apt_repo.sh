#!/bin/bash

echo "📋 Setting up APT repository for KnowMe..."

# Create repository structure
mkdir -p apt-repo/{pool/main/k/knowme,dists/stable/main/binary-{amd64,i386,all}}

# Copy deb package
cp knowme_1.0.5_all.deb apt-repo/pool/main/k/knowme/

# Create Packages file
cd apt-repo
dpkg-scanpackages pool/ /dev/null > dists/stable/main/binary-all/Packages
gzip -k dists/stable/main/binary-all/Packages

# Create Release file
cat > dists/stable/Release << EOF
Origin: KnowMe Repository
Label: KnowMe
Suite: stable
Codename: stable
Version: 1.0
Architectures: all amd64 i386
Components: main
Description: KnowMe system information tool repository
Date: $(date -Ru)
EOF

# Create installation instructions
cat > INSTALL_APT.md << EOF
# Install KnowMe via APT

## Add repository:
\`\`\`bash
echo "deb [trusted=yes] file://$(pwd) stable main" | sudo tee /etc/apt/sources.list.d/knowme.list
sudo apt update
\`\`\`

## Install:
\`\`\`bash
sudo apt install knowme
\`\`\`

## Or install directly:
\`\`\`bash
sudo dpkg -i knowme_1.0.5_all.deb
sudo apt-get install -f
\`\`\`
EOF

echo "✅ APT repository created in apt-repo/"
echo "📋 See INSTALL_APT.md for installation instructions"
