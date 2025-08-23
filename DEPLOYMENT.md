# KnowMe Deployment Guide

This guide covers how to deploy KnowMe to various package repositories and distribution channels.

## Prerequisites

- Python 3.7+
- Git
- Build tools for your target platforms

## Quick Start

1. **Build all packages:**
   ```bash
   ./build_packages.sh
   ```

2. **Test the package:**
   ```bash
   python -m venv test_env
   source test_env/bin/activate  # On Windows: test_env\Scripts\activate
   pip install -e .
   knowme
   ```

## Distribution Channels

### 1. Python Package Index (PyPI)

**Setup:**
```bash
pip install twine
```

**Upload to PyPI:**
```bash
# Test PyPI first
twine upload --repository testpypi dist/*

# Production PyPI
twine upload dist/*
```

**User Installation:**
```bash
pip install knowme
```

### 2. Debian/Ubuntu (APT)

**Build .deb package:**
```bash
dpkg-deb --build debian_package knowme_1.0.0_all.deb
```

**Upload to PPA or repository:**
1. Create a Launchpad PPA account
2. Upload source package with `dput`
3. Or distribute .deb files directly

**User Installation:**
```bash
# From .deb file
sudo dpkg -i knowme_1.0.0_all.deb
sudo apt-get install -f  # Fix dependencies

# From PPA
sudo add-apt-repository ppa:mehtahrishi/knowme
sudo apt update
sudo apt install knowme
```

### 3. Red Hat/Fedora (RPM)

**Build RPM:**
```bash
rpmbuild -ba knowme.spec
```

**Upload to COPR or repository:**
1. Create a Fedora COPR project
2. Upload SRPM or configure auto-builds from Git

**User Installation:**
```bash
# From RPM file
sudo rpm -i knowme-1.0.0-1.noarch.rpm

# From COPR
sudo dnf copr enable mehtahrishi/knowme
sudo dnf install knowme
```

### 4. Arch Linux (AUR)

**Create PKGBUILD:**
```bash
# Submit to AUR
git clone ssh://aur@aur.archlinux.org/knowme.git
# Add PKGBUILD and .SRCINFO
makepkg --printsrcinfo > .SRCINFO
git add PKGBUILD .SRCINFO
git commit -m "Initial commit"
git push
```

**User Installation:**
```bash
yay -S knowme
# or
paru -S knowme
```

### 5. macOS (Homebrew)

**Submit formula:**
1. Fork homebrew-core
2. Add Formula/knowme.rb
3. Submit pull request

**User Installation:**
```bash
brew install knowme
```

### 6. Windows (Chocolatey)

**Submit package:**
1. Create account on chocolatey.org
2. Upload package or configure auto-build
3. Submit for moderation

**User Installation:**
```bash
choco install knowme
```

### 7. Universal (Snap)

**Build and publish:**
```bash
cd snap_package
snapcraft
snapcraft upload knowme_1.0.0_amd64.snap
snapcraft release knowme 1.0.0 stable
```

**User Installation:**
```bash
sudo snap install knowme
```

### 8. Universal (Flatpak)

**Build and publish:**
```bash
cd flatpak_package
flatpak-builder build-dir com.mehtahrishi.KnowMe.yaml
flatpak build-export repo build-dir
# Submit to Flathub
```

**User Installation:**
```bash
flatpak install flathub com.mehtahrishi.KnowMe
```

### 9. Container (Docker)

**Create Dockerfile:**
```dockerfile
FROM python:3.11-slim
RUN pip install knowme
ENTRYPOINT ["knowme"]
```

**Build and publish:**
```bash
docker build -t mehtahrishi/knowme:1.0.0 .
docker push mehtahrishi/knowme:1.0.0
```

**User Installation:**
```bash
docker run --rm mehtahrishi/knowme:1.0.0
```

## Automated CI/CD

### GitHub Actions

Create `.github/workflows/release.yml`:

```yaml
name: Release

on:
  push:
    tags:
      - 'v*'

jobs:
  build-and-publish:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    
    - name: Set up Python
      uses: actions/setup-python@v4
      with:
        python-version: '3.11'
    
    - name: Install dependencies
      run: |
        pip install build twine
    
    - name: Build packages
      run: python -m build
    
    - name: Publish to PyPI
      env:
        TWINE_USERNAME: __token__
        TWINE_PASSWORD: ${{ secrets.PYPI_API_TOKEN }}
      run: twine upload dist/*
    
    - name: Create GitHub Release
      uses: softprops/action-gh-release@v1
      with:
        files: dist/*
```

## Distribution Checklist

- [ ] Test package installation in clean environment
- [ ] Verify all dependencies are correctly specified
- [ ] Test on multiple Python versions (3.7, 3.8, 3.9, 3.10, 3.11, 3.12)
- [ ] Test on multiple operating systems (Linux, macOS, Windows)
- [ ] Update version numbers consistently
- [ ] Create comprehensive documentation
- [ ] Set up automated testing
- [ ] Configure security scanning
- [ ] Plan update/upgrade strategy

## Version Management

1. **Update version in pyproject.toml**
2. **Update version in all package configs**
3. **Create git tag:** `git tag v1.0.0`
4. **Push tag:** `git push origin v1.0.0`
5. **Automated builds will trigger**

## Monitoring and Maintenance

- Monitor download statistics on PyPI
- Watch for security vulnerabilities in dependencies
- Respond to user issues and feature requests
- Keep documentation up to date
- Regular dependency updates

## Support Channels

- GitHub Issues: Bug reports and feature requests
- GitHub Discussions: Community support
- Documentation: README and wiki
- Email: Direct support contact

## Legal Considerations

- Ensure license compatibility
- Include proper attribution
- Respect trademark guidelines
- Follow platform-specific policies
- Consider export restrictions for certain regions
