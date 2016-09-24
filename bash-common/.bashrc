# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Load system default config
if [ -f /etc/bash.bashrc ]; then
    . /etc/bash.bashrc
fi

# Load modular config
if [ -d ${HOME}/.bashrc.d ]; then
    for file in ${HOME}/.bashrc.d/*; do
        source "$file";
    done
fi

PATH="$PATH:$HOME/bin"
export PATH

