#!/bin/bash

cd "$HOME/Documentos/"

# Notes directory
SOURCE_DIR="obsidian-motes"
BACKUP_FILE="obsidian-motes.zip"

# Exclude syncthing folder from backup
zip -r "$BACKUP_FILE" "$SOURCE_DIR" -x ".stfolder/"

# Show notification
notify-send -i /usr/share/icons/Pop/scalable/apps/disks-symbolic.svg "Backup" "Se ha guardado una copia de las notas"
