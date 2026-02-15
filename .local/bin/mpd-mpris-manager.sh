#!/usr/bin/env bash

# If there is nothing on the playlist, kill the MPRIS notification
# If it's paused, MPRIS notification can stay

while mpc idle player playlist >/dev/null; do

	if [[ -z "$(mpc playlist)" ]]; then
		systemctl --user stop mpd-mpris
		continue
	fi

	systemctl --user start mpd-mpris
done
