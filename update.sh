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

# Read the CSV into an array using mapfile
mapfile -t lines < "$CSV_PATH"

# Process each line after the header (skip the first line)
for ((i = 1; i < ${#lines[@]}; i++)); do
    # Read each line and split by comma
    line="${lines[$i]}"
    name=$(echo "$line" | cut -d',' -f1 | xargs)
    new=$(echo "$line" | cut -d',' -f2 | xargs)
    path=$(echo "$line" | cut -d',' -f3 | xargs)

    # Skip empty lines
    if [[ -z "$name" || -z "$new" || -z "$path" ]]; then
        continue
    fi

    # Debug: Print the line read from CSV
    echo "Reading: $name, $new, $path"  # Debug: Show CSV line

    # Now process the remaining lines
    INSTALL_DOTFILE "$name" "$new" "$path"
done

