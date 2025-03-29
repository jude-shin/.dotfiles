#!/bin/bash

# $XDG_CONFIG_HOME
# $HOME
NEW_PATH="./dotfiles/"
CSV_PATH="./paths.csv"

function INSTALL_DOTFILE {
	# args: name, new, path
	local name=$1
	local new=$2
	local path=$3

	CONFIRM_INSTALL "$name" "$new" "$path"
	local confirm_status=$?

	if [ $confirm_status -eq 0 ]; then
		# the user canceled this install, and you should skip it
		echo "SKIPPING $name dotfile..."
	elif [ $confirm_status -eq 1 ]; then
		# the user wants to install this, so go ahead and install it
		echo "INSTALLING new $name dotfile..."

		# make a backup of the file in the same location, just with a .bak or something
		# overwrite the file(s) that are in the directory $NEW_PATH + $new
		
		# Expand ~ to full home directory path
		path=$(eval echo "$path")

		# Create the destination directory if it doesn't exist
		mkdir -p "$path"

		# Check if the source is a directory
		if [ -d "$NEW_PATH$new" ]; then
			echo "Source is a directory. Updating all files recursively in $NEW_PATH$new"

			# Loop through all files in the source directory and update them
			find "$NEW_PATH$new" -type f | while read src_file; do
				# Get the relative path of the file (relative to the source directory)
				relative_path="${src_file#$NEW_PATH$new/}"

				# Determine the destination path for the file
				dest_file="$path/$relative_path"

				# Create the destination directory if it doesn't exist
				mkdir -p "$(dirname "$dest_file")"

				# Backup the existing file if it exists
				if [ -f "$dest_file" ]; then
					echo "Backing up existing file at $dest_file to $dest_file.bak"
					cp "$dest_file" "$dest_file.bak"
				fi

				# Copy the new file from the source to the destination
				echo "Copying $src_file to $dest_file"
				cp "$src_file" "$dest_file"
			done
	else

		# If it's a single file, back it up and install as before
		if [ -f "$path" ]; then
			echo "Backing up existing file at $path to $path.bak"
			cp "$path" "$path.bak"
		fi

		# Install the new dotfile (overwrite or create new)
		echo "Copying new dotfile from $NEW_PATH$new to $path"
		cp "$NEW_PATH$new" "$path"
		fi
		# -------------------------------------------------
	fi
}

function CONFIRM_INSTALL {
	# args: name, new, path
	local name=$1
	local new=$2
	local path=$3

	echo "Do you want to install the $name dotfile?"

	while true; do
		# Explicitly prompt for user input
		read -p "WARNING, may overwrite files! (y/n): " response

		if [[ "$response" == "y" ]]; then
			return 1  # Proceed with install
		elif [[ "$response" == "n" ]]; then
			return 0  # Skip install
		else
			echo "Please enter 'y' or 'n' as a response"
		fi
	done
}

# ------------------------------------------

mapfile -t lines < "$CSV_PATH"

if [ $# -eq 0 ]; then
	# there are no arguments (do a full upgrade)
	for ((i = 1; i < ${#lines[@]}; i++)); do
		echo ""

		line="${lines[$i]}"
		name=$(echo "$line" | cut -d',' -f1 | xargs)
		new=$(echo "$line" | cut -d',' -f2 | xargs)
		path=$(echo "$line" | cut -d',' -f3 | xargs)

		if [[ -z "$name" || -z "$new" || -z "$path" ]]; then
			continue
		fi

		INSTALL_DOTFILE "$name" "$new" "$path"
	done
else 
	# there are arguments
	for arg_name in "$@"; do
		echo ""

		for ((i = 1; i < ${#lines[@]}; i++)); do
			line="${lines[$i]}"
			name=$(echo "$line" | cut -d',' -f1 | xargs)
			new=$(echo "$line" | cut -d',' -f2 | xargs)
			path=$(echo "$line" | cut -d',' -f3 | xargs)

			if [[ -z "$name" || -z "$new" || -z "$path" ]]; then
				continue
			fi

			if [ "$arg_name" == "$name" ]; then 
				INSTALL_DOTFILE "$name" "$new" "$path"
				continue 2
			fi
		done
		echo "'$arg_name' does not exsist..."
	done
fi


