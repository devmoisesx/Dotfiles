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

    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
    git clone https://github.com/z-shell/F-Sy-H.git \
    ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/F-Sy-H
    git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use
    git clone https://github.com/MichaelAquilina/zsh-auto-notify.git $ZSH_CUSTOM/plugins/auto-notify

    # Instalar gerenciador de plugins
    # curl -sL zplug.sh/installer | zsh
    # source ~/.zplug/init.zsh

    # Instalar plugins adicionais
    # zinit load "zsh-users/zsh-autosuggestions"
    # zinit load "zsh-users/zsh-history-substring-search"
    # zinit load "unixorn/web-search"
    # zinit load "rupa/z"
    # zinit load z-shell/F-Sy-H 
    # zinit load MichaelAquilina/zsh-you-should-use
    # zinit load marlonrichert/zsh-autocomplete
    # zinit load "zsh-users/zsh-command-not-found"

    # zinit load install
    # zinit update
    # zinit self-update

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