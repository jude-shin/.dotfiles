#!/bin/bash

# =================================================================
# This script creates symbolic links for dotfiles.
#
# Usage:
#   - To use default dotfiles defined in the script:
#     ./link_dotfiles.sh
#
#   - To use custom dotfiles from text files:
#     ./link_dotfiles.sh <source_list.txt> <destination_list.txt>
#
#   The text files should contain one file or directory path per line.
# =================================================================

# --- Script Configuration ---

# Default source and destination lists
# These are used if no command-line arguments are provided.
DEFAULT_SRC_DIRS=(
    "$HOME/.dotfiles/bashrc/bashrc"
    "$HOME/.dotfiles/vim/"
    "$HOME/.dotfiles/tmux/"
    "$HOME/.dotfiles/waybar/"
    "$HOME/.dotfiles/wofi/"
    "$HOME/.dotfiles/kitty/"
    "$HOME/.dotfiles/i3/"
    "$HOME/.dotfiles/i3blocks/"
    "$HOME/.dotfiles/hypr/"
    "$HOME/.dotfiles/xautocfg.cfg"
)

DEFAULT_DEST_DIRS=(
    "$HOME/.bashrc"
    "$HOME/.config/vim"
    "$HOME/.config/tmux"
    "$HOME/.config/waybar"
    "$HOME/.config/wofi"
    "$HOME/.config/kitty"
    "$HOME/.config/i3"
    "$HOME/.config/i3blocks"
    "$HOME/.config/hypr"
    "$HOME/.config/xautocfg.cfg"
)

# Backup directory
BACKUP_DIR="$HOME/.dotfiles.bak"

# --- Main Logic ---

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Check for command-line arguments
if [ "$#" -eq 2 ]; then
    echo "Using custom dotfile lists from provided arguments."
    SRC_FILE="$1"
    DEST_FILE="$2"

    # Check if files exist
    if [ ! -f "$SRC_FILE" ] || [ ! -f "$DEST_FILE" ]; then
        echo "Error: One or both of the provided files do not exist."
        exit 1
    fi

    # Read lines into arrays
    mapfile -t SRC_DIRS < "$SRC_FILE"
    for i in "${!SRC_DIRS[@]}"; do
        eval SRC_DIRS[$i]="${SRC_DIRS[$i]}"
    done

    mapfile -t DEST_DIRS < "$DEST_FILE"
    for i in "${!DEST_DIRS[@]}"; do
        eval DEST_DIRS[$i]="${DEST_DIRS[$i]}"
    done

    # Validate that the number of lines is the same
    if [ "${#SRC_DIRS[@]}" -ne "${#DEST_DIRS[@]}" ]; then
        echo "Error: The number of lines in the source and destination files do not match."
        exit 1
    fi

elif [ "$#" -eq 0 ]; then
    echo "Using default dotfile lists."
    SRC_DIRS=("${DEFAULT_SRC_DIRS[@]}")
    DEST_DIRS=("${DEFAULT_DEST_DIRS[@]}")

else
    echo "Error: Invalid number of arguments."
    echo "Usage:"
    echo "  - For default dotfiles: $0"
    echo "  - For custom dotfiles: $0 <source_list.txt> <destination_list.txt>"
    exit 1
fi

# --- Symlinking Process ---
echo "Starting the symlinking process..."
for i in "${!DEST_DIRS[@]}"; do
    SRC="${SRC_DIRS[$i]}"
    DEST="${DEST_DIRS[$i]}"

    # Check if source exists before proceeding
    if [ ! -e "$SRC" ]; then
        echo "Warning: Source file/directory '$SRC' does not exist. Skipping."
        continue
    fi

    # Backup existing file or directory if it exists and is not a broken symlink
    if [ -e "$DEST" ] || [ -L "$DEST" ]; then
        echo "Backing up '$DEST' to '$BACKUP_DIR'..."
        cp -a "$DEST" "$BACKUP_DIR/"
        rm -rf "$DEST"
    fi

    # Create symlink
    echo "Creating symlink: '$DEST' -> '$SRC'"
    ln -s "$SRC" "$DEST"
done

echo "Done."
