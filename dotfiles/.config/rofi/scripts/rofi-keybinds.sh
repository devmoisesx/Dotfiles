##!/bin/bash
#
#config_file="$HOME/.config/hypr/hyprland/keybinds.conf"
#extra_keybinds_file="$HOME/Dotfiles/dotfiles/keybinds.txt"
#
## Função para escapar caracteres para Pango markup
#pango_escape() {
#  sed 's/&/\&amp;/g; s/</\</g; s/>/\>/g; s/"/\&quot;/g; s/'"'"'/\&#39;/g'
#}
#
## -----------------------------------------------------
## 1. Ler keybinds do Hyprland
## -----------------------------------------------------
#hypr_keybinds=$(awk -F'[=#]' '
#    $1 ~ /^bind/ && $0 !~ /\[hidden\]/ {
#        gsub(/\$mainMod/, "SUPER", $0)
#        gsub(/^bind[[:space:]]*=+[[:space:]]*/, "", $0)
#        gsub(/^bind[[:alpha:]]+[[:space:]]*=+[[:space:]]*/, "", $0)
#        if (NF < 2) next
#        split($1, kbarr, ",")
#        if (length(kbarr[1]) > 0 && length(kbarr[2]) > 0) {
#            cmd = $2
#            gsub(/^[[:space:]]+|[[:space:]]+$/, "", cmd)
#            print "<b>" cmd "</b> - " kbarr[1] " + " kbarr[2]
#        }
#    }
#' "$config_file" 2>/dev/null | pango_escape)
#
## -----------------------------------------------------
## 2. Ler keybinds extras
## -----------------------------------------------------
#extra_entries=""
#if [[ -f "$extra_keybinds_file" ]]; then
#  while IFS= read -r line || [[ -n "$line" ]]; do
#    line=$(echo "$line" | xargs)
#    [[ -z "$line" ]] && continue
#    if [[ "$line" == *" - "* ]]; then
#      desc="${line%% - *}"
#      shortcut="${line##* - }"
#      # Escapar descrição e atalho separadamente
#      desc_esc=$(printf '%s' "$desc" | pango_escape)
#      shortcut_esc=$(printf '%s' "$shortcut" | pango_escape)
#      extra_entries+="<b>$desc_esc</b> - $shortcut_esc\n"
#    fi
#  done <"$extra_keybinds_file"
#fi
#
## -----------------------------------------------------
## 3. Combinar
## -----------------------------------------------------
#combined_keybinds=$(printf "%s\n%s" "$hypr_keybinds" "$extra_entries" | sed '/^[[:space:]]*$/d')
#
## if [[ -z "$combined_keybinds" ]]; then
##   rofi -e "Nenhuma keybind encontrada." -p "Erro" -config ~/.config/rofi/cheatsheet.rasi
##   exit 1
## fi
#
## -----------------------------------------------------
## 4. Exibir no Rofi
## -----------------------------------------------------
## sleep 0.2
#rofi -dmenu -i -markup-rows -eh 2 -replace -p "Keybinds" -config ~/.config/rofi/cheatsheet.rasi <<<"$combined_keybinds"

#!/bin/bash

config_file="$HOME/.config/hypr/hyprland/keybinds.conf"
extra_keybinds_file="$HOME/Dotfiles/dotfiles/keybinds.txt"

# Função RÁPIDA de escape (usa uma única chamada sed no final)
{
  # --- Hyprland keybinds (sem escape por linha) ---
  awk -F'[=#]' '
        $1 ~ /^bind/ && $0 !~ /\[hidden\]/ {
            gsub(/\$mainMod/, "SUPER", $0)
            gsub(/^bind[[:alpha:]]*[[:space:]]*=+[[:space:]]*/, "", $0)
            if (NF < 2) next
            split($1, kb, ",")
            if (kb[1] != "" && kb[2] != "") {
                gsub(/^[[:space:]]+|[[:space:]]+$/, "", $2)
                print "<b>" $2 "</b> - " kb[1] " + " kb[2]
            }
        }
    ' "$config_file"

  # --- Keybinds extras ---
  if [[ -f "$extra_keybinds_file" ]]; then
    awk -F' - ' 'NF==2 {
            gsub(/^[ \t]+|[ \t]+$/, "", $1)
            gsub(/^[ \t]+|[ \t]+$/, "", $2)
            if ($1 != "" && $2 != "") print "<b>" $1 "</b> - " $2
        }' "$extra_keybinds_file"
  fi
} | sed 's/&/\&amp;/g; s/</\</g; s/>/\>/g' |
  rofi -dmenu -i -markup-rows -eh 2 -replace -p "Keybinds" -config ~/.config/rofi/cheatsheet.rasi
