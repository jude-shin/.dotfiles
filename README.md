# .dotfiles

Arch Linux on **Hyprland** (wayland) and **i3** (x11)

## How To Use (for future self)
if you are just setting up, then you have to make a bunch of symlinks in the .config folder or wherever you are sourcing. 
you are basically going to point all of your system's dotfiles to this git repo

ln -s "$HOME/.dotfiles/i3/" "$HOME/.config/i3"
ln -s "$SRC" "$DST"

## TODO:
make something for an ubuntu server (for lambda labs and for trent)

## NOTE:
#### **Vim:**
- you may need to build the vim-plug from the rc afterwards
- yay -S vim-plug
