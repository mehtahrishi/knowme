# Install KnowMe via APT

Add repository:
```bash
echo "deb [trusted=yes] https://mehtahrishi.github.io/knowme/apt stable main" | sudo tee /etc/apt/sources.list.d/knowme.list
sudo apt update
```

Install:
```bash
sudo apt install knowme
```
