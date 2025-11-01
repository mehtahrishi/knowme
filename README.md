# KnowMe - System Information Tool

A modern neofetch alternative that displays comprehensive system information in a colorful tabular format with ASCII art logos.

## Installation

### Quick Install (Recommended)
```bash
curl -fsSL https://raw.githubusercontent.com/mehtahrishi/knowme/main/install.sh | sudo bash
```

### APT Repository (Simple)
```bash
echo "deb [trusted=yes] https://mehtahrishi.github.io/knowme/deb ./" | sudo tee /etc/apt/sources.list.d/knowme.list
sudo apt update
sudo apt install knowme
```

### Direct Download
```bash
wget https://mehtahrishi.github.io/knowme/deb/knowme_1.0-1_all.deb
sudo dpkg -i knowme_1.0-1_all.deb
```

## Usage

```bash
knowme
```

## Features

- System condition monitoring (Healthy/Load/Heavy)
- Comprehensive hardware information
- Network details with public/private IP
- Process monitoring with top processes
- Disk usage for all mounted filesystems
- Colorized output for better readability
- ASCII art logos for different operating systems

## Removal

```bash
sudo apt remove knowme
# or
sudo uninstall-knowme
```
