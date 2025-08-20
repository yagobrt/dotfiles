#!/usr/bin/env bash
# Part 2 of my DIY tmux-resurrect
# Restore one of the saved sessions

has_session() {
    tmux list-sessions | grep -q "^$1:"
}

SAVE_DIR="$HOME/.local/share/tmux/sessions"

# Choose config to load
config=$(ls "$SAVE_DIR" | fzf --prompt="Choose config: ")

if [[ -z "$config" ]]; then
    tmux display-message "No configuration selected"
    echo "No configuration selected"
    exit 0
fi

SAVE_FILE="$SAVE_DIR/${config}"

while IFS=: read -r session win_index win_name pane_path; do
    if ! has_session "$session"; then
        tmux new-session -ds "$session" -c "$pane_path" -n "$win_name"
    else
        tmux new-window -t "$session" -c "$pane_path" -n "$win_name"
    fi
done < "$SAVE_FILE"

tmux display-message "$SAVE_FILE restored"
