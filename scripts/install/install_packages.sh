# Install required packages (official + AUR)
echo "=== Installing Official packages ==="

sudo pacman -S --needed --noconfirm hyprland wayland-protocols wayland-utils grim slurp wl-clipboard wtype pipewire wireplumber pipewire-alsa pipewire-pulse pipewire-jack pamixer playerctl pavucontrol alsa-utils xdg-desktop-portal-hyprland xdg-desktop-portal-gtk xdg-desktop-portal gdm networkmanager nm-connection-editor bluez bluez-utils firefox thunar btop unzip zip ttf-dejavu noto-fonts ttf-font-awesome papirus-icon-theme adwaita-icon-theme git base-devel kitty zsh yazi ffmpeg 7zip jq poppler fd ripgrep fzf zoxide resvg imagemagick

echo "=== Installing all AUR packages ==="

yay -S --needed --noconfirm swww waypaper grimblast mpvpaper ttf-jetbrains-mono-nerd ttf-material-symbols-variable-git bat micro python3 tmux flatpack eza swaync visual-studio-code-bin microsoft-edge-stable-bin fzf zoxide satty curl vim git htop vlc neovim gedit obsidian drawio rofi-wayland gparted cameractrls obs-vaapi hyprlock hypridle hyprshot tesseract-data github-cli hyprpolkitagent polkit-gnome polkit wl-clip-persist wl-screenrec xdg-desktop-portal-gtk xdg-desktop-portal-hyprland vlc-plugins-all fd blueberry wlogout mise kdeconnect starship cpio avizo easyeffects lsp-plugins hyprpicker swayosd-git zsh-syntax-highlighting-git xorg-xhost
