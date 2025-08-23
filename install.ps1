# KnowMe Installation Script for Windows PowerShell

Write-Host "🚀 Installing KnowMe..." -ForegroundColor Green

# Check if Python is installed
try {
    $pythonVersion = python --version 2>&1
    if ($pythonVersion -match "Python (\d+\.\d+)") {
        $version = [Version]$matches[1]
        $requiredVersion = [Version]"3.7"
        
        if ($version -lt $requiredVersion) {
            Write-Host "❌ Python $($version) is installed, but Python 3.7 or higher is required." -ForegroundColor Red
            exit 1
        }
        
        Write-Host "✅ Python $($version) detected" -ForegroundColor Green
    }
} catch {
    Write-Host "❌ Python is not installed or not in PATH. Please install Python 3.7 or higher." -ForegroundColor Red
    Write-Host "Download from: https://www.python.org/downloads/" -ForegroundColor Yellow
    exit 1
}

# Check if pip is available
try {
    pip --version | Out-Null
    Write-Host "✅ pip detected" -ForegroundColor Green
} catch {
    Write-Host "❌ pip is not installed. Please install pip first." -ForegroundColor Red
    exit 1
}

# Install knowme
Write-Host "📦 Installing knowme via pip..." -ForegroundColor Blue
try {
    pip install --user knowme
    Write-Host "✅ KnowMe installed successfully!" -ForegroundColor Green
} catch {
    Write-Host "❌ Failed to install knowme. Please check your internet connection and try again." -ForegroundColor Red
    exit 1
}

# Test installation
Write-Host "🧪 Testing installation..." -ForegroundColor Blue
try {
    knowme --help | Out-Null
    Write-Host "✅ Installation test passed!" -ForegroundColor Green
    Write-Host "🎉 Run 'knowme' to see your system information!" -ForegroundColor Cyan
} catch {
    Write-Host "⚠️  knowme command not found in PATH. You may need to:" -ForegroundColor Yellow
    Write-Host "   1. Restart your terminal" -ForegroundColor Yellow
    Write-Host "   2. Add Python Scripts directory to PATH" -ForegroundColor Yellow
    Write-Host "   3. Run: python -m knowme" -ForegroundColor Yellow
}
