#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_status() { echo -e "${BLUE}[INFO]${NC} $1"; }
print_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
print_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
print_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Prevent running as root
if [[ $EUID -eq 0 ]]; then
    print_error "Run this script as normal user (not root)."
    exit 1
fi

# Exit on any unhandled error
trap 'print_error "Script failed. Please review the log and fix errors."; exit 1' ERR

# Check Arch Linux (avoid Manjaro/Garuda)
if [[ -f /etc/os-release ]]; then
    . /etc/os-release
    case $ID in
    arch | endeavouros | arcolinux | archcraft | artix | archlabs) ;;
    manjaro | garuda)
        print_error "Manjaro and Garuda are not supported."
        exit 1
        ;;
    *)
        if ! command -v pacman >/dev/null; then
            print_error "Not an Arch-based system."
            exit 1
        fi
        ;;
    esac
else
    print_error "Cannot detect distribution."
    exit 1
fi

print_status "Distribution check passed."

# Check internet connection (warn only)
if ! ping -c1 archlinux.org &>/dev/null; then
    print_warning "No internet connection detected."
fi

# Check and install essential tools
for p in git curl wget; do
    if ! pacman -Qs $p >/dev/null; then
        print_status "Installing $p..."
        sudo pacman -S --needed --noconfirm $p
    fi
done

if ! pacman -Qs yay >/dev/null; then
	sudo pacman -S --needed git base-devel
	cd ~
	git clone https://aur.archlinux.org/yay.git
	cd yay
	makepkg -si
	cd ~/Dotfiles/
fi

if ! pacman -Qs hyprland >/dev/null; then
    print_status "Installing $p..."
    sudo pacman -S --needed --noconfirm hyprland
fi

# Optional: Remove jack2, install pipewire-jack
if pacman -Qs jack2 >/dev/null; then
    print_status "Removing jack2 (incompatible)..."
    sudo pacman -Rd --nodeps --noconfirm jack2 || print_warning "Could not remove jack2"
fi
if ! pacman -Qs pipewire-jack >/dev/null; then
    print_status "Installing pipewire-jack..."
    sudo pacman -S --needed --noconfirm pipewire-jack
fi

# Clone config repo (always fresh Dotfiles dir)
# cd ~
# [ -d ~/Dotfiles ] && rm -rf ~/Dotfiles
# # print_status "Cloning Dotfiles repo..."
# # git clone https://github.com/devmoisesx/Dotfiles.git Dotfiles

# cd ~/Dotfiles

# Back up old .config if present
if [ -d ~/.config ]; then
    backup=~/.config.backup.$(date +%Y%m%d_%H%M%S)
    print_status "Backing up your .config to $backup ..."
    cp -r ~/.config "$backup"
fi

# Install required packages (official + AUR)
print_status "Installing all required packages..."

# Load official packages (minimal, edit as needed)
official_packages=(
    hyprland wayland-protocols wayland-utils grim slurp wl-clipboard wtype
    pipewire wireplumber pipewire-alsa pipewire-pulse pipewire-jack
    pamixer playerctl pavucontrol alsa-utils
    xdg-desktop-portal-hyprland xdg-desktop-portal-gtk xdg-desktop-portal
    sddm qt6-base qt6-wayland qt6-svg qt6-imageformats
    networkmanager nm-connection-editor
    bluez bluez-utils
    firefox thunar btop fastfetch unzip zip
    ttf-dejavu noto-fonts ttf-font-awesome papirus-icon-theme adwaita-icon-theme
    git base-devel
    kitty zsh
)

for pkg in "${official_packages[@]}"; do
    sudo pacman -S --needed --noconfirm $pkg
done

# Load AUR packages
# aur_packages=(
#     quickshell-git swww grimblast matugen-bin mpvpaper ttf-jetbrains-mono-nerd ttf-material-symbols-variable-git bat micro python3 tmux flatpack eza swaync visual-studio-code-bin microsoft-edge-stable-bin openjdk-17-jdk maven intellij-idea-community-edition fzf zoxide satty fastfetch qt5-wayland qt6-wayland curl vim git htop vlc neovim gedit flatpack obsidian drawio
# )

# for pkg in "${aur_packages[@]}"; do
#     yay -S --needed --noconfirm $pkg
# done

yay -S --needed --noconfirm quickshell-git swww grimblast matugen-bin mpvpaper ttf-jetbrains-mono-nerd ttf-material-symbols-variable-git bat micro python3 tmux flatpack eza swaync visual-studio-code-bin microsoft-edge-stable-bin openjdk-17-jdk maven intellij-idea-community-edition fzf zoxide satty fastfetch qt5-wayland qt6-wayland qt5 qt6 qt6-5compat curl vim git htop vlc neovim gedit obsidian drawio rofi-wayland gparted cameractrls obs-vaapi

if ! [[ -d ~/.fzf ]]; then
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install
fi


flatpak install flathub io.github.realmazharhussain.GdmSettings

# flatpak install flathub io.github.ellie_commons.jortsflatpak install flathub org.gnome.gitlab.somas.Apostrophe

flatpak install flathub io.missioncenter.MissionCenter

# # micro
if ! [[ -d /usr/bin/micro ]]; then
    curl https://getmic.ro | bash
    sudo mv micro /usr/bin
fi

# # bat
mkdir -p ~/.local/
if [[ -d ~/.local/bin/bat ]]; then
    ln -s /usr/bin/batcat ~/.local/bin/bat
fi

git clone --depth=1 https://github.com/powerline/fonts.git
./fonts/install.sh
rm -rf fonts

print_success "All required packages installed."

# Bibata cursor
print_status "Installing Bibata Modern Classic cursor theme..."
wget -O /tmp/Bibata-Modern-Classic.tar.xz https://github.com/ful1e5/Bibata_Cursor/releases/download/v2.0.6/Bibata-Modern-Classic.tar.xz
sudo mkdir -p /usr/share/icons
sudo tar -xf /tmp/Bibata-Modern-Classic.tar.xz -C /usr/share/icons
rm /tmp/Bibata-Modern-Classic.tar.xz

# Copy config files to ~/.config
if compgen -G "~/Dotfiles/.config/*" >/dev/null; then
    print_status "Copying dotfiles to ~/.config ..."
    ln -sf ~/Dotfiles/.config/* ~/.config
fi

# Copy .zshrc file to ~/
if ! [[ -d ~/.zshrc ]]; then
    print_status "Copying .zshrc to ~/ ..."
    ln -sf ~/Dotfiles/.zshrc ~/
fi

# Copy nvim folder to ~/
rm -rf ~/.config/nvim
if ! [[ -d ~/.config/nvim ]]; then
    print_status "Copying nvim to ~/.config/ ..."
    ln -sf ~/Dotfiles/.config/nvim ~/.config/
fi

if ! [[ -d ~/.tmux.conf ]]; then
    print_status "Copying .tmux.conf to ~/ ..."
    ln -sf ~/Dotfiles/.tmux.conf ~/
fi

if ! [[ -d ~/.tmux ]]; then
    print_status "Copying .tmux to ~/ ..."
    ln -sf ~/Dotfiles/.tmux ~/
fi

# Copy .icons file to ~/
if ! [[ -d ~/.icons ]]; then
    print_status "Copying dotfiles to ~/.config ..."
    ln -sf ~/Dotfiles/.icons ~/
fi

if ! [[ -d ~/.local ]]; then
    print_status "Copying dotfiles to ~/.config ..."
    ln -sf ~/Dotfiles/.local ~/
fi

if ! [[ -d ~/.themes ]]; then
    print_status "Copying dotfiles to ~/.config ..."
    ln -sf ~/Dotfiles/.themes ~/
fi

if ! [[ -d ~/.themes ]]; then
    print_status "Copying Web Apps to ~/.local/share/applications/ ..."
    ln -sf ~/Dotfiles/.local/share/applications/msedge-drawio.desktop ~/.local/share/applications/
    ln -sf ~/Dotfiles/.local/share/applications/msedge-perplexity.desktop ~/.local/share/applications/
    ln -sf ~/Dotfiles/.local/share/applications/msedge-whatsappWeb.desktop ~/.local/share/applications/
fi

chsh -s $(which zsh)

# Enable services
print_status "Enabling essential services (NetworkManager, bluetooth)..."
sudo systemctl enable --now NetworkManager
sudo systemctl enable bluetooth || print_warning "Bluetooth service could not be enabled (no hardware?)"

# Update caches
fc-cache -fv
sudo gtk-update-icon-cache -f -t /usr/share/icons/hicolor
sudo gtk-update-icon-cache -f -t /usr/share/icons/Papirus || true

update-desktop-database ~/.local/share/applications

# Open all images with imv
xdg-mime default org.gnome.Loupe.desktop image/png
xdg-mime default org.gnome.Loupe.desktop image/jpeg
xdg-mime default org.gnome.Loupe.desktop image/gif
xdg-mime default org.gnome.Loupe.desktop image/webp
xdg-mime default org.gnome.Loupe.desktop image/bmp
xdg-mime default org.gnome.Loupe.desktop image/tiff

# Open PDFs with the Document Viewer
xdg-mime default org.gnome.Evince.desktop application/pdf

# Use Chromium as the default browser
xdg-settings set default-web-browser com.microsoft-Edge.desktop
xdg-mime default com.microsoft-Edge.desktop x-scheme-handler/http
xdg-mime default com.microsoft-Edge.desktop x-scheme-handler/https

# Open video files with mpv
xdg-mime default vlc.desktop video/mp4
xdg-mime default vlc.desktop video/x-msvideo
xdg-mime default vlc.desktop video/x-matroska
xdg-mime default vlc.desktop video/x-flv
xdg-mime default vlc.desktop video/x-ms-wmv
xdg-mime default vlc.desktop video/mpeg
xdg-mime default vlc.desktop video/ogg
xdg-mime default vlc.desktop video/webm
xdg-mime default vlc.desktop video/quicktime
xdg-mime default vlc.desktop video/3gpp
xdg-mime default vlc.desktop video/3gpp2
xdg-mime default vlc.desktop video/x-ms-asf
xdg-mime default vlc.desktop video/x-ogm+ogg
xdg-mime default vlc.desktop video/x-theora+ogg
xdg-mime default vlc.desktop application/ogg

print_success "Setup done! Please reboot and select Hyprland in your login manager (GDM)."

print_status "Verificando se o Oh My Zsh já está instalado..."
if [ -d "$HOME/.oh-my-zsh" ]; then
    print_status "Oh My Zsh já está instalado. Pulando a instalação."
else
    print_status "Instalando Oh My Zsh..."
    # A instalação via curl é a mais comum e recomendada
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if ! [[ -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

if ! [[ -d ~/.oh-my-zsh/custom/plugins/zsh-history-substring-search ]]; then
    git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
fi

if ! [[ -d ~/.oh-my-zsh/custom/plugins/F-Sy-H ]]; then
    git clone https://github.com/z-shell/F-Sy-H.git \ ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/F-Sy-H
fi

if ! [[ -d ~/.oh-my-zsh/custom/plugins/you-should-use ]]; then
    git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use
fi

if ! [[ -d ~/.oh-my-zsh/custom/plugins/auto-notify ]]; then
    git clone https://github.com/MichaelAquilina/zsh-auto-notify.git $ZSH_CUSTOM/plugins/auto-notify
fi
