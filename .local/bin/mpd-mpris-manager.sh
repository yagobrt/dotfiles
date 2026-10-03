#!/usr/bin/env bash

# If there is nothing on the playlist, kill the MPRIS notification
# If it's paused, MPRIS notification can stay

set -euo pipefail

SERVICE="mpd-mpris.service"

is_running() {
    systemctl --user is-active --quiet "$SERVICE"
}

ensure_started() {
    if ! is_running; then
        systemctl --user start "$SERVICE"
    fi
}

ensure_stopped() {
    if is_running; then
        systemctl --user stop "$SERVICE"
    fi
}

# If MPD isn't running, wait
until mpc status >/dev/null 2>&1; do
    sleep 1
done

while true; do
    # Wait for a change
    mpc idle player playlist >/dev/null

    if [[ -n "$(mpc playlist)" ]]; then
        ensure_started
    else
        ensure_stopped
    fi
done
