#!/bin/bash

# === Configuration ===

# List of original dotfiles (to be symlinked) - e.g., dotfiles repo
SOURCE_DIRS=(
	"$HOME/.dotfiles/.bashrc"
	"$HOME/.dotfiles/vim/"
	"$HOME/.dotfiles/tmux/"
	"$HOME/.dotfiles/waybar/"
	"$HOME/.dotfiles/wofi/"
	"$HOME/.dotfiles/kitty/"
	"$HOME/.dotfiles/i3/"
	"$HOME/.dotfiles/i3status/"
	"$HOME/.dotfiles/hypr/"
)

# List of destination targets (e.g., real home locations)
TARGET_DIRS=(
	"$HOME/.bashrc"
	"$HOME/.config/vim"
	"$HOME/.config/tmux"
	"$HOME/.config/waybar"
	"$HOME/.config/wofi"
	"$HOME/.config/kitty"
	"$HOME/.config/i3"
	"$HOME/.config/i3status"
	"$HOME/.config/hypr"
)

# Backup directory
BACKUP_DIR="$HOME/.dotfiles.bak"

# === Script Logic ===

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Loop through directories
for i in "${!TARGET_DIRS[@]}"; do
	SRC="${SOURCE_DIRS[$i]}"
	DEST="${TARGET_DIRS[$i]}"

		# Backup existing file or directory
		if [ -e "$DEST" ] || [ -L "$DEST" ]; then
			echo "Backing up $DEST to $BACKUP_DIR"
			cp -a "$DEST" "$BACKUP_DIR"
			rm -rf "$DEST"
		fi

		# Create symlink
		echo "Creating symlink: $DEST → $SRC"
		ln -s "$SRC" "$DEST"
	done

	echo "Done."

