#!/bin/env bash
# Copiar y pegar un emoji

if ! command -v wl-copy >/dev/null || ! command -v wtype >/dev/null || ! command -v rofi >/dev/null; then
	command -v notify-send >/dev/null &&
		notify-send "No se puede insertar el emoji" "Faltan wl-clipboard, wtype o rofi"
	exit 1
fi

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
echo -n "$emoji" | wl-copy --primary   # Mid click
echo -n "$emoji" | wl-copy             # <C-v>
wtype "$emoji"
