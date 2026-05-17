#!/bin/bash

set -e

# Notification helper: never fail the backup if desktop notifications are unavailable
notify() {
	local icon="$1"
	local title="$2"
	local body="$3"

	XDG_RUNTIME_DIR="/run/user/$(id -u)" \
	DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus" \
		notify-send -i "$icon" "$title" "$body" >/dev/null 2>&1 || true
}

cd "$HOME/Documentos/"

# Notes directory
SOURCE_DIR="obsidian-notes"
BACKUP_FILE="obsidian-notes.zip"

# Exclude syncthing folder from backup
zip -r "$BACKUP_FILE" "$SOURCE_DIR" -x ".stfolder/"
if [ $? -eq 0 ]; then
	notify /usr/share/icons/Pop/scalable/apps/deja-dup-symbolic.svg "Backup - Notas" "Se ha guardado una copia de las notas"
else
	notify /usr/share/icons/Adwaita/scalable/status/dialog-warning-symbolic.svg "Backup - Notas" "Fallo al crear la copia de las notas"
	exit 1
fi

# Subir a drive
rclone copy "$BACKUP_FILE" yago-drive:Y --progress
if [ $? -eq 0 ]; then
	notify /usr/share/icons/Pop/scalable/places/folder-remote-symbolic.svg "Backup - Notas" "Backup de las notas subido a Google Drive"
else
	notify /usr/share/icons/Adwaita/scalable/status/dialog-warning-symbolic.svg "Backup - Notas" "Fallo al subir el backup a Google Drive"
	exit 1
fi
