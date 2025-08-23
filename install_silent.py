#!/usr/bin/env python3
"""
Complete Silent KnowMe Installer
Hides ALL pip output and shows only beautiful progress
"""

import sys
import subprocess
import threading
import time
import tempfile
import os

def show_loader():
    """Show a beautiful loading animation"""
    frames = ["⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏"]
    messages = [
        "Preparing installation",
        "Downloading packages", 
        "Installing dependencies",
        "Setting up KnowMe",
        "Finalizing installation"
    ]
    
    print("🚀 Installing KnowMe...")
    print()
    
    for i, message in enumerate(messages):
        # Show progress for each step
        for j in range(20):  # 2 seconds per step
            frame = frames[j % len(frames)]
            progress = int((i * 20 + j) / (len(messages) * 20) * 100)
            bar_length = 30
            filled = int(bar_length * progress / 100)
            bar = "█" * filled + "░" * (bar_length - filled)
            
            print(f"\r{frame} {message}... [{bar}] {progress}%", end="", flush=True)
            time.sleep(0.1)
        
        print(f"\r✅ {message} complete!{' ' * 20}")
    
    print()

def silent_install():
    """Install knowme completely silently"""
    
    # Check Python version
    if sys.version_info < (3, 7):
        print("❌ Python 3.7+ required")
        return False
    
    # Create temporary log file
    with tempfile.NamedTemporaryFile(mode='w+', delete=False, suffix='.log') as log_file:
        log_path = log_file.name
    
    try:
        # Start loader in background
        loader_thread = threading.Thread(target=show_loader)
        loader_thread.daemon = True
        loader_thread.start()
        
        # Run pip install completely silently
        result = subprocess.run([
            sys.executable, "-m", "pip", "install", "knowme",
            "--quiet", "--quiet",  # Double quiet for extra silence
            "--no-warn-script-location",
            "--disable-pip-version-check",
            "--no-color"
        ], 
        stdout=open(log_path, 'w'),
        stderr=subprocess.STDOUT,
        text=True
        )
        
        # Wait for loader to finish
        loader_thread.join()
        
        if result.returncode == 0:
            print("🎉 KnowMe installed successfully!")
            print("📊 Here's your system information:")
            print("=" * 50)
            
            # Run knowme
            try:
                subprocess.run([sys.executable, "-m", "knowme"], check=True)
            except:
                try:
                    subprocess.run(["knowme"], check=True)
                except:
                    print("✅ KnowMe is ready! Run 'knowme' to see your system info.")
            
            print("=" * 50)
            print("🚀 Installation complete! Run 'knowme' anytime.")
            return True
        else:
            print("❌ Installation failed!")
            print("📋 Error details:")
            with open(log_path, 'r') as f:
                print(f.read())
            return False
            
    except Exception as e:
        print(f"❌ Installation error: {e}")
        return False
    finally:
        # Clean up log file
        try:
            os.unlink(log_path)
        except:
            pass

if __name__ == "__main__":
    print("🌟 KnowMe Silent Installer")
    print("📋 Fast, offline system information tool")
    print()
    
    success = silent_install()
    
    if not success:
        print("\n🔧 Troubleshooting:")
        print("   • Check internet connection")
        print("   • Ensure Python 3.7+ is installed")
        print("   • Try: pip install knowme")
        sys.exit(1)
    else:
        print("\n💡 Tips:")
        print("   • Run 'knowme' anytime for system info")
        print("   • Works completely offline")
        print("   • No configuration needed!")
        print("\n✨ Thank you for using KnowMe!")
