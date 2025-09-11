# 📦 KnowMe Installation Guide

## 🚀 Quick Install (Recommended)

```bash
pip install knowme
```

## 📋 All Installation Methods

### 1. 🐍 **PyPI (pip)**
```bash
# Install from PyPI
pip install knowme

# Or install from local wheel
pip install dist/knowme-1.0.5-py3-none-any.whl
```

### 2. 📦 **Debian/Ubuntu (APT)**
```bash
# Install .deb package directly
sudo dpkg -i knowme_1.0.5_all.deb
sudo apt-get install -f  # Fix any dependencies

# Or add to local APT repository
echo "deb [trusted=yes] file://$(pwd)/apt-repo stable main" | sudo tee /etc/apt/sources.list.d/knowme.list
sudo apt update
sudo apt install knowme
```

### 3. 🏗️ **Arch Linux (AUR/yay)**
```bash
# After submitting to AUR
yay -S knowme

# Or build locally with makepkg
makepkg -si
```

### 4. 📱 **Snap Package**
```bash
# Build snap (requires snapcraft)
snapcraft

# Install locally
sudo snap install knowme_1.0.5_amd64.snap --dangerous

# Or from Snap Store (after publishing)
sudo snap install knowme
```

### 5. 🍺 **Homebrew (macOS)**
```bash
# After submitting formula
brew install knowme

# Or from local formula
brew install Formula/knowme.rb
```

### 6. 🪟 **Windows (Chocolatey)**
```bash
# After publishing to Chocolatey
choco install knowme

# Or PowerShell installer
./install.ps1
```

### 7. 🐳 **Docker**
```bash
# Build Docker image
docker build -t knowme .

# Run
docker run --rm knowme
```

## 🔧 **Build Your Own Packages**

### Build All Packages:
```bash
./build_all_packages.sh
```

### Individual Builds:

#### Python Package:
```bash
python3 -m build
```

#### Debian Package:
```bash
dpkg-deb --build debian_package knowme_1.0.5_all.deb
```

#### Snap Package:
```bash
snapcraft
```

#### APT Repository:
```bash
./setup_apt_repo.sh
```

## 📊 **Package Information**

| Package Type | File | Size | Installation Command |
|--------------|------|------|---------------------|
| Python Wheel | `knowme-1.0.5-py3-none-any.whl` | ~15KB | `pip install knowme` |
| Python Source | `knowme-1.0.5.tar.gz` | ~16KB | `pip install knowme` |
| Debian | `knowme_1.0.5_all.deb` | ~10KB | `sudo dpkg -i knowme_1.0.5_all.deb` |
| AUR | `PKGBUILD` | - | `yay -S knowme` |
| Snap | `knowme_1.0.5_amd64.snap` | - | `sudo snap install knowme` |

## 🎯 **After Installation**

Run KnowMe:
```bash
knowme
```

You'll see beautiful system information with ASCII art! 🎨

## 🔄 **Updates**

```bash
# Update via pip
pip install --upgrade knowme

# Update via apt
sudo apt update && sudo apt upgrade knowme

# Update via yay
yay -Syu knowme

# Update via snap
sudo snap refresh knowme
```

## 🆘 **Troubleshooting**

### Missing Dependencies:
```bash
# Install Python dependencies manually
pip install psutil distro py-cpuinfo requests gputil screeninfo ifaddr
```

### Permission Issues:
```bash
# Use --user flag for pip
pip install --user knowme
```

### Debian Dependencies:
```bash
# Install required packages
sudo apt install python3 python3-psutil python3-distro python3-requests
```

## 📱 **Mobile Installation (Termux)**

```bash
# Install Termux from F-Droid
# Then in Termux:
pkg update && pkg upgrade
pkg install python
pip install knowme
knowme
```

## 🌟 **Features**

- ✅ **Cross-platform**: Linux, macOS, Windows, Android
- ✅ **Fast & offline**: No internet required
- ✅ **Beautiful ASCII art**: OS-specific logos
- ✅ **Comprehensive info**: CPU, RAM, disk, network
- ✅ **Silent installation**: Clean, professional experience
- ✅ **Multiple formats**: pip, apt, yay, snap, brew, choco

Enjoy your system information tool! 🚀
