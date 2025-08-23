#!/usr/bin/env python3
"""
Silent KnowMe Installer - Hides pip verbose output with beautiful loader
"""

import sys
import subprocess
import threading
import time
import os

class LoadingAnimation:
    def __init__(self):
        self.running = False
        self.thread = None
        
    def start(self, message="Installing KnowMe"):
        """Start the loading animation"""
        self.running = True
        print(f"\n🚀 {message}...")
        self.thread = threading.Thread(target=self._animate)
        self.thread.daemon = True
        self.thread.start()
        
    def _animate(self):
        """Show loading animation"""
        frames = [
            "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏"
        ]
        dots = ["   ", ".  ", ".. ", "..."]
        
        i = 0
        while self.running:
            frame = frames[i % len(frames)]
            dot = dots[(i // 3) % len(dots)]
            print(f"\r{frame} Installing packages{dot}", end="", flush=True)
            time.sleep(0.1)
            i += 1
            
    def stop(self, success=True, message=""):
        """Stop the loading animation"""
        self.running = False
        if self.thread:
            self.thread.join()
            
        # Clear the line
        print(f"\r{' ' * 50}", end="")
        
        if success:
            print(f"\r✅ {message or 'Installation completed successfully!'}")
        else:
            print(f"\r❌ {message or 'Installation failed!'}")

def silent_pip_install(package_name="knowme"):
    """Install package with pip while hiding verbose output"""
    
    # Check if pip is available
    try:
        subprocess.run([sys.executable, "-m", "pip", "--version"], 
                      capture_output=True, check=True)
    except subprocess.CalledProcessError:
        print("❌ pip is not available")
        return False
    
    # Start loading animation
    loader = LoadingAnimation()
    loader.start("Installing KnowMe")
    
    try:
        # Run pip install with minimal output
        result = subprocess.run([
            sys.executable, "-m", "pip", "install", 
            package_name,
            "--quiet",
            "--no-warn-script-location",
            "--disable-pip-version-check"
        ], capture_output=True, text=True, timeout=300)
        
        loader.stop(success=result.returncode == 0)
        
        if result.returncode == 0:
            print("🎉 KnowMe installed successfully!")
            print("📊 Running KnowMe for the first time...")
            print("=" * 50)
            
            # Try to run knowme
            try:
                subprocess.run([sys.executable, "-m", "knowme"], check=True)
            except:
                try:
                    subprocess.run(["knowme"], check=True)
                except:
                    print("✅ KnowMe is ready! Run 'knowme' to see your system info.")
            
            print("=" * 50)
            print("🚀 You can now run 'knowme' anytime!")
            return True
        else:
            print(f"❌ Installation failed: {result.stderr}")
            return False
            
    except subprocess.TimeoutExpired:
        loader.stop(success=False, message="Installation timed out")
        return False
    except Exception as e:
        loader.stop(success=False, message=f"Installation error: {str(e)}")
        return False

if __name__ == "__main__":
    print("🌟 KnowMe Silent Installer")
    print("📋 Fast, offline system information tool")
    
    success = silent_pip_install()
    
    if not success:
        print("\n🔧 Troubleshooting:")
        print("   • Check your internet connection")
        print("   • Try: pip install knowme")
        print("   • Ensure Python 3.7+ is installed")
        sys.exit(1)
    else:
        print("\n💡 Tips:")
        print("   • Run 'knowme' anytime to see system info")
        print("   • Works completely offline")
        print("   • No configuration needed!")
