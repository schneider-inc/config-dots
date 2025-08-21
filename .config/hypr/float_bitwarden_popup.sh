#!/usr/bin/env bash

# The exact title of the Bitwarden extension window
TARGET_TITLE="Extension: (Bitwarden Password Manager) - Bitwarden — Zen Browser"

# Use socat to listen to Hyprland events
socat - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r event; do
    # Check if the event is a window title change
    if [[ $event == "windowtitle>>"* ]]; then
        # Extract the window address from the event
        WINDOW_ADDRESS="0x${event#*>>}"

        # Get the new title of that specific window using hyprctl and jq
        CURRENT_TITLE=$(hyprctl clients -j | jq -r --arg addr "$WINDOW_ADDRESS" '.[] | select(.address == $addr).title')

        # Check if the new title matches our target
        if [[ $CURRENT_TITLE == $TARGET_TITLE ]]; then
            # If it matches, apply all rules in a single batch command
            hyprctl --batch \
                "dispatch setfloating address:$WINDOW_ADDRESS; \
                 dispatch resizewindowpixel exact 622 652,address:$WINDOW_ADDRESS; \
                 dispatch focuswindow address:$WINDOW_ADDRESS"
        fi
    fi
done
