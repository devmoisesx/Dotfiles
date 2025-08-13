# #!/usr/bin/env bash
# dir="$HOME/.config/rofi"
# theme='wifi'
# JSON_FILE="./menus/quicklinks.json"

# # Função para debug (opcional - remova em produção)
# debug_log() {
#     echo "DEBUG: $1" >> /tmp/rofi-debug.log
# }

# # Função para executar comando
# execute_command() {
#     local command="$1"
#     debug_log "Executando comando: $command"
#     if [[ -n "$command" && "$command" != "null" ]]; then
#         # Executa em background para que o rofi feche
#         nohup bash -c "$command" >/dev/null 2>&1 &
#     else
#         debug_log "Comando vazio ou null"
#     fi
# }

# # Criar menu principal com ícones personalizados para categorias
# ROFI_CHOICE=$(jq -r '
#   [
#     (.[] | "CATEGORY:" + .titleType + "\u0000icon\u001f" + .categoryIcon),
#     "---\u0000icon\u001fseparator",
#     (.[].itemsType[] | "ITEM:" + .titleItem + "\u0000icon\u001f" + .icon)
#   ] | .[]
# ' "$JSON_FILE" | rofi -i -dmenu -p "Quick Links:" -show-icons -theme "${dir}/${theme}.rasi")

# if [[ -z "$ROFI_CHOICE" ]]; then
#     exit 0
# fi

# debug_log "Escolha: $ROFI_CHOICE"

# # Verificar tipo de escolha
# if [[ "$ROFI_CHOICE" == CATEGORY:* ]]; then
#     # Extrair nome da categoria
#     CATEGORY_NAME="${ROFI_CHOICE#CATEGORY:}"
#     debug_log "Categoria selecionada: $CATEGORY_NAME"
    
#     # Submenu para categoria com ícones
#     SUBMENU_CHOICE=$(jq --arg choice "$CATEGORY_NAME" -r '
#         .[] |
#         select(.titleType == $choice) |
#         .itemsType[] |
#         "SUBITEM:" + .titleItem + "\u0000icon\u001f" + .icon
#     ' "$JSON_FILE" | rofi -i -dmenu -p "$CATEGORY_NAME:" -show-icons -theme "${dir}/${theme}.rasi")
    
#     if [[ -n "$SUBMENU_CHOICE" && "$SUBMENU_CHOICE" != "---" ]]; then
#         ITEM_NAME="${SUBMENU_CHOICE#SUBITEM:}"
#         debug_log "Subitem selecionado: $ITEM_NAME"
        
#         COMMAND=$(jq --arg parent_choice "$CATEGORY_NAME" --arg sub_choice "$ITEM_NAME" -r '
#             .[] |
#             select(.titleType == $parent_choice) |
#             .itemsType[] |
#             select(.titleItem == $sub_choice) |
#             .command
#         ' "$JSON_FILE")
        
#         debug_log "Comando encontrado: $COMMAND"
#         execute_command "$COMMAND"
#     fi
    
# elif [[ "$ROFI_CHOICE" == ITEM:* ]]; then
#     # Item direto
#     ITEM_NAME="${ROFI_CHOICE#ITEM:}"
#     debug_log "Item direto selecionado: $ITEM_NAME"
    
#     COMMAND=$(jq --arg choice "$ITEM_NAME" -r '
#         .[] |
#         .itemsType[] |
#         select(.titleItem == $choice) |
#         .command
#     ' "$JSON_FILE")
    
#     debug_log "Comando encontrado: $COMMAND"
#     execute_command "$COMMAND"
# fi

#!/usr/bin/env bash
dir="$HOME/.config/rofi"
theme='wifi'
JSON_FILE="${dir}/scripts/menus/quicklinks.json"

# Função para debug (opcional - remova em produção)
debug_log() {
    echo "DEBUG: $1" >> /tmp/rofi-debug.log
}

# Função para executar comando
execute_command() {
    local command="$1"
    debug_log "Executando comando: $command"
    if [[ -n "$command" && "$command" != "null" ]]; then
        # Executa em background para que o rofi feche
        nohup bash -c "$command" >/dev/null 2>&1 &
    else
        debug_log "Comando vazio ou null"
    fi
}

# Criar menu principal com ícones personalizados para categorias
ROFI_CHOICE=$(jq -r '
  [
    (.[] | "CATEGORY:" + .titleType + "\u0000icon\u001f" + .categoryIcon),
    "---\u0000icon\u001fseparator",
    (.[] | .itemsType[] | "ITEM:" + .titleItem + "\u0000icon\u001f" + .icon)
  ] | .[]
' "$JSON_FILE" | rofi -i -dmenu -p "Quick Links:" -show-icons -theme "${dir}/${theme}.rasi")

if [[ -z "$ROFI_CHOICE" ]]; then
    exit 0
fi

debug_log "Escolha: $ROFI_CHOICE"

# Verificar tipo de escolha
if [[ "$ROFI_CHOICE" == CATEGORY:* ]]; then
    # Extrair nome da categoria
    CATEGORY_NAME="${ROFI_CHOICE#CATEGORY:}"
    debug_log "Categoria selecionada: $CATEGORY_NAME"
    
    # Submenu para categoria com ícones
    SUBMENU_CHOICE=$(jq --arg choice "$CATEGORY_NAME" -r '
        .[] |
        select(.titleType == $choice) |
        .itemsType[] |
        "SUBITEM:" + .titleItem + "\u0000icon\u001f" + .icon
    ' "$JSON_FILE" | rofi -i -dmenu -p "$CATEGORY_NAME:" -show-icons -theme "${dir}/${theme}.rasi")
    
    if [[ -n "$SUBMENU_CHOICE" && "$SUBMENU_CHOICE" != "---" ]]; then
        ITEM_NAME="${SUBMENU_CHOICE#SUBITEM:}"
        debug_log "Subitem selecionado: $ITEM_NAME"
        
        COMMAND=$(jq --arg parent_choice "$CATEGORY_NAME" --arg sub_choice "$ITEM_NAME" -r '
            .[] |
            select(.titleType == $parent_choice) |
            .itemsType[] |
            select(.titleItem == $sub_choice) |
            .command
        ' "$JSON_FILE")
        
        debug_log "Comando encontrado: $COMMAND"
        execute_command "$COMMAND"
    fi
    
elif [[ "$ROFI_CHOICE" == ITEM:* ]]; then
    # Item direto
    ITEM_NAME="${ROFI_CHOICE#ITEM:}"
    debug_log "Item direto selecionado: $ITEM_NAME"
    
    COMMAND=$(jq --arg choice "$ITEM_NAME" -r '
        .[] |
        .itemsType[] |
        select(.titleItem == $choice) |
        .command
    ' "$JSON_FILE")
    
    debug_log "Comando encontrado: $COMMAND"
    execute_command "$COMMAND"
fi
