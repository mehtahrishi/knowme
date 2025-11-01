# KnowMe - System Information Tool

A modern neofetch alternative that displays comprehensive system information in a colorful tabular format with ASCII art logos.

## Installation

### Quick Install (Recommended)
```bash
curl -fsSL https://raw.githubusercontent.com/mehtahrishi/knowme/main/install.sh | sudo bash
```

### APT-style Installation
```bash
curl -fsSL https://raw.githubusercontent.com/mehtahrishi/knowme/main/apt-install.sh | sudo bash
```

### Direct Download
```bash
wget https://github.com/mehtahrishi/knowme/raw/main/deb/knowme_1.0-1_all.deb
sudo dpkg -i knowme_1.0-1_all.deb
sudo apt-get install -f  # Fix any dependencies
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
