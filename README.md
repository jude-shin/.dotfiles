# .dotfiles

Arch Linux on Hyprland (i3 fallback)

## How To Use (for future self)
if you are just setting up, then you have to make a bunch of symlinks in the .config folder or wherever you are sourcing. 
you are basically going to point all of your system's dotfiles to this git repo

ln -s "$HOME/.dotfiles/i3/" "$HOME/.config/i3"


## NOTE:
#### **Hyprpaper:** 
- may need some pictures to be updated
- TODO: make a folder with the pictures that are locally stored on this repo

#### **Vim:**
- you may need to build the vim-plug from the rc afterwards
- yay -S vim-plug

## Dependencies:
    bash, hyprland, hyprlock, hyprpaper, kitty, tmux, vim, vim-plug, waybar, wofi, i3
