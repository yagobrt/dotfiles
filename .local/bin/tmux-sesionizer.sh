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
    paths="$HOME/ $HOME/Documentos $HOME/Documentos/programming $HOME/Documentos/uni/tfg $HOME/Documentos/uni/master-fintech"
    selected=$(find $paths -mindepth 1 -maxdepth 2 -type d | fzf --cycle)
fi

if [[ -z "$selected" ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z "$tmux_running" ]]; then
    tmux new-session -s "$selected_name" -c "$selected"
    exit 0
fi

if ! has_session "$selected_name"; then
    tmux new-session -ds "$selected_name" -c "$selected"
fi

switch_to "$selected_name"