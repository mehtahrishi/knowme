# KnowMe - System Information Tool

A modern neofetch alternative that displays comprehensive system information in a colorful tabular format with ASCII art logos.

## Installation

```bash
echo "deb [trusted=yes] https://mehtahrishi.github.io/knowme/apt stable main" | sudo tee /etc/apt/sources.list.d/knowme.list
sudo apt update
sudo apt install knowme
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
sudo rm /etc/apt/sources.list.d/knowme.list
```
