#!/bin/bash

echo "🚀 Setting up public APT repository..."

# Create GitHub Pages structure for APT repo
mkdir -p docs/apt/{pool/main/k/knowme,dists/stable/main/binary-all}

# Copy deb package
cp knowme_1.0.5_all.deb docs/apt/pool/main/k/knowme/

# Create Packages file
cd docs/apt
dpkg-scanpackages pool/ /dev/null > dists/stable/main/binary-all/Packages
gzip -k dists/stable/main/binary-all/Packages

# Create Release file
cat > dists/stable/Release << EOF
Origin: KnowMe Repository
Label: KnowMe
Suite: stable
Codename: stable
Architectures: all
Components: main
Description: KnowMe system information tool
Date: $(date -Ru)
EOF

# Create installation instructions
cat > ../APT_INSTALL.md << EOF
# Install KnowMe via APT

Add repository:
\`\`\`bash
echo "deb [trusted=yes] https://mehtahrishi.github.io/knowme/apt stable main" | sudo tee /etc/apt/sources.list.d/knowme.list
sudo apt update
\`\`\`

Install:
\`\`\`bash
sudo apt install knowme
\`\`\`
EOF

cd ../..
echo "✅ APT repository ready for GitHub Pages"
echo "📋 Enable GitHub Pages on your repo to host APT repository"
