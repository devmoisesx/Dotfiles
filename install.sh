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
elif [ "$answerBackup" = "n" ]; then
    echo "Ok! backup não criado!"
else
    echo "Opção inválida! Use 'y' para sim ou 'n' para não."
fi

#Update
sudo apt update -y
sudo apt upgrade -y
sudo apt autoclean -y
sudo apt autoremove -y

echo ""
echo "Deseja instalar os pacotes pré definidos? [y/n]"
read answerInstallPackages
echo ""

if [ "$answerInstallPackages" = "y" ]; then
    echo "Inicializando script para instalar os pacotes..."
    ./install_package.sh
elif [ "$answerInstallPackages" = "n" ]; then
    echo "Ok! pacotes não instalados."
else
    echo "Opção inválida! Use 'y' para sim ou 'n' para não."
fi

echo ""
echo "Deseja mover as configs? [y/n]"
read answerMoveConfigs
echo ""

if [ "$answerMoveConfigs" = "y" ]; then
    echo "Movendo os arquivos de configuracoes!"
    sudo cp ./Configs/.config ~/
    sudo cp ./Configs/.gitconfig ~/
    sudo cp ./Configs/.icons ~/
    sudo cp ./Configs/.tmux ~/
    sudo cp ./Configs/.tmux.conf ~/
    sudo cp ./Configs/.zshrc ~/
elif [ "$answerMoveConfigs" = "n" ]; then
    echo "Ok! Configurações não movidas."
else
    echo "Opção inválida! Use 'y' para sim ou 'n' para não."
fi

echo ""
echo "Deseja reiniciar o sistema? [y/n]"
read answerReboot
echo ""

if [ "$answerReboot" = "y" ]; then
    echo "Reiniciando o sistema!"
    sudo reboot
elif [ "$answerReboot" = "n" ]; then
    echo "Ok! Sistema não será reiniciado"
else
    echo "Opção inválida! Use 'y' para sim ou 'n' para não."
fi

# echo ""
# echo "Deseja instalar e auto configurar o ZSH junto com o OH-MY-ZSH? [y/n]"
# read answerInstallZSH
# echo ""

# if [ "$answerInstallZSH" = "y" ]; then
#     echo "Inicializando script..."
#     ./install_zsh.sh
# elif [ "$answerInstallZSH" = "n" ]; then
#     echo "Ok! zsh não será instalado."
# else
#     echo "Opção inválida! Use 'y' para sim ou 'n' para não."
# fi