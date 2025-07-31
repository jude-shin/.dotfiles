# # ~/.bashrc #

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


###############
#   ALIASES   #
###############
# TODO: put this in a different script?
# common tools
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# trash-cli
alias rm='trash-put --verbose'

# lockscreen 
if [ "$XDG_SESSION_TYPE" == 'wayland' ]; then
	alias lock='hyprlock -q'
elif [ "$XDG_SESSION_TYPE" == 'x11' ]; then
	alias lock='i3lock'
fi

# icat
# for image display in the terminal
alias image='kitten icat'

# PERSONAL SCRIPTS 
alias schoolvpn='~/bin/schoolvpn.sh'

# neomutt
if [ "$USER" == 'jude' ]; then
	alias nm='mailsync && neomutt'
fi

########################
#   ENVIRONMENT VARS   #
########################
export $(envsubst < ~/.env)
export HISTCONTROL=ignoreboth:erasedups
export HISTFILESIZE=10000
export HISTSIZE=10000

PS1='[\u@\h \W]\$ '
source /usr/share/nvm/init-nvm.sh


###########
#   fzf   #
###########
eval "$(fzf --bash)"

############
#   tmux   #
############
TMUX_CONF_NAME='base.conf'

if [ "$USER" == 'jude' ]; then
	TMUX_CONF_NAME='jude.conf'
elif [ "$USER" == 'storepass' ]; then
	TMUX_CONF_NAME='storepass.conf'
fi

TMUX_CONFIG_PATH="$XDG_CONFIG_HOME/tmux/$TMUX_CONF_NAME"
tmux -f "$TMUX_CONFIG_PATH" attach-session -t general|| tmux -f "$TMUX_CONFIG_PATH" new-session -s general


#################
#   AUTOSTART   #
#################
# clear
# cal -3


