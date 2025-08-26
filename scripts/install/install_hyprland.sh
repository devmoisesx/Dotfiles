echo "=== Installing Hyprland ==="

if ! pacman -Qs hyprland >/dev/null; then
    print_status "Installing $p..."
    sudo pacman -S --needed --noconfirm hyprland
fi