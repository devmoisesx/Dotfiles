#!/bin/bash

# Prevent running as root
if [[ $EUID -eq 0 ]]; then
    print_error "Run this script as normal user (not root)."
    exit 1
fi

# Exit on any unhandled error
trap 'print_error "Script failed. Please review the log and fix errors."; exit 1' ERR

# Check
source scripts/checks/check_arch.sh
source scripts/checks/check_internet.sh

# Backup
# source scripts/configs/backup.sh

# Install
source scripts/install/install_hyprland.sh
source scripts/install/install_essential_tools.sh
source scripts/install/install_yay.sh
source scripts/install/install_packages.sh
source scripts/install/install_flatpaks.sh
source scripts/install/install_cursor.sh
source scripts/install/install_fonts.sh


# Configs
source scripts/configs/config_git.sh
source scripts/configs/enabling_services.sh
source scripts/configs/update_cache.sh

source scripts/copy_settings.sh

# Default Apps
source scripts/default-apps.sh

# Chroot
#source scripts/change_terminal.sh

# Update
sudo pacman -Syu --noconfirm


#source scripts/install/ohmyzsh/install_ohmyzsh.sh
#source scripts/install/ohmyzsh/install_plugins.sh

# Reboot
clear
sleep 5
reboot
