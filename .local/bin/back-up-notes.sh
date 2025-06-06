#!/bin/bash

# Set the display
export $(egrep -z DBUS_SESSION_BUS_ADDRESS /proc/$(pgrep -u $LOGNAME pop)/environ)

cd "$HOME/Documentos/"

# Notes directory
SOURCE_DIR="obsidian-notes"
BACKUP_FILE="obsidian-notes.zip"

# Exclude syncthing folder from backup
zip -r "$BACKUP_FILE" "$SOURCE_DIR" -x ".stfolder/"
if [ $? -eq 0 ]; then
	notify-send -i /usr/share/icons/Pop/scalable/apps/deja-dup-symbolic.svg "Backup" "Se ha guardado una copia de las notas"
else 
	notify-send -i /usr/share/icons/Adwaita/scalable/status/dialog-warning-symbolic.svg "Backup" "Fallo al crear la copia de las notas"
	exit 1
fi

# Subir a drive
rclone copy "$BACKUP_FILE" yago-drive:Y --progress
if [ $? -eq 0 ]; then
	notify-send -i /usr/share/icons/Pop/scalable/places/folder-remote-symbolic.svg "Backup" "Backup de las notas subido a Google Drive"
else
	notify-send -i /usr/share/icons/Adwaita/scalable/status/dialog-warning-symbolic.svg "Backup" "Fallo al subir el backup a Google Drive"
	exit 1
fi
