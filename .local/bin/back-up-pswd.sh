#!/bin/bash

set -e

# Set the display
export $(grep -E -z DBUS_SESSION_BUS_ADDRESS /proc/$(pgrep -u "$LOGNAME" pop)/environ)

DB="$HOME/Documentos/keepass/Contraseñas.kdbx"
GPG_PASS=$(pass show keepass/drive)
BACKUP_FILE="$HOME/Documentos/keepass/backup/Contraseñas.kdbx.gpg"

if [[ -f "$BACKUP_FILE" ]]; then
	rm "$BACKUP_FILE"
fi

gpg -c --no-symkey-cache --batch --passphrase "$GPG_PASS" --cipher-algo AES256 "$DB"
if [ $? -eq 0 ]; then
	notify-send -i /usr/share/icons/Pop/scalable/actions/system-lock-screen-symbolic.svg "Backup - Contraseñas" "Se ha cifrado el almacén de contraseñas"
else 
	notify-send -i /usr/share/icons/Adwaita/scalable/status/dialog-warning-symbolic.svg "Backup - Contraseñas" "Fallo al cifrar el almacén de contraseñas"
	exit 1
fi

mv "$DB.gpg" "$BACKUP_FILE"

# Check integrity
ORIG_HASH=$(sha256sum "$DB" | awk '{print $1}')


NEW_HASH=$(gpg --decrypt  --quiet --batch --passphrase "$GPG_PASS" --cipher-algo AES256 "$BACKUP_FILE" | sha256sum | awk '{print $1}')

if [ "$ORIG_HASH" == "$NEW_HASH" ]; then
	notify-send -i /usr/share/icons/Pop/scalable/actions/selection-checked-symbolic.svg "Backup - Contraseñas" "Se ha verificado el cifrado de las contraseñas"
else
	notify-send -i /usr/share/icons/Adwaita/scalable/status/dialog-warning-symbolic.svg "Backup - Contraseñas" "Fallo al verificar el cifrado de las contraseñas"
	exit 1
fi

# Subir a drive
rclone copy "$BACKUP_FILE" yago-drive:Y --progress
if [ $? -eq 0 ]; then
	notify-send -i /usr/share/icons/Pop/scalable/places/folder-remote-symbolic.svg "Backup - Contraseñas" "Backup de las contraseñas subido a Google Drive"
else
	notify-send -i /usr/share/icons/Adwaita/scalable/status/dialog-warning-symbolic.svg "Backup - Contraseñas" "Fallo al subir el backup a Google Drive"
	exit 1
fi
