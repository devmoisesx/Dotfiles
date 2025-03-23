#!/usr/bin/env bash

echo "**************************************************"
echo ""
echo "Automatizador de configurações do Sistema!"
echo ""
echo "**************************************************"

echo ""
echo "Deseja criar um backup primeiro? [y/n]"
read answerBackup
echo ""

if [ "$answerBackup" = "y" ]; then
    ./backup.sh
    # echo "Backup sendo feito..."
    if [ "$answerBackup" = "n" ]; then
        echo "Ok! backup não criado!"
    fi
fi

#Update
sudo apt update -y
sudo apt upgrade -y
sudo apt autoclean -y
sudo apt autoremove -y

echo ""
packets=(
        "curl" 
        "vim"
        "git"
        "htop"
        "sunshine"
        "moonlight"
        "rustdesk"
        "vlc"
        "alacritty"
        "gnome-screenshot"
        "draw.io"
        "obsidian"
        "discord"
        "lutris"
        "zsh"
        "postman"
        "rnote"
        "radeontop"
        "fasfetch"
        "zfs-zed"
        "warp-terminal"
        "docker"
        "wmdocker"
        "wine"
        "gnome-tweaks"
        "lsd"
        "libreoffice"
        "gedit"
        "thefuck"
        "bat"
    )

echo "Lista dos pacotes pré definidos:"
for packet in "${packets[@]}"; do
    echo "- $packet"
done
echo "Deseja instalar os pacotes pré definidos? [y/n]"
read answerPackets
echo ""


if [ "$answerPackets" = "y" ]; then
    sudo apt update && sudo apt upgrade
    for packet in "${packets[@]}"; do
        echo "Instalando $packet..."
        # sudo apt install -y "$packet"
    done

    #Install Visual Studio Code
    sudo snap install --classic code

    #add user to sudo-docker
    sudo usermod -aG docker $USER

    #install vim
    git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
    sh ~/.vim_runtime/install_awesome_vimrc.sh

    #install micro
    curl https://getmic.ro | bash
    sudo mv micro /usr/bin

    # install bat
    mkdir -p ~/.local/bin
    ln -s /usr/bin/batcat ~/.local/bin/bat 

    #install zsh/vim fonts
    git clone --depth=1 https://github.com/powerline/fonts.git
    ./fonts/install.sh
    rm -rf fonts

    git clone --depth=1 https://github.com/ryanoasis/nerd-fonts.git
    ./nerd-fonts/install.sh
    rm -rf nerd-fonts

    #install oh-my-zsh
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    sed -i 's/ZSH_THEME=\"robbyrussell\"/ZSH_THEME=\"agnoster\"/g' .zshrc
    echo 'alias ls="lsd -1"' >> ~/.zshrc
    echo 'alias c="code ."' >> ~/.zshrc
    echo 'alias bat="batcat"' >> ~/.zshrc
    echo 'skip_global_compinit=1' >> ~/.zshrc
    echo 'export ZSH_AUTOCOMPLETE_ADD_SEMICOLON=false' >> ~/.zshrc

    # Adicionar plugins ao .zshrc
    echo 'plugins=(
        git
        sudo
        history
    )' >> ~/.zshrc

    # Instalar gerenciador de plugins
    curl -sL zplug.sh/installer | zsh
    source ~/.zplug/init.zsh

    # Instalar plugins adicionais
    zplug "zsh-users/zsh-autosuggestions"
    zplug "zsh-users/zsh-history-substring-search"
    zplug "unixorn/web-search"
    zplug "rupa/z"
    zplug "F-Sy-H/zsh-fsyh"
    zplug "garethflowers/you-should-use"
    zplug "zsh-users/zsh-autocomplete"
    zplug "zsh-users/zsh-command-not-found"

    zplug install
    zplug update
    zplug load --verbose

    # Adicionar plugins ao .zshrc
    # echo 'plugins=(
    #     git
    #     zsh-autosuggestions
    #     zsh-history-substring-search
    #     web-search 
    #     z
    #     sudo
    #     history
    #     F-Sy-H
    #     you-should-use
    #     auto-notify
    #     command-not-found
    #     dirhistory 
    #     zsh-autocomplete
    # )' >> ~/.zshrc

    echo 'eval $(thefuck --alias)' >> ~/.zshrc
    echo 'source $ZSH/oh-my-zsh.sh' >> ~/.zshrc
    echo 'export PATH="$PATH:/home/moises/.lmstudio/bin"' >> ~/.zshrc

    source ~/.zshrc
    exec zsh

    # define zsh como shell principal
    chsh -s $(which zsh)

    echo set nu >> ~/.vim_runtime/my_configs.vim

    echo ""
    echo "Todos os pacotes foram instalados!"
    echo ""
elif [ "$answerPackets" = "n" ]; then
    echo "Ok! Nenhum pacote será instalado!"
else
    echo "Opção inválida! Use 'y' para sim ou 'n' para não."
fi

