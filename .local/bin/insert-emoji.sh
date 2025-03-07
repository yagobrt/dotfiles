#!/bin/env bash
# Copiar y pegar un emoji

# Configurar teclado para que no haya problemas
setxkbmap es

emoji_file="$HOME/.local/share/emoji.txt"
if [ ! -f "$emoji_file" ]; then
	notify-send "No hay archivo de emoji" ":/"
	exit
fi

selected=$(rofi -dmenu -l 20 -i < "$emoji_file")
if [ -z "$selected" ]; then
	exit
fi

emoji=$(echo "$selected" | sed -E 's/^(\S+).*/\1/')


# Copiar al portapapeles e insertar
echo -n "$emoji" | xclip -selection primary   # Mid click
echo -n "$emoji" | xclip -selection clipboard # <C-v>
xdotool key --clearmodifiers Shift+Insert
