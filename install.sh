#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_status()   { echo -e "${BLUE}[INFO]${NC} $1"; }
print_success()  { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
print_warning()  { echo -e "${YELLOW}[WARNING]${NC} $1"; }
print_error()    { echo -e "${RED}[ERROR]${NC} $1"; }

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
        arch|endeavouros|arcolinux|archcraft|artix|archlabs)
            ;;
        manjaro|garuda)
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

if ! pacman -Qs hyprland >/dev/null; then
    print_status "Installing $p..."
    sudo pacman -S --needed --noconfirm hyprland
fi

sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

cd ~

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
#     quickshell hypridle hyprlock swww grimblast matugen-bin mpvpaper ttf-jetbrains-mono-nerd ttf-material-symbols-variable-git onlyoffice bat micro python3 tmux flatpack eza swaync visual-studio-code-bin microsoft-edge-stable-bin openjdk-17-jdk maven intellij-idea-community-edition fzf zoxide satty fastfetch qt5-wayland qt6-wayland curl vim git htop vlc neovim gedit flatpack gnome-audio-locator gnome-calculator gnome-calendar gnome-clocks gnome-connections gnome-disk-utility gnome-disks gnome-doc-utils gnome-font-viewer gnome-photos gnome-music gnome-software gnome-system-monitor xdg-desktop-portal-hyprland-git xdg-desktop-portal-gtk hyprpolkitagent sunshine moonlight-qt obsidian drawio
# )

yay -S --needed --noconfirm quickshell hypridle hyprlock swww grimblast matugen-bin mpvpaper ttf-jetbrains-mono-nerd ttf-material-symbols-variable-git onlyoffice bat micro python3 tmux flatpack eza swaync visual-studio-code-bin microsoft-edge-stable-bin openjdk-17-jdk maven intellij-idea-community-edition fzf zoxide satty fastfetch qt5-wayland qt6-wayland curl vim git htop vlc neovim gedit flatpack gnome-audio-locator gnome-calculator gnome-calendar gnome-clocks gnome-connections gnome-disk-utility gnome-disks gnome-doc-utils gnome-font-viewer gnome-photos gnome-music gnome-software gnome-system-monitor xdg-desktop-portal-hyprland-git xdg-desktop-portal-gtk hyprpolkitagent sunshine moonlight-qt obsidian drawio

# for pkg in "${aur_packages[@]}"; do
#     yay -S --needed --noconfirm $pkg
# done

# micro
curl https://getmic.ro | bash
sudo mv micro /usr/bin

# bat
mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat 

git clone --depth=1 https://github.com/powerline/fonts.git
./fonts/install.sh
rm -rf fonts



print_success "All required packages installed."

# Install icon themes (example: Tela Circle)
# print_status "Installing Tela Circle icon theme..."
# tmp_icondir="/tmp/Tela-circle-icon-theme"
# rm -rf "$tmp_icondir"
# git clone --depth=1 https://github.com/vinceliuice/Tela-circle-icon-theme.git "$tmp_icondir"
# (cd "$tmp_icondir" && sudo ./install.sh -a)
# rm -rf "$tmp_icondir"

# Install OneUI4-Icons
# print_status "Installing OneUI4-Icons..."
# rm -rf /tmp/OneUI4-Icons
# git clone https://github.com/end-4/OneUI4-Icons.git /tmp/OneUI4-Icons
# sudo cp -r /tmp/OneUI4-Icons/OneUI* /usr/share/icons/
# rm -rf /tmp/OneUI4-Icons

# Bibata cursor
print_status "Installing Bibata Modern Classic cursor theme..."
wget -O /tmp/Bibata-Modern-Classic.tar.xz https://github.com/ful1e5/Bibata_Cursor/releases/download/v2.0.6/Bibata-Modern-Classic.tar.xz
sudo mkdir -p /usr/share/icons
sudo tar -xf /tmp/Bibata-Modern-Classic.tar.xz -C /usr/share/icons
rm /tmp/Bibata-Modern-Classic.tar.xz

# Copy config files to ~/.config
print_status "Copying dotfiles to ~/.config ..."
# cp -r .config/* ~/.config/
# ln -sf test/ ~/.config/
ln -sf ~/Dotfiles/.config/* ~/.config

# Copy .zshrc file to ~/
print_status "Copying .zshrc to ~/ ..."
ln -sf ~/Dotfiles/.zshrc ~/

# Copy .zshrc file to ~/
print_status "Copying other files to ~/ ..."
ln -sf ~/Dotfiles/.icons ~/
ln -sf ~/Dotfiles/.local ~/
ln -sf ~/Dotfiles/.themes ~/

chsh -s $(which zsh)

print_status "Verificando se o Oh My Zsh já está instalado..."
if [ -d "$HOME/.oh-my-zsh" ]; then
    print_status "Oh My Zsh já está instalado. Pulando a instalação."
else
    print_status "Instalando Oh My Zsh..."
    # A instalação via curl é a mais comum e recomendada
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
git clone https://github.com/z-shell/F-Sy-H.git \
${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/F-Sy-H
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use
git clone https://github.com/MichaelAquilina/zsh-auto-notify.git $ZSH_CUSTOM/plugins/auto-notify

# === Anpassung env.conf ===
# print_status "Patching ~/.config/hypr/hyprland/env.conf ..."

# ENV_CONF="$HOME/.config/hypr/hyprland/env.conf"
# USERID=$(id -u)
# USERHOME="$HOME"

# if [ -f "$ENV_CONF" ]; then
#     # XDG_RUNTIME_DIR: replace with UserID, remains commented out
#     sed -i "s|^# env = XDG_RUNTIME_DIR,/run/user/|# env = XDG_RUNTIME_DIR,/run/user/$USERID|g" "$ENV_CONF"

#     # QML2_IMPORT_PATH: replace, uncomment, dynamic HOME path
#     sed -i "s|^# env = QML2_IMPORT_PATH,.*|env = QML2_IMPORT_PATH,$USERHOME/.config/hypr/quickshell|g" "$ENV_CONF"
#     sed -i "s|^env = QML2_IMPORT_PATH,.*|env = QML2_IMPORT_PATH,$USERHOME/.config/hypr/quickshell|g" "$ENV_CONF"

#     print_success "env.conf erfolgreich angepasst."
# else
#     print_warning "env.conf nicht gefunden, überspringe Anpassung."
# fi

# Enable services
print_status "Enabling essential services (NetworkManager, sddm, bluetooth)..."
sudo systemctl enable --now NetworkManager
sudo systemctl enable sddm
sudo systemctl enable bluetooth || print_warning "Bluetooth service could not be enabled (no hardware?)"

# Update caches
fc-cache -fv
gtk-update-icon-cache -f -t /usr/share/icons/hicolor
gtk-update-icon-cache -f -t /usr/share/icons/Papirus || true

print_success "Setup done! Please reboot and select Hyprland in your login manager (SDDM)."

echo -e "${GREEN}If something is missing, check logs above or https://github.com/0xHexSec/HyprlandDE-Quickshell/issues${NC}"