# KnowMe


<div align="center">
 <img src="[https://raw.githubusercontent.com/mehtahrishi/knowme/main/docs/image2.jpg](https://github.com/mehtahrishi/knowme/blob/main/docs/image2.png)" alt="KnowMe Demo Screenshot" width="800"/>
  <h3>🚀 Fast, offline system information tool with beautiful ASCII art</h3>
  [![PyPI version](https://badge.fury.io/py/knowme.svg)](https://badge.fury.io/py/knowme)
 [![NPM version](https://badge.fury.io/js/knowme-cli.svg)](https://badge.fury.io/js/knowme-cli)
 [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
 [![Python 3.7+](https://img.shields.io/badge/python-3.7+-blue.svg)](https://www.python.org/downloads/)
</div>


## ✨ Features


- 🚀 **Blazing Fast**: Get system information instantly, no waiting
- 🌐 **Fully Offline**: Works anywhere, no internet connection required 
- 🎨 **Beautiful ASCII Art**: OS-specific logos with colorful output
- 📊 **Comprehensive Info**: CPU, Memory, Storage, Network, GPU, and more
- 🔧 **Cross-Platform**: Linux, macOS, Windows, and mobile (Termux)
- 💻 **Lightweight**: Minimal dependencies, won't slow down your system
- 📱 **Mobile Support**: Works perfectly on Android via Termux


## 🖥️ System Information Displayed


- **Operating System**: Name, version, and architecture
- **Kernel**: Version and release information
- **CPU**: Model, cores, threads, and frequency
- **Memory**: Total, used, and available RAM
- **Storage**: Disk usage for all mounted drives
- **Network**: Active interfaces, IP addresses, and MAC addresses
- **GPU**: Graphics card information (when available)
- **Display**: Screen resolution and refresh rate
- **System**: Uptime, running processes, and top memory consumers
- **Shell**: Current shell and version information
- **Terminal**: Terminal emulator details


## 📦 Installation


### 🐍 PyPI (Recommended)
```bash
pip install knowme
```


### 🟢 NPM
```bash
# Run directly
npx knowme-cli


# Or install globally
npm install -g knowme-cli
knowme
```


### 🐧 APT (Ubuntu/Debian)
```bash
echo "deb [trusted=yes] https://mehtahrishi.github.io/knowme/apt stable main" | sudo tee /etc/apt/sources.list.d/knowme.list
sudo apt update
sudo apt install knowme
```


### 📥 Direct Download (.deb)
```bash
# Download the latest .deb package
wget https://github.com/mehtahrishi/knowme/releases/download/v1.0.5/knowme_1.0.5_all.deb


# Install
sudo dpkg -i knowme_1.0.5_all.deb
```


### 📱 Mobile (Termux)
```bash
# Install Termux from F-Droid or Google Play
# Then run:
pkg install python
pip install knowme
```


## 🚀 Usage


Simply run the command:
```bash
knowme
```


That's it! KnowMe will display your system information with a beautiful ASCII logo.


## 🔧 Requirements


- **Python**: 3.7 or higher
- **Operating Systems**: Linux, macOS, Windows
- **Mobile**: Android (via Termux)


## 📚 Dependencies


KnowMe uses these lightweight Python packages:
- `psutil` - System and process utilities
- `distro` - Linux distribution information 
- `py-cpuinfo` - CPU information
- `requests` - HTTP library
- `gputil` - GPU utilities
- `screeninfo` - Display information
- `ifaddr` - Network interface addresses


## 🌟 Why KnowMe?


### vs. neofetch
- **Faster**: Pure Python implementation, no shell scripting overhead
- **More Info**: Additional details like network info, running processes
- **Better Mobile Support**: Works perfectly on Termux
- **Multiple Install Methods**: pip, npm, apt, direct download


### vs. Other Tools
- **Offline First**: No internet required, works in air-gapped environments
- **Cross-Platform**: Single tool works everywhere
- **Lightweight**: Minimal resource usage
- **Modern**: Active development with regular updates


## 🤝 Contributing


Contributions are welcome! Please feel free to submit a Pull Request.


1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request


## 📄 License


This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.


## 🔗 Links


- **Website**: [https://mehtahrishi.github.io/knowme/](https://mehtahrishi.github.io/knowme/)
- **PyPI**: [https://pypi.org/project/knowme/](https://pypi.org/project/knowme/)
- **NPM**: [https://www.npmjs.com/package/knowme-cli](https://www.npmjs.com/package/knowme-cli)
- **GitHub**: [https://github.com/mehtahrishi/knowme](https://github.com/mehtahrishi/knowme)


## 👨‍💻 Author


**Hrishi Mehta**
- GitHub: [@mehtahrishi](https://github.com/mehtahrishi)
- Email: mehtahrishi45@gmail.com


---


<div align="center">
 <strong>⭐ Star this repo if you find it useful!</strong>
</div>


