#!/usr/bin/env bash

# ------------------------------- VARIÁVEIS ----------------------------
# USER_NAME=$(whoami)
# echo "$USER_NAME variavel"
# echo "$USER"
# echo "$USERNAME"

DIR_BACKUP=("/home/$USER")
DIR_DESTINO="/home/$USER/backup"

DATE=$(date "+%d-%m-%Y")
ARQUIVO="backup_$DATE.tar.gz"

LOG="/var/log/backup.log"

# ------------------------------- TESTES -------------------------------
# ! mountpoint -q -- "$DIR_DESTINO"; then
#     sudo mount /dev/sda1 "$DIR_DESTINO" 2>/dev/null
#     if ! mountpoint -q -- "$DIR_DESTINO"; then
#         echo "[$(date '+%Y-%m-%d %H:%M:%S')] Não montado." >> "$LOG"
#         exit 1
#     fi
# fi

if [ ! -d $DIR_DESTINO ]; then
    mkdir $DIR_DESTINO 
    echo "Pasta do backup criada!"
    echo "Backup sendo feito..."
    if [ ! -d $DIR_DESTINO ]; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] Pasta não criada." >> "$LOG"
        exit 1
    fi
fi


# if tar -czSpf "$DIR_DESTINO/$ARQUIVO" "${DIR_BACKUP[@]}"; then
#     echo "[$(date '+%Y-%m-%d %H:%M:%S')] Backup Completo." >> "$LOG"
# else
#     echo "[$(date '+%Y-%m-%d %H:%M:%S')] Erro ao realizar o backup." >> "$LOG"
#     exit 1
# fi

if tar -czSpf "$DIR_DESTINO/$ARQUIVO" "${DIR_BACKUP[@]}"; then
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Backup Completo." >> "$LOG"
else
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Erro ao realizar o backup." >> "$LOG"
    exit 1
fi