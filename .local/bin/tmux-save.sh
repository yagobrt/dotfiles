#!/usr/bin/env bash
# Part 1 of my DIY tmux-resurrect
# Save tmux sessions

SAVE_DIR="$HOME/.local/share/tmux/sessions"
mkdir -p "$SAVE_DIR"

# Nombre de la configuración
read -rp "Configuration name: " name
SAVE_FILE="$SAVE_DIR/${name}"

# Seleccionar sesiones activas
sessions=$(tmux list-sessions -F "#{session_name}" | fzf --multi --prompt="Elige sesiones a guardar: ")

if [[ -z "$sessions" ]]; then
    tmux display-message "No session selected"
    exit 0
fi

# Guardar información de cada sesión
# : > "$SAVE_FILE"
for s in $sessions; do
    tmux list-windows -t "$s" -F "#{window_index}:#{window_name}:#{pane_current_path}" \
        | sed "s/^/${s}:/g" >> "$SAVE_FILE"
done

tmux display-message "Session $name saved in $SAVE_FILE"
