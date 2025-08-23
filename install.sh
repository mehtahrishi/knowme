#!/bin/bash

# KnowMe Enhanced Installation Script
# Provides clean installation with progress bar

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Progress bar function
show_progress() {
    local duration=$1
    local message=$2
    local width=40
    
    echo -ne "${BLUE}${message}${NC}"
    
    for ((i=0; i<=width; i++)); do
        local progress=$((i * 100 / width))
        local filled=$((i))
        local empty=$((width - i))
        
        printf "\r${BLUE}${message}${NC} ["
        printf "%${filled}s" | tr ' ' '█'
        printf "%${empty}s" | tr ' ' '░'
        printf "] %d%%" $progress
        
        sleep $(echo "scale=3; $duration / $width" | bc -l 2>/dev/null || echo "0.05")
    done
    echo
}

# Spinner function for long operations
spinner() {
    local pid=$1
    local message=$2
    local spin='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
    local i=0
    
    echo -ne "${BLUE}${message}${NC} "
    while kill -0 $pid 2>/dev/null; do
        i=$(( (i+1) %10 ))
        printf "\r${BLUE}${message}${NC} ${spin:$i:1}"
        sleep 0.1
    done
    printf "\r${GREEN}${message}${NC} ✅\n"
}

echo -e "${CYAN}🌟 KnowMe Installation Wizard${NC}"
echo -e "${CYAN}📋 Fast, offline system information tool${NC}"
echo

# Step 1: System Detection
show_progress 1 "🔍 Detecting system"

# Detect OS
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
elif [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "msys" ]]; then
    OS="windows"
else
    OS="unknown"
fi

echo -e "${GREEN}✅ Detected OS: $OS${NC}"

# Step 2: Check Python
show_progress 1 "🐍 Checking Python installation"

if ! command -v python3 &> /dev/null; then
    echo -e "${RED}❌ Python 3 is not installed${NC}"
    echo -e "${YELLOW}📥 Please install Python 3.7+ from: https://www.python.org/downloads/${NC}"
    exit 1
fi

# Check Python version
PYTHON_VERSION=$(python3 -c 'import sys; print(".".join(map(str, sys.version_info[:2])))')
REQUIRED_VERSION="3.7"

if [ "$(printf '%s\n' "$REQUIRED_VERSION" "$PYTHON_VERSION" | sort -V | head -n1)" != "$REQUIRED_VERSION" ]; then
    echo -e "${RED}❌ Python $PYTHON_VERSION found, but Python $REQUIRED_VERSION+ required${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Python $PYTHON_VERSION detected${NC}"

# Step 3: Check pip
show_progress 1 "📦 Checking pip availability"

if ! command -v pip3 &> /dev/null && ! command -v pip &> /dev/null; then
    echo -e "${RED}❌ pip is not installed${NC}"
    echo -e "${YELLOW}📥 Please install pip first${NC}"
    exit 1
fi

echo -e "${GREEN}✅ pip is available${NC}"

# Step 4: Install KnowMe with clean output
echo -e "${BLUE}🚀 Installing KnowMe...${NC}"

# Create a temporary log file
TEMP_LOG=$(mktemp)

# Install with progress indication
{
    if command -v pip3 &> /dev/null; then
        pip3 install --user knowme --quiet --no-warn-script-location
    else
        pip install --user knowme --quiet --no-warn-script-location
    fi
} > "$TEMP_LOG" 2>&1 &

# Show spinner while installing
spinner $! "📥 Downloading and installing packages"

# Check if installation was successful
if wait $!; then
    echo -e "${GREEN}✅ KnowMe installed successfully!${NC}"
else
    echo -e "${RED}❌ Installation failed${NC}"
    echo -e "${YELLOW}📋 Error details:${NC}"
    cat "$TEMP_LOG"
    rm -f "$TEMP_LOG"
    exit 1
fi

rm -f "$TEMP_LOG"

# Step 5: Setup PATH if needed
show_progress 1 "🔧 Configuring environment"

if [[ "$OS" == "linux" ]] || [[ "$OS" == "macos" ]]; then
    USER_BIN_PATH="$HOME/.local/bin"
    if [[ ":$PATH:" != *":$USER_BIN_PATH:"* ]]; then
        echo -e "${BLUE}📝 Adding $USER_BIN_PATH to PATH...${NC}"
        
        # Add to bashrc
        if [ -f ~/.bashrc ]; then
            echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
        fi
        
        # Add to zshrc if it exists
        if [ -f ~/.zshrc ]; then
            echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
        fi
        
        # Export for current session
        export PATH="$HOME/.local/bin:$PATH"
        
        echo -e "${GREEN}✅ PATH configured${NC}"
    fi
fi

# Step 6: Test installation and run KnowMe
show_progress 1 "🧪 Testing installation"

echo -e "\n${CYAN}🎉 Installation Complete!${NC}"
echo -e "${CYAN}📊 Here's your system information:${NC}"
echo -e "${CYAN}${'=' * 50}${NC}"

# Run knowme to show the result
if command -v knowme &> /dev/null; then
    knowme
elif python3 -m knowme &> /dev/null; then
    python3 -m knowme
else
    echo -e "${YELLOW}⚠️  KnowMe installed but not in PATH${NC}"
    echo -e "${YELLOW}💡 Try: python3 -m knowme${NC}"
    echo -e "${YELLOW}💡 Or restart your terminal${NC}"
fi

echo -e "\n${CYAN}${'=' * 50}${NC}"
echo -e "${GREEN}🚀 KnowMe is ready to use!${NC}"
echo -e "${BLUE}💡 Tips:${NC}"
echo -e "   • Run ${YELLOW}'knowme'${NC} anytime to see system info"
echo -e "   • Works completely offline"
echo -e "   • No configuration needed!"

if ! command -v knowme &> /dev/null; then
    echo -e "\n${YELLOW}📝 Note: If 'knowme' command is not found:${NC}"
    echo -e "   • Restart your terminal"
    echo -e "   • Or run: ${CYAN}python3 -m knowme${NC}"
fi

echo -e "\n${GREEN}✨ Thank you for using KnowMe!${NC}"
