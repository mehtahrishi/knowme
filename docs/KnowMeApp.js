import React, { useState } from 'react';
import {
    Button,
    Card,
    CardHeader,
    CardTitle,
    CardBody,
    CardActions,
    Dialog,
    DialogTitle,
    DialogContent,
    DialogActions
} from '@progress/kendo-react-all';

const KnowMeApp = () => {
    const [darkMode, setDarkMode] = useState(true);
    const [showInstallDialog, setShowInstallDialog] = useState(false);
    const [selectedMethod, setSelectedMethod] = useState('');

    const toggleDarkMode = () => {
        setDarkMode(!darkMode);
    };

    const openInstallDialog = (method) => {
        setSelectedMethod(method);
        setShowInstallDialog(true);
    };

    const closeInstallDialog = () => {
        setShowInstallDialog(false);
    };

    // Why KnowMe data
    const whyKnowMeData = [
        {
            title: "Blazing Fast",
            icon: "flash",
            description: "Get your system information in a blink of an eye. No more waiting for slow, bloated apps."
        },
        {
            title: "Fully Offline",
            icon: "cloud-off",
            description: "Works anywhere, anytime. No internet connection required to get your system's stats."
        },
        {
            title: "Beautifully Crafted",
            icon: "brush",
            description: "Presents information in a clean, colorful, and easy-to-read format with OS-specific ASCII art."
        }
    ];

    // Features data
    const featuresData = [
        {
            title: "Cross-Platform",
            icon: "desktop",
            description: "Works seamlessly on Windows, macOS, and a wide variety of Linux distributions."
        },
        {
            title: "Comprehensive Info",
            icon: "info-circle",
            description: "From CPU and RAM to network details and running processes, get all the info you need."
        },
        {
            title: "Lightweight",
            icon: "weight",
            description: "With minimal dependencies, KnowMe is light on resources and won't slow down your system."
        }
    ];

    // System information data
    const systemInfoData = [
        "Operating System",
        "Kernel Version",
        "CPU Model & Cores",
        "Memory (RAM) Usage",
        "Disk Usage",
        "GPU Information",
        "Screen Resolution",
        "System Uptime",
        "IP & Mac Address",
        "And much more..."
    ];

    // Prerequisites data
    const prerequisitesData = [
        {
            title: "Python",
            command: "sudo apt install python3-pip python3-psutil -y"
        },
        {
            title: "Node.js",
            command: "sudo apt-get install nodejs npm"
        }
    ];

    // Installation methods data
    const installationData = [
        {
            title: "Python Package (pip)",
            method: "pip",
            commands: [
                "mkdir my_project",
                "cd my_project",
                "python3 -m venv venv",
                "source venv/bin/activate",
                "pip install knowme"
            ]
        },
        {
            title: "NPM Package",
            method: "npm",
            commands: [
                "sudo apt-get install python3",
                "sudo apt install python3-pip python3-psutil -y",
                "sudo apt-get install nodejs npm",
                "sudo apt-get update",
                "sudo npm install -g knowme-cli"
            ]
        },
        {
            title: "NPX Package",
            method: "npx",
            commands: [
                "sudo apt-get install python3",
                "sudo apt install python3-pip python3-psutil -y",
                "sudo apt-get install nodejs npm",
                "sudo apt-get update",
                "npx knowme-cli"
            ]
        },
        {
            title: "Debian Package (.deb)",
            method: "deb",
            commands: [
                "wget https://github.com/mehtahrishi/knowme/releases/download/v1.0.5/knowme_1.0.5_all.deb",
                "sudo apt install python3-pip python3-psutil -y",
                "sudo dpkg -i knowme_1.0.5_all.deb"
            ]
        },
        {
            title: "APT Repository (Debian/Ubuntu)",
            method: "apt",
            commands: [
                "sudo apt install python3-pip -y",
                'echo "deb [trusted=yes] https://mehtahrishi.github.io/knowme/apt stable main" | sudo tee /etc/apt/sources.list.d/knowme.list',
                "sudo apt update",
                "sudo apt install knowme"
            ]
        }
    ];

    // Uninstall methods data
    const uninstallData = [
        {
            title: "Python Package Removal",
            commands: [
                "deactivate",
                "cd..",
                "rm -rf my_project",
                "sudo apt autoremove -y"
            ]
        },
        {
            title: "DPKG Package Removal",
            commands: [
                "sudo apt-get remove knowme",
                "sudo apt-get autoremove",
                "rm knowme_1.0.5_all.deb"
            ]
        },
        {
            title: "APT Package Removal",
            commands: [
                "sudo apt remove knowme (apt)",
                "sudo apt autoremove",
                "sudo find / -name \"*knowme*\" 2>/dev/null",
                "sudo rm -rf /usr/local/lib/python3/dist-packages/knowme",
                "sudo rm /etc/apt/sources.list.d/knowme.list",
                "sudo apt update",
                "sudo apt autoremove -y"
            ]
        },
        {
            title: "NPM Package Removal",
            commands: [
                "sudo npm uninstall -g knowme-cli",
                "sudo apt-get remove nodejs npm python3-pip python3-psutil",
                "sudo apt-get autoremove"
            ]
        },
        {
            title: "NPX Package Removal",
            commands: [
                "sudo apt-get remove nodejs npm python3-pip python3-psutil",
                "sudo apt-get autoremove"
            ]
        }
    ];

    return (
        <div className={darkMode ? "dark-mode" : ""}>
            {/* Animated Background */}
            <ul className="background-shapes">
                {[...Array(10)].map((_, i) => (
                    <li key={i}></li>
                ))}
            </ul>

            {/* Header */}
            <header>
                <nav>
                    <div className="logo">KnowMe</div>
                    <Button 
                        icon={darkMode ? "moon" : "sun"} 
                        onClick={toggleDarkMode}
                        className="dark-mode-toggle"
                    >
                        {darkMode ? "Light Mode" : "Dark Mode"}
                    </Button>
                </nav>
            </header>

            {/* Main Content */}
            <main>
                {/* Hero Section */}
                <section className="hero">
                    <div className="hero-text">
                        <h1>Know Your System, Instantly.</h1>
                        <p>A fast, offline, and beautifully designed command-line tool for displaying detailed system information.</p>
                        <Button 
                            themeColor="primary" 
                            size="large"
                            onClick={() => window.open("https://github.com/mehtahrishi/knowme", "_blank")}
                        >
                            View on GitHub
                        </Button>
                    </div>
                    <div className="hero-image">
                        <img src="image.jpg" alt="KnowMe Screenshot" />
                    </div>
                </section>

                {/* Why KnowMe Section */}
                <section className="section">
                    <h2>Why KnowMe?</h2>
                    <div className="card-container">
                        {whyKnowMeData.map((item, index) => (
                            <Card key={index} className="card">
                                <CardHeader>
                                    <CardTitle>
                                        <span className={`k-icon k-i-${item.icon}`}></span> {item.title}
                                    </CardTitle>
                                </CardHeader>
                                <CardBody>
                                    <p>{item.description}</p>
                                </CardBody>
                            </Card>
                        ))}
                    </div>
                </section>

                {/* Features Section */}
                <section className="section">
                    <h2>Features</h2>
                    <div className="card-container">
                        {featuresData.map((item, index) => (
                            <Card key={index} className="card feature-card">
                                <CardBody>
                                    <div className="feature-icon">
                                        <span className={`k-icon k-i-${item.icon}`} style={{fontSize: '3rem'}}></span>
                                    </div>
                                    <CardTitle>{item.title}</CardTitle>
                                    <p>{item.description}</p>
                                </CardBody>
                            </Card>
                        ))}
                    </div>
                </section>

                {/* System Information Section */}
                <section className="section">
                    <h2>System Information Displayed</h2>
                    <ul className="info-list">
                        {systemInfoData.map((item, index) => (
                            <li key={index}>{item}</li>
                        ))}
                    </ul>
                </section>

                {/* Prerequisites Section */}
                <section className="section">
                    <h2>Prerequisites</h2>
                    <div className="card-container">
                        {prerequisitesData.map((item, index) => (
                            <Card key={index} className="card">
                                <CardHeader>
                                    <CardTitle>{item.title}</CardTitle>
                                </CardHeader>
                                <CardBody>
                                    <div className="code-block">
                                        <pre><code>{item.command}</code></pre>
                                        <Button 
                                            icon="copy" 
                                            className="copy-btn"
                                            onClick={() => navigator.clipboard.writeText(item.command)}
                                        />
                                    </div>
                                </CardBody>
                            </Card>
                        ))}
                    </div>
                </section>

                {/* Installation Section */}
                <section className="section">
                    <h2>Installation</h2>
                    <div className="card-container installation-grid">
                        {installationData.map((item, index) => (
                            <Card key={index} className="card">
                                <CardHeader>
                                    <CardTitle>{item.title}</CardTitle>
                                </CardHeader>
                                <CardBody>
                                    <div className="code-block">
                                        <pre><code>{item.commands.join("\n")}</code></pre>
                                        <Button 
                                            icon="copy" 
                                            className="copy-btn"
                                            onClick={() => navigator.clipboard.writeText(item.commands.join("\n"))}
                                        />
                                    </div>
                                    <CardActions>
                                        <Button 
                                            themeColor="primary" 
                                            onClick={() => openInstallDialog(item.method)}
                                        >
                                            Install
                                        </Button>
                                    </CardActions>
                                </CardBody>
                            </Card>
                        ))}
                    </div>
                </section>

                {/* Usage Section */}
                <section className="section">
                    <h2>Usage</h2>
                    <div className="card-container">
                        <Card className="card installation-card-span-3">
                            <CardBody>
                                <p>Simply run the command:</p>
                                <div className="code-block">
                                    <pre><code>knowme</code></pre>
                                    <Button 
                                        icon="copy" 
                                        className="copy-btn"
                                        onClick={() => navigator.clipboard.writeText("knowme")}
                                    />
                                </div>
                            </CardBody>
                        </Card>
                    </div>
                </section>

                {/* Uninstall Section */}
                <section className="section">
                    <h2>Uninstall</h2>
                    <div className="card-container installation-grid-2">
                        {uninstallData.map((item, index) => (
                            <Card key={index} className="card">
                                <CardHeader>
                                    <CardTitle>{item.title}</CardTitle>
                                </CardHeader>
                                <CardBody>
                                    <div className="code-block">
                                        <pre><code>{item.commands.join("\n")}</code></pre>
                                        <Button 
                                            icon="copy" 
                                            className="copy-btn"
                                            onClick={() => navigator.clipboard.writeText(item.commands.join("\n"))}
                                        />
                                    </div>
                                </CardBody>
                            </Card>
                        ))}
                    </div>
                </section>
            </main>

            {/* Footer */}
            <footer>
                <p>Developed by Hrishi Mehta</p>
                <div className="social-links">
                    <a href="https://github.com/mehtahrishi" target="_blank" aria-label="GitHub">
                        <span className="k-icon k-i-github"></span>
                    </a>
                    <a href="#" target="_blank" aria-label="LinkedIn">
                        <span className="k-icon k-i-linkedin"></span>
                    </a>
                    <a href="#" target="_blank" aria-label="Portfolio">
                        <span className="k-icon k-i-globe"></span>
                    </a>
                </div>
                <div className="footer-info">
                    <span>&copy; 2025 KnowMe</span>
                    <a href="https://github.com/mehtahrishi/knowme/blob/main/LICENSE" target="_blank" aria-label="MIT License">
                        <span className="k-icon k-i-license"></span>
                        <span>MIT License</span>
                    </a>
                </div>
            </footer>

            {/* Installation Dialog */}
            {showInstallDialog && (
                <Dialog title={`Install via ${selectedMethod}`} onClose={closeInstallDialog}>
                    <DialogTitle>Installation in Progress</DialogTitle>
                    <DialogContent>
                        <p>Installing KnowMe via {selectedMethod}...</p>
                        <div className="progress-bar">
                            <div className="progress-fill"></div>
                        </div>
                    </DialogContent>
                    <DialogActions>
                        <Button onClick={closeInstallDialog}>Close</Button>
                    </DialogActions>
                </Dialog>
            )}
        </div>
    );
};

export default KnowMeApp;