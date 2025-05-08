#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


#################
#### ALIASES ####
#################
# common tools
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# trash-cli
alias rm='trash-put --verbose'
alias restore='trash-restore --verbose'

# hyprlock
alias lock='hyprlock -q'

# icat
# for image display in the terminal
alias image='kitten icat'

# PERSONAL SCRIPTS 
alias super='~/bin/super.sh'
# alias run='~/bin/run.sh'
alias schoolvpn='~/bin/schoolvpn.sh'

##########################
#### ENVIRONMENT VARS ####
##########################
export $(envsubst < ~/.env)
export HISTCONTROL=ignoreboth:erasedups
export HISTFILESIZE=10000
export HISTSIZE=10000

PS1='[\u@\h \W]\$ '
source /usr/share/nvm/init-nvm.sh

# fzf 
eval "$(fzf --bash)"

###################
#### AUTOSTART ####
###################

if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux attach-session -t term || tmux new-session -s term 
fi

clear
cal -3


