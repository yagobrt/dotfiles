#!/bin/env bash
# Copiar y pegar un enlace de mis notas de Obsidian

# Configurar teclado para que no haya problemas
setxkbmap es

cd ~/Documentos/obsidian-notes/ || exit

selected=$(grep -roP '\[.*?\]\((https?://.*?)\)' -- *.md | sort -u | rofi -dmenu -l 20)
if [ -z "$selected" ]; then
	exit
fi

link=$(echo "$selected" | sed -E 's/.*\((https?:\/\/[^)]+)\).*/\1/')


# Copiar al portapapeles e insertar
echo -n "$link" | xclip -selection primary
xdotool key --clearmodifiers Shift+Insert
