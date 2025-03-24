echo ""
echo "------------------ Instalador de Pacotes ------------------"
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
        "python3"
        "python3-pip"
    )

echo "Lista dos pacotes pré definidos:"
for package in "${packages[@]}"; do
    echo "- $package"
done

echo ""
echo "Deseja instalar os pacotes pré definidos? [y/n]"
read answerPackages
echo ""

if [ "$answerPackages" = "y" ]; then
    sudo apt update && sudo apt upgrade
    for package in "${packages[@]}"; do
        echo "Instalando $package..."
        sudo apt install -y "$package"
    done

    # instalar o pyenv
    curl https://pyenv.run | bash

    touch ~/.zshrc
    echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> ~/.zshrc
    echo 'eval "$(pyenv init --path)"' >> ~/.zshrc
    echo 'eval "$(pyenv init -)"' >> ~/.zshrc
    echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.zshrc

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

    echo set nu >> ~/.vim_runtime/my_configs.vim

    echo ""
    echo "Todos os pacotes foram instalados!"
    echo ""
elif [ "$answerPackages" = "n" ]; then
    echo "Ok! Nenhum pacote será instalado!"
else
    echo "Opção inválida! Use 'y' para sim ou 'n' para não."
fi