#!/bin/bash

TEMP_INDEX=9
TEMP_NAME="*temp"
SESSION_NAME=$(tmux display-message -p '#S')

# If window 9 exists, switch to it
if tmux list-windows -F '#I' | grep -q "^$TEMP_INDEX$"; then
    tmux select-window -t "$SESSION_NAME:$TEMP_INDEX"
else
    tmux new-window -t "$SESSION_NAME:$TEMP_INDEX" -n "$TEMP_NAME" 'bash'
fi

