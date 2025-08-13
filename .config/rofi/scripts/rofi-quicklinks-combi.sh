#!/usr/bin/env bash

JSON_FILE="$HOME/.config/rofi/scripts/menus/quicklinks.json"

if [ $# -eq 0 ]; then
    # Mostrar categorias E itens juntos
    {
        # Categorias com ícone especial
        jq -r '.[] | "📁 " + .titleType + "\u0000icon\u001f" + .categoryIcon' "$JSON_FILE"
        echo "─────────────\u0000icon\u001fseparator"
        # Todos os itens
        jq -r '.[].itemsType[] | .titleItem + "\u0000icon\u001f" + .icon' "$JSON_FILE"
    }
    exit 0
fi

CHOICE="$1"

# Se for uma categoria (com 📁)
if [[ "$CHOICE" == 📁* ]]; then
    CATEGORY_NAME="${CHOICE#📁 }"
    
    # Mostrar só os itens desta categoria
    exec rofi -dmenu -i -p "🔗 $CATEGORY_NAME:" -show-icons < <(
        jq --arg choice "$CATEGORY_NAME" -r '
            .[] |
            select(.titleType == $choice) |
            .itemsType[] |
            .titleItem + "\u0000icon\u001f" + .icon
        ' "$JSON_FILE"
    )
else
    # Executar comando diretamente
    COMMAND=$(jq --arg choice "$CHOICE" -r '
        .[] |
        .itemsType[] |
        select(.titleItem == $choice) |
        .command
    ' "$JSON_FILE")
    
    if [[ -n "$COMMAND" && "$COMMAND" != "null" ]]; then
        coproc ( exec bash -c "$COMMAND" )
        exec 1>&-
    fi
fi
