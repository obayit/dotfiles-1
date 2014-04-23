# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Load modular config
if [ -d ${HOME}/.bashrc.d ]; then
    for file in ${HOME}/.bashrc.d/*; do
        source "$file";
    done
fi

. /usr/share/bash-completion/completions/ssh

alias e="gvim --remote-silent"

# Functions
x11vncon()
{
    ssh $* -C -t -L 5900:localhost:5900 'sudo x11vnc -display :0.0 -forever'
}

# Completion
complete -F _ssh x11vncon

