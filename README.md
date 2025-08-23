# knowme System Info CLI

`knowme` is a fast, offline, cross-platform command-line tool that displays detailed system information alongside a classic, `neofetch`-style ASCII logo for your operating system.

## Features

-   **Works completely offline.** No internet connection or API keys needed.
-   **Iconic ASCII Logos:** Pre-defined, high-quality logos for Windows, macOS, Ubuntu, Debian, Arch, Fedora, and more.
-   **Detailed System Info:** Displays your OS, kernel, uptime, CPU, GPU, memory, disk usage, resolution, local IP, and more.
-   **Instant Execution:** No loading bars or delays.

## Installation

1.  **Clone the repository (or just download the files):**
    ```bash
    git clone https://github.com/yourusername/knowme.git
    cd knowme
    ```

2.  **Create a virtual environment (recommended):**
    ```bash
    python3 -m venv venv
    source venv/bin/activate
    ```

3.  **Install in editable mode:**
    This command installs the tool and all necessary Python packages.
    ```bash
    pip install -e .
    ```

## Usage

After installation, simply run the command:

```bash
knowme