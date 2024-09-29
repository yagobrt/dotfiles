#!/bin/bash

cd "$HOME/Documentos/"

# Notes directory
SOURCE_DIR="obsidian-notes"
BACKUP_FILE="obsidian-notes.zip"

# Exclude syncthing folder from backup
zip -r "$BACKUP_FILE" "$SOURCE_DIR" -x ".stfolder/"
if [ $? -eq 0 ]; then
	notify-send -i /usr/share/icons/Pop/scalable/apps/disks-symbolic.svg "Backup" "Se ha guardado una copia de las notas"
else 
	notify-send -i /usr/share/icons/Pop/scalable/apps/preferences-system-notifications-symbolic.svg "Backup" "Fallo al crear la copia de las notas"
	exit 1
fi
