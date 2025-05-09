#!/bin/bash

# Pega a classe da janela ativa
win_class=$(hyprctl activewindow -j | jq -r '.class')

# Se a classe estiver vazia, sai
if [ -z "$win_class" ]; then
  notify-send "Erro: não foi possível obter a classe da janela."
  exit 1
fi

# Remove aspas duplas desnecessárias
win_class=$(echo "$win_class" | sed 's/"//g')

# Define a regra flutuante
hyprctl keyword windowrulev2 "float, class:^(\"$win_class\")$"

# Notificação opcional (se tiver `notify-send` instalado)
notify-send "Janela marcada como flutuante: $win_class"
