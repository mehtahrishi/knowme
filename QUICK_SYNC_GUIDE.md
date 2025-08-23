# ⚡ Quick GitHub Sync Reference

## 🚨 **IMPORTANT: Changes Don't Auto-Sync!**

When you edit code in GitHub, your packages (`.whl`, `.tar.gz`) **DO NOT** update automatically!

---

## 🔄 **3-Step Sync Process**

### **Step 1: Make Changes + Update Version**
```bash
# Edit your code
nano knowme/system_info.py

# CRITICAL: Update version number
nano pyproject.toml  # version = "1.0.3" → "1.0.4"
nano setup.py        # version="1.0.3" → "1.0.4"
```

### **Step 2: Build + Upload**
```bash
# Build new packages
python -m build

# Upload to PyPI
twine upload dist/*
```

### **Step 3: Create Release**
```bash
# Commit and tag
git add .
git commit -m "🐛 Fix: Your change description"
git push origin main
git tag v1.0.4
git push origin v1.0.4
```

**Result:** Users can now run `pip install --upgrade knowme` and get your changes!

---

## 🤖 **Automated Version (Recommended)**

### **Setup Once:**
1. Create `.github/workflows/auto-release.yml` (see GITHUB_SYNC_WORKFLOW.md)
2. Add PyPI token to GitHub Secrets

### **Daily Use:**
```bash
# 1. Make changes + update version
nano knowme/system_info.py
nano pyproject.toml  # Bump version

# 2. Commit and push
git add .
git commit -m "Your changes"
git push origin main

# 3. Create tag (triggers automation)
git tag v1.0.4
git push origin v1.0.4

# 4. Wait 5-10 minutes - GitHub Actions does the rest!
```

---

## 📊 **When to Bump Version**

| Change | Version Bump | Example |
|--------|--------------|---------|
| Fix typo/bug | PATCH | 1.0.3 → 1.0.4 |
| Add feature | MINOR | 1.0.4 → 1.1.0 |
| Breaking change | MAJOR | 1.1.0 → 2.0.0 |
| README only | NO BUMP | Stay same |

---

## ⏱️ **Timeline**

```
Your Change → Version Bump → Build → Upload → Users Can Install
   Now           30 sec      2 min    2 min      5-10 min total
```

---

## 🚨 **Common Mistakes**

❌ **Don't Do:**
- Change code but forget to bump version
- Only edit GitHub without rebuilding packages
- Upload without testing locally

✅ **Do:**
- Always bump version for code changes
- Test locally before releasing
- Keep version numbers consistent

---

## 🎯 **Quick Commands**

### **Check Current Version:**
```bash
grep version pyproject.toml
grep version setup.py
```

### **Bump Version:**
```bash
# PATCH (bug fix)
sed -i 's/version = "1.0.3"/version = "1.0.4"/' pyproject.toml
sed -i 's/version="1.0.3"/version="1.0.4"/' setup.py

# MINOR (new feature)
sed -i 's/version = "1.0.4"/version = "1.1.0"/' pyproject.toml
sed -i 's/version="1.0.4"/version="1.1.0"/' setup.py
```

### **Test Locally:**
```bash
python -m build
pip install dist/knowme-*.whl
knowme  # Test it works
```

### **Release:**
```bash
twine upload dist/*
git tag v1.0.4
git push origin v1.0.4
```

---

## 💡 **Pro Tips**

1. **Test first:** Always test locally before releasing
2. **Consistent versions:** Keep pyproject.toml and setup.py in sync
3. **Clear messages:** Write descriptive commit messages
4. **Small releases:** Release often with small changes
5. **Backup:** Keep local copies of working versions

---

**Remember:** You control when users get updates. GitHub changes don't automatically become packages! 🎯
