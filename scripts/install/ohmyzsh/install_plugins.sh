echo "=== Installing Plugins Oh My Zsh ==="

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