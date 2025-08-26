echo "=== Copying Settings ==="

# Copy config files to ~/.config
if compgen -G "~/Dotfiles/dotfiles/.config/*" >/dev/null; then
    echo "Copying dotfiles to ~/.config ..."
    ln -sf ~/Dotfiles/dotfiles/.config/* ~/.config/
fi

# Copy .zshrc file to ~/
if ! [[ -d ~/.zshrc ]]; then
    echo "Copying .zshrc to ~/ ..."
    ln -sf ~/Dotfiles/dotfiles/.zshrc ~/
fi

# # Copy nvim folder to ~/
# rm -rf ~/.config/nvim
# if ! [[ -d ~/.config/nvim ]]; then
#     echo "Copying nvim to ~/.config/ ..."
#     ln -sf ~/Dotfiles/dotfiles/.config/nvim ~/.config/
# fi

if ! [[ -d ~/.tmux.conf ]]; then
    echo "Copying .tmux.conf to ~/ ..."
    ln -sf ~/Dotfiles/dotfiles/.tmux.conf ~/
fi

if ! [[ -d ~/.tmux ]]; then
    echo "Copying .tmux to ~/ ..."
    ln -sf ~/Dotfiles/dotfiles/.tmux ~/
fi

# Copy .icons file to ~/
if ! [[ -d ~/.icons ]]; then
    echo "Copying dotfiles to ~/.config ..."
    ln -sf ~/Dotfiles/dotfiles/.icons ~/
fi

if ! [[ -d ~/.local ]]; then
    echo "Copying dotfiles to ~/.config ..."
    ln -sf ~/Dotfiles/dotfiles/.local ~/
fi

if ! [[ -d ~/.themes ]]; then
    echo "Copying dotfiles to ~/.config ..."
    ln -sf ~/Dotfiles/dotfiles/.themes ~/
fi

# if ! [[ -d ~/.themes ]]; then
#     echo "Copying Web Apps to ~/.local/share/applications/ ..."
#     # ln -sf ~/Dotfiles/dotfiles/.local/share/applications/msedge-drawio.desktop ~/.local/share/applications/
#     # ln -sf ~/Dotfiles/dotfiles/.local/share/applications/msedge-perplexity.desktop ~/.local/share/applications/
#     # ln -sf ~/Dotfiles/dotfiles/.local/share/applications/msedge-whatsappWeb.desktop ~/.local/share/applications/
# fi
ln -sf ~/Dotfiles/dotfiles/.local/share/applications/* ~/.local/share/applications/