#!/usr/bin/bash
set -f

# Copy of thePrimeAgen tmux-sesionizer script
# https://github.com/ThePrimeagen/tmux-sessionizer

switch_to() {
    if [[ -z $TMUX ]]; then
        tmux attach-session -t "$1"
    else
        tmux switch-client -t "$1"
    fi
}

has_session() {
    tmux list-sessions | grep -q "^$1:"
}


if [[ $# -eq 1 ]]; then
    selected=$1
else
    one_lvl="$(find $HOME $HOME/Descargas $HOME/Vídeos $HOME/Imágenes -maxdepth 1 -type d)"
    two_lvl="$(find $HOME/Documentos $HOME/Documentos/uni -maxdepth 2 -type d)"
    selected="$(echo -e "$one_lvl\n$two_lvl" | sort | uniq | fzf --cycle)"
fi

if [[ -z "$selected" ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr .: _)
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z "$tmux_running" ]]; then
    tmux new-session -s "$selected_name" -c "$selected"
    exit 0
fi

if ! has_session "$selected_name"; then
    tmux new-session -ds "$selected_name" -c "$selected"
fi

switch_to "$selected_name"
