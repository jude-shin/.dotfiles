#!/bin/bash

TEMP_INDEX=9
TEMP_NAME="*temp"

# Get session and window details
SESSION_NAME=$(tmux display-message -p '#S')
CURRENT_INDEX=$(tmux display-message -p '#I')

# Are we already in the temp window?
if [ "$CURRENT_INDEX" = "$TEMP_INDEX" ]; then
	# Try to go back to the previous window if we stored it
	PREV_INDEX=$(tmux show-option -qv -t "$SESSION_NAME" @prev_window_id)
	if [ -n "$PREV_INDEX" ]; then
		tmux select-window -t "$SESSION_NAME:$PREV_INDEX"
	else
		tmux display-message "No previous window saved."
	fi
else
	# Save current window index before switching to temp
	tmux set-option -t "$SESSION_NAME" @prev_window_id "$CURRENT_INDEX"

		# Check if window 9 exists
		if tmux list-windows -F '#I' | grep -q "^$TEMP_INDEX$"; then
			tmux select-window -t "$SESSION_NAME:$TEMP_INDEX"
		else
			tmux new-window -t "$SESSION_NAME:$TEMP_INDEX" -n "$TEMP_NAME" 'bash'
		fi
fi

