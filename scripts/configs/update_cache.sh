echo "=== Update caches ==="

fc-cache -fv
sudo gtk-update-icon-cache -f -t /usr/share/icons/hicolor
sudo gtk-update-icon-cache -f -t /usr/share/icons/Papirus || true

update-desktop-database ~/.local/share/applications