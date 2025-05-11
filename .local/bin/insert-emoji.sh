#!/bin/env bash
# Copiar y pegar un emoji

# Configurar teclado para que no haya problemas
setxkbmap es

emoji_file="$HOME/.local/share/emoji.txt"
nerdfont_file="$HOME/.local/share/nerdfont.txt"
if [ ! -f "$emoji_file" ] && [ ! -f "$nerdfont_file" ]; then
	notify-send "No hay archivo de emoji ni de símbolos" ":/"
	exit
fi

combined=$(mktemp)
[ -f "$emoji_file" ] && cat "$emoji_file" >> "$combined"
[ -f "$nerdfont_file" ] && cat "$nerdfont_file" >> "$combined"

selected=$(rofi -dmenu -l 20 -i < "$combined")
if [ -z "$selected" ]; then
	exit
fi

emoji=$(echo "$selected" | sed -E 's/^(\S+).*/\1/')


# Copiar al portapapeles e insertar
echo -n "$emoji" | xclip -selection primary   # Mid click
echo -n "$emoji" | xclip -selection clipboard # <C-v>
xdotool key --clearmodifiers Shift+Insert
