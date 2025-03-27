#!bin/bash

# $XDG_CONFIG_HOME
# $HOME
NEW_PATH="./dotfiles"
CSV_PATH="./paths.csv"

# if there are command line arguments, then go through each of those in a for loop
if [$# -eq 0]; then 
	for name_arg in "$@"
	do
		# find the line in the csv with that name
	tail -n +2 "$CSV_PATH" | while IFS=',' read -r name new path 
		do
    	if [[ "$name" == "$name_arg" ]]; then
				# you have found the line, then you can process this download
				install_dotfile $name $new $path
				break
    	fi
		done 
	done
# else, there are no command line arguments, go through all of the items in the csv, and run the script
else 
# Skip the header line
	tail -n +2 "$CSV_PATH" | while IFS=',' read -r name new path 
	do
		install_dotfile $name $new $path
	done 
fi





install_dotfile() {
	# args: name, new, path
	local name=$1
	local new=$2
	local path=$3
	confirm_install $name $new $path

	if [$? = 0]; then
		# the user canceled this install, and you should skip it
		echo "SKIPPING $name dotfile..."
	elif [$? = 1]; then
		# the user wants to install this, so go ahead and install it
		echo "INSTALLING new $name dotfile..."
	fi
}

confirm_install() {
	# args: name, new, path
	local name=$1
	local new=$2
	local path=$3
	
	echo "Do you want to install the $name dotfile?" 
	read -p "WARNING, may overwrite files! (y/n): " response 

	if [$response -eq "y"]; then
		return 1
	elif [$response -eq "n"]; then
		return 0
	else
		echo "Please enter 'y' or 'n' as a response"
		confirm_install $name $new $path
		return $?
	fi
}

















