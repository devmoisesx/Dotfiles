echo "=== Installing YaY ==="

if ! pacman -Qs yay >/dev/null; then
    sudo pacman -S --needed git base-devel
    cd ~
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd ~/Dotfiles/
fi