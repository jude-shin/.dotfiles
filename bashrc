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

# git
alias gd='git diff'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gu='git pull'
alias gl='git log'
alias gb='git branch'
alias gi='git init'

# neomutt
alias nm='mailsync && neomutt'

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
    tmux attach-session -t general || tmux new-session -s general 
fi

clear
cal -3


