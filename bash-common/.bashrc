# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Load modular config
if [ -d ${HOME}/.bashrc.d ]; then
    for file in ${HOME}/.bashrc.d/*; do
        source "$file";
    done
fi

. /usr/share/git/completion/git-prompt.sh
. /usr/share/bash-completion/completions/ssh

# Aliases
alias ll="ls -lh"
alias la="ls -a"
alias ls='ls --color=auto'
alias e="gvim --remote-silent"

# Functions
x11vncon()
{
    ssh $* -C -t -L 5900:localhost:5900 'sudo x11vnc -display :0.0 -forever'
}

# Completion
complete -F _ssh x11vncon

# Prompt
RESET='\[\033[00m\]'
GREEN='\[\033[32m\]'
BLUE='\[\033[34m\]'
RED='\[\033[33m\]'
GIT_BRANCH='$(__git_ps1 "[git: %s]")'
MC=''
RANGER=''
if [ "${MC_SID:-x}" != x ] ; then
    MC='mc:'
fi
if [ "${RANGER_LEVEL:-x}" != x ] ; then
    RANGER='ranger:'
fi
PS1="${GREEN}[${MC}${RANGER}\w]$RED${GIT_BRANCH}\n${BLUE}[\u@\h]${RESET}$ "

if [ ${TERM} == "xterm" ] ;then
    export TERM=xterm-256color
fi

if [ ${TERM} == "screen" ] && [ ${DISPLAY} ] ;then
    export TERM=screen-256color
fi

# autostrt tmux on ssh login
if [ "$PS1" != "" -a "${SSH_TMUX_SESSION:-x}" = x -a "${SSH_TTY:-x}" != x ]
then
        export SSH_TMUX_SESSION=1
        sleep 1
        ( (tmux has-session -t remote && tmux attach-session -t remote) || (tmux new-session -s remote) ) && exit 0
        echo "tmux failed to start"
fi

