echo "=== Installing Essential Tools ==="

for p in git curl wget; do
    if ! pacman -Qs $p >/dev/null; then
        print_status "Installing $p..."
        sudo pacman -S --needed --noconfirm $p
    fi
done