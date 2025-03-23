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

echo ""
echo "Deseja instalar os pacotes pré definidos? [y/n]"
read answerInstallPackets
echo ""

if [ "$answerInstallPackets" = "y" ]; then
    echo "Inicializando script para instalar os pacotes..."
    ./install_packets.sh
elif [ "$answerInstallPackets" = "n" ]; then
    echo "Ok! pacotes não instalados."
else
    echo "Opção inválida! Use 'y' para sim ou 'n' para não."
fi

