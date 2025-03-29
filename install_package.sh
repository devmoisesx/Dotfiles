echo ""
echo "------------------ Instalador de Pacotes ------------------"
echo ""

echo ""
echo "Deseja instalar os pacotes pré definidos? [y/n]"
read answerPackages
echo ""

if [ "$answerPackages" = "y" ]; then
    sudo apt update && sudo apt upgrade
    sudo apt install -y curl vim git htop zsh sunshine rustdesk vlc gnome-screenshot draw.io lutris radeontop zfs-zed warp-terminal docker wmdocker wine gnome-tweaks eza libreoffice gedit thefuck bat micro python3 tmux 

    # instalar o pyenv
    curl https://pyenv.run | bash

    touch ~/.zshrc
    echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> ~/.zshrc
    echo 'eval "$(pyenv init --path)"' >> ~/.zshrc
    echo 'eval "$(pyenv init -)"' >> ~/.zshrc
    echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.zshrc

    # instalar moonlight
    sudo snap install moonlight

    # instalar obsidian
    sudo snap install obsidian --classic

    # install discord
    sudo snap install discord

    # install postman
    sudo snap install postman

    sudo snap install ghostty
    sudo snap install alacritty

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

    # instalar o nodejs
    curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
    sudo apt install -y nodejs

    # instalar o java
    sudo apt install -y openjdk-17-jdk
    sudo apt install -y maven

    #install zsh/vim fonts
    git clone --depth=1 https://github.com/powerline/fonts.git
    ./fonts/install.sh
    rm -rf fonts

    git clone --depth=1 https://github.com/ryanoasis/nerd-fonts.git
    ./nerd-fonts/install.sh
    rm -rf nerd-fonts

    # source ~/.zshrc

    # # instalar o python
    # pyenv install 3.13

    # instalar fzf
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf ~/.fzf/install

    # instalar zoxide
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
    echo 'eval "$(zoxide init zsh)"' >> ~/.zshrc

    echo set nu >> ~/.vim_runtime/my_configs.vim

    # instala o Starship
    curl -sS https://starship.rs/install.sh | sh

    starship preset nerd-font-symbols -o ~/.config/starship.toml

    echo ""
    echo "Todos os pacotes foram instalados!"
    echo ""
elif [ "$answerPackages" = "n" ]; then
    echo "Ok! Nenhum pacote será instalado!"
else
    echo "Opção inválida! Use 'y' para sim ou 'n' para não."
fi