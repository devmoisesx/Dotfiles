echo "=== Update caches ==="

if [ -d ~/.config ]; then
    backup=~/backup/.config.backup.$(date +%Y%m%d_%H%M%S)
    print_status "Backing up your .config to $backup ..."
    cp -r ~/.config "$backup"
fi

if [ -d ~/Dotfiles ]; then
    backup=~/backup/Dotfiles.backup.$(date +%Y%m%d_%H%M%S)
    print_status "Backing up your Dotfiles to $backup ..."
    cp -r ~/Dotfiles "$backup"
fi