# # ~/.bashrc #

# If not running interactively, don't do anything
[[ $- != *i* ]] && return



if [ "$XDG_SESSION_TYPE" == 'wayland' ]; then
	# lock
	alias lock='hyprlock -q'
elif [ "$XDG_SESSION_TYPE" == 'x11' ]; then
	# lock
	alias lock='i3lock'
	# repeat rate for keyboard
	xset r rate 150 50
fi




###############
#   ALIASES   #
###############

# TODO: put aliases in a different script?
# trash-cli
alias rm='trash-put --verbose'

# lockscreen 

# icat: for image display in the terminal
alias image='kitten icat'

# personal scripts 
alias schoolvpn='~/bin/schoolvpn.sh'

# neomutt
if [ "$USER" == 'jude' ]; then
	alias nm='mailsync && neomutt'
fi

##############
#   COLORS   #
##############

# ==============================
# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
	xterm-color|*-256color) color_prompt=yes;;
esac

if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	#alias dir='dir --color=auto'
	#alias vdir='vdir --color=auto'

	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

# ==============================
# Set a flag to force the color prompt, if desired
# if [ -n "$force_color_prompt" ]; then
# You can set this to 'yes' to always have a colored prompt
# or leave it commented out to rely on the terminal's capabilities.
# fi

if [ -t 1 ]; then
	# Check if the terminal supports color using tput
	if tput setaf 1 >&/dev/null; then
		color_prompt=yes
	else
		color_prompt=
	fi
fi

if [ "$color_prompt" = yes ]; then
	# Colored prompt: [user@host:working_directory]$
	PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
	# Plain prompt: user@host:working_directory$
	PS1='\u@\h:\w\$ '
fi

unset color_prompt


####################
#   AUTOCOMPLETE   #
####################

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
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
tmux -f "$TMUX_CONFIG_PATH" attach-session -t general || tmux -f "$TMUX_CONFIG_PATH" new-session -s general
clear # gets rid of the message that I am trying to nest my sessions, which I am not


#################
#   AUTOSTART   #
#################

clear
cal -3


