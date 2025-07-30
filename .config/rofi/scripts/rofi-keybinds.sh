#!/bin/bash

config_file="$HOME/.config/hypr/hyprland/keybinds.conf"

# -----------------------------------------------------
# Path to keybindings config file
# -----------------------------------------------------
echo "Reading from: $config_file"

keybinds=$(awk -F'[=#]' '
    $1 ~ /^bind/ && $0 !~ /\[hidden\]/ {
        # Replace the string "$mainMod" with "SUPER" (for the super key)
        gsub(/\$mainMod/, "SUPER", $0)

        # Remove "bind" and extra spaces, if any, at the beginning of the line
        gsub(/^bind[[:space:]]*=+[[:space:]]*/, "", $0)
        gsub(/^bindd[[:space:]]*=+[[:space:]]*/, "", $0)
        gsub(/^bindit[[:space:]]*=+[[:space:]]*/, "", $0)
        gsub(/^bindm[[:space:]]*=+[[:space:]]*/, "", $0)
        gsub(/^bindld[[:space:]]*=+[[:space:]]*/, "", $0)
        gsub(/^bindl[[:space:]]*=+[[:space:]]*/, "", $0)
        gsub(/^binde[[:space:]]*=+[[:space:]]*/, "", $0)

        # Split the keybinding part (e.g., "Mod1,Return") using a comma
        split($1, kbarr, ",")

        # Format the keybinding and associated command and prepare for output:
        # Concatenate the two keybinding keys (e.g., "Mod1" + "Return") and append the command
        print $2 " - " kbarr[1] " +" kbarr[2]
    }
' "$config_file")

sleep 0.2
rofi -dmenu -i -markup -eh 2 -replace -p "HyprLand Keybinds" -config ~/.config/rofi/cheatsheet.rasi <<<"$keybinds"

# # extract the keybinding from hyprland.conf
# mapfile -t BINDINGS < <(grep '^bind' "$HYPR_CONF" | \
#    grep -v '\[hidden\]' | \
#    sed -e 's/  */ /g' \
#            -e 's/^bindm = //' \
#            -e 's/^bindld = //' \
#            -e 's/^bindle = //' \
#            -e 's/^binditn = //' \
#            -e 's/^bindit = //' \
#            -e 's/^bindl = //' \
#            -e 's/^bindd = //' \
#            -e 's/^bind = //' \
#            -e 's/^bindm=//' \
#            -e 's/^bindld=//' \
#            -e 's/^bindle=//' \
#            -e 's/^binditn=//' \
#            -e 's/^bindit=//' \
#            -e 's/^bindl=//' \
#            -e 's/^bindd=//' \
#            -e 's/^bind=//' \
#            -e 's/^bindm= //' \
#            -e 's/^bindld= //' \
#            -e 's/^bindle= //' \
#            -e 's/^binditn= //' \
#            -e 's/^bindit= //' \
#            -e 's/^bindl= //' \
#            -e 's/^bindd= //' \
#            -e 's/^bind= //' \
#            -e 's/^bindld//' \
#            -e 's/^bindm//' \
#            -e 's/^bindle//' \
#            -e 's/^binditn//' \
#            -e 's/^bindit//' \
#            -e 's/^bindl//' \
#            -e 's/^bindd//' \
#            -e 's/^bind//' \
#            -e 's/, /,/g' | \
#     awk -F, -v q="'" '{
#        # Verifica se há comentário no último campo
#        last_field = $NF;
#        if(match(last_field, / # (.*)/, comment_match)) {
#            # Remove o comentário do último campo
#            $NF = substr(last_field, 1, RSTART-1);
#            comment = comment_match[1];
#        } else {
#            comment = "";
#        }
       
#        # Constrói o comando
#        cmd = "";
#        for(i=3; i<=NF; i++) {
#            cmd = cmd $i " ";
#        }
       
#        # Formata a saída
#        output = "<b>" $1 " + " $2 "</b>";
#        if(comment != "") {
#            output = output "  <b>" comment "</b>";
#        }
#        output = output "  <span color=" q "gray" q ">" cmd "</span>";
#        print output;
#    }')

# CHOICE=$(printf '%s\n' "${BINDINGS[@]}" | rofi -dmenu -i -markup-rows -p "Hyprland Keybinds:")

# # extract cmd from span <span color='gray'>cmd</span>
# CMD=$(echo "$CHOICE" | sed -n 's/.*<span color='\''gray'\''>\(.*\)<\/span>.*/\1/p')

# # execute it if first word is exec else use hyprctl dispatch
# if [[ $CMD == exec* ]]; then
#     eval "$CMD"
# else
#     hyprctl dispatch "$CMD"
# fi

