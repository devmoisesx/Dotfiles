echo "=== Enabling essential services (NetworkManager, bluetooth)... ==="

sudo systemctl enable --now NetworkManager
sudo systemctl enable bluetooth || print_warning "Bluetooth service could not be enabled (no hardware?)"