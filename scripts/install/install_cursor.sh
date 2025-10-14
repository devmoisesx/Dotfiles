echo "=== Installing Cursor ==="

# Bibata cursor
echo "Installing Bibata Modern Classic cursor theme..."
wget -O /tmp/Bibata-Modern-Classic.tar.xz https://github.com/ful1e5/Bibata_Cursor/releases/download/v2.0.6/Bibata-Modern-Classic.tar.xz
sudo mkdir -p /usr/share/icons
sudo tar -xf /tmp/Bibata-Modern-Classic.tar.xz -C /usr/share/icons
rm /tmp/Bibata-Modern-Classic.tar.xz
