# Install KnowMe via APT

## Add repository:
```bash
echo "deb [trusted=yes] file:///home/dudwalls/knowme/apt-repo stable main" | sudo tee /etc/apt/sources.list.d/knowme.list
sudo apt update
```

## Install:
```bash
sudo apt install knowme
```

## Or install directly:
```bash
sudo dpkg -i knowme_1.0.5_all.deb
sudo apt-get install -f
```
