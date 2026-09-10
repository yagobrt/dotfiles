#!/bin/bash

set -e

# TODO: Conseguir que pass funcione aún con el ordenador suspendido
# importante también para back-up-pswd.sh

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

SOURCE_DIR="finanzas"
BACKUP_FILE="finanzas.zip"

# Crear zip
zip -r "$BACKUP_FILE" "$SOURCE_DIR" 
if [ $? -eq 0 ]; then
	notify /usr/share/icons/Pop/scalable/apps/deja-dup-symbolic.svg "Backup - Finanzas" "Se ha guardado una copia de los documentos financieros"
else
	notify /usr/share/icons/Adwaita/scalable/status/dialog-warning-symbolic.svg "Backup - Finanzas" "Fallo al crear la copia de los documentos financieros"
	exit 1
fi

# Cifrar antes de subir a drive por si acaso
# TODO: Añadir cifrado

# Subir a drive
# rclone copy "$BACKUP_FILE" yago-drive:Y --progress
# if [ $? -eq 0 ]; then
# 	notify /usr/share/icons/Pop/scalable/places/folder-remote-symbolic.svg "Backup - Finanzas" "Backup de los documentos financieros subido a Google Drive"
# else
# 	notify /usr/share/icons/Adwaita/scalable/status/dialog-warning-symbolic.svg "Backup - Finanzas" "Fallo al subir el backup a Google Drive"
# 	exit 1
# fi
