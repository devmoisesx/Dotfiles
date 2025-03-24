echo ""
echo "------------------ Instalador e Configurador do ZSH ------------------"
echo ""

echo ""
echo "Deseja iniciar o script? [y/n]"
read answer
echo ""

if [ "$answer" = "y" ]; then
    sudo apt update && sudo apt upgrade
    echo "Instalando o ZSH e o OH-MY-ZSH..."
    sudo apt install -y zsh

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

    echo 'eval $(thefuck --alias)' >> ~/.zshrc
    echo 'source $ZSH/oh-my-zsh.sh' >> ~/.zshrc
    echo 'export PATH="$PATH:/home/moises/.lmstudio/bin"' >> ~/.zshrc

    source ~/.zshrc

    # define zsh como shell principal
    chsh -s $(which zsh)

    echo ""
    echo "Script finalizado!"
    echo ""
elif [ "$answer" = "n" ]; then
    echo "Ok! encerrando o script..."
else
    echo "Opção inválida! Use 'y' para sim ou 'n' para não."
fi