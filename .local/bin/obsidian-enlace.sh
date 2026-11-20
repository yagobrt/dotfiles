#!/bin/env bash
# Copiar y pegar un enlace de mis notas de Obsidian

if ! command -v wl-copy >/dev/null || ! command -v wtype >/dev/null || ! command -v rofi >/dev/null; then
	command -v notify-send >/dev/null &&
		notify-send "No se puede copiar el enlace" "Faltan wl-clipboard, wtype o rofi"
	exit 1
fi

cd "$HOME/Documentos/obsidian-notes/" || exit

# Extraer los enlaces si están tal cual o en formato md [text](link)
selected=$(grep -roP '(?:\[[^\]]*\]\()?(https?://[^\s)]+)(?:\))?' --include=*.md --  | sort -u | rofi -dmenu -l 20 -i)
if [ -z "$selected" ]; then
	exit
fi

link=$(echo "$selected" | sed -E 's/.*(https?:\/\/[^)]+).*/\1/')


# Copiar al portapapeles e pegar en la ventana activa
echo -n "$link" | wl-copy --primary   # Mid click
echo -n "$link" | wl-copy             # <C-v>
wtype "$link"
