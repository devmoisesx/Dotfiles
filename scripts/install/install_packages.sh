# Install required packages (official + AUR)
echo "=== Installing Official packages ==="

# Load official packages (minimal, edit as needed)
# official_packages=(
#     hyprland wayland-protocols wayland-utils grim slurp wl-clipboard wtype pipewire wireplumber pipewire-alsa pipewire-pulse pipewire-jack pamixer playerctl pavucontrol alsa-utils xdg-desktop-portal-hyprland xdg-desktop-portal-gtk xdg-desktop-portal gdm qt6-base qt6-wayland qt6-svg qt6-imageformats networkmanager nm-connection-editor bluez bluez-utils firefox thunar btop unzip zip ttf-dejavu noto-fonts ttf-font-awesome papirus-icon-theme adwaita-icon-theme git base-devel kitty zsh
# )

# for pkg in "${official_packages[@]}"; do
#     sudo pacman -S --needed --noconfirm $pkg
# done

sudo pacman -S --needed --noconfirm hyprland wayland-protocols wayland-utils grim slurp wl-clipboard wtype pipewire wireplumber pipewire-alsa pipewire-pulse pipewire-jack pamixer playerctl pavucontrol alsa-utils xdg-desktop-portal-hyprland xdg-desktop-portal-gtk xdg-desktop-portal gdm qt6-base qt6-wayland qt6-svg qt6-imageformats networkmanager nm-connection-editor bluez bluez-utils firefox thunar btop unzip zip ttf-dejavu noto-fonts ttf-font-awesome papirus-icon-theme adwaita-icon-theme git base-devel kitty zsh

echo "=== Installing all AUR packages ==="
# Load AUR packages
# aur_packages=(
#     quickshell-git swww waypaper grimblast matugen-bin mpvpaper ttf-jetbrains-mono-nerd ttf-material-symbols-variable-git bat micro python3 tmux flatpack eza swaync visual-studio-code-bin microsoft-edge-stable-bin openjdk-17-jdk maven intellij-idea-community-edition fzf zoxide satty fastfetch qt5-wayland qt6-wayland qt5 qt6 qt6-5compat curl vim git htop vlc neovim gedit obsidian drawio rofi-wayland gparted cameractrls obs-vaapi hyprlock hypridle hyprshot tesseract-data github-cli hyprpolkitagent polkit-gnome polkit wl-clip-persist wl-screenrec xdg-desktop-portal-gtk xdg-desktop-portal-hyprland vlc-plugins-all fd
# )

# for pkg in "${aur_packages[@]}"; do
#     yay -S --needed --noconfirm $pkg
# done

yay -S --needed --noconfirm quickshell-git swww waypaper grimblast matugen-bin mpvpaper ttf-jetbrains-mono-nerd ttf-material-symbols-variable-git bat micro python3 tmux flatpack eza swaync visual-studio-code-bin microsoft-edge-stable-bin openjdk-17-jdk maven intellij-idea-community-edition fzf zoxide satty fastfetch qt5-wayland qt6-wayland qt5 qt6 qt6-5compat curl vim git htop vlc neovim gedit obsidian drawio rofi-wayland gparted cameractrls obs-vaapi hyprlock hypridle hyprshot tesseract-data github-cli hyprpolkitagent polkit-gnome polkit wl-clip-persist wl-screenrec xdg-desktop-portal-gtk xdg-desktop-portal-hyprland vlc-plugins-all fd blueberry wlogout mise kdeconnect starship cpio avizo easyeffects lsp-plugins hyprpicker
