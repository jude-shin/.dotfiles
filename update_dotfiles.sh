#!/bin/bash

# Define the directory where the new dotfiles are located (relative to the script)
DOTFILES_DIR="./dotfiles"

# Define the CSV file that maps dotfiles to their paths
CSV_FILE="./paths.csv"

# Check if the dotfiles directory exists
if [ ! -d "$DOTFILES_DIR" ]; then
  echo "Error: $DOTFILES_DIR does not exist."
  exit 1
fi

# Check if the CSV file exists
if [ ! -f "$CSV_FILE" ]; then
  echo "Error: $CSV_FILE not found."
  exit 1
fi

# Parse command line arguments
if [ $# -gt 0 ]; then
  # If there are command-line arguments, filter by the specified files
  DOTFILES_TO_INSTALL=("$@")
else
  # Otherwise, install all dotfiles interactively (from the CSV file)
  DOTFILES_TO_INSTALL=($(awk -F',' 'NR>1 {print $1}' "$CSV_FILE"))
fi

# Function to copy files recursively
copy_files_recursively() {
  local src_dir="$1"
  local dest_dir="$2"
  
  # Create the destination directory if it doesn't exist
  mkdir -p "$dest_dir"

  # Loop through all files in the source directory
  for file in "$src_dir"/*; do
    if [ -d "$file" ]; then
      # If it's a directory, call the function recursively
      copy_files_recursively "$file" "$dest_dir/$(basename "$file")"
    else
      # If it's a file, copy it
      cp "$file" "$dest_dir/"
    fi
  done
}

# Loop through each file in the DOTFILES_TO_INSTALL list
for dotfile in "${DOTFILES_TO_INSTALL[@]}"; do
  # Extract the target path from the CSV based on the file name
  target_path=$(awk -F',' -v file="$dotfile" '$1 == file {print $2}' "$CSV_FILE")

  # Expand the path to handle ~ as the home directory
  expanded_target_path=$(eval echo "$target_path")

  # Define the full path of the dotfile in the repository
  dotfile_path="$DOTFILES_DIR/$dotfile"

  # Check if the target is a directory
  if [ -d "$expanded_target_path" ]; then
    # If the target path is a directory, we need to copy the contents recursively
    echo "Target is a directory: $expanded_target_path"
    echo "Copying contents of $dotfile_path to $expanded_target_path"
    copy_files_recursively "$dotfile_path" "$expanded_target_path"
  elif [ -f "$expanded_target_path" ]; then
    # If it's a file, ask the user whether to overwrite or skip
    echo "Found existing file: $expanded_target_path"
    read -p "Do you want to overwrite this file? (y/n/skip) " response

    case $response in
      y|Y)
        # Backup the old dotfile (if it exists) before overwriting
        echo "Backing up $expanded_target_path to $expanded_target_path.bak"
        mv "$expanded_target_path" "$expanded_target_path.bak"
        echo "Overwriting $expanded_target_path with $dotfile_path"
        cp "$dotfile_path" "$expanded_target_path"
        ;;
      n|N)
        echo "Skipping $expanded_target_path"
        ;;
      s|S)
        echo "Skipping $expanded_target_path"
        ;;
      *)
        echo "Invalid input, skipping $expanded_target_path"
        ;;
    esac
  else
    # If the target file doesn't exist, just copy the dotfile
    echo "No existing file found. Installing $expanded_target_path"
    cp "$dotfile_path" "$expanded_target_path"
  fi
done

echo "Dotfile overwrite complete!"

