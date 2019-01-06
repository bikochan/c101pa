# Exports for shell config
export ANSIBLE_NOCOWS=1
export GOPATH=$HOME/go
export GPG_TTY=$(tty)
export HISTCONTROL=ignoredups
export HISTSIZE=5000
export HISTTIMEFORMAT="%F %T "

export PATH=$HOME/bin:/usr/local/go/bin:$PATH
export NPM_CONFIG_PREFIX=~/.npm-global

# Setup prompt
source ${HOME}/bin/bash_prompt.sh

# functions
function err() { printf "\e[31m${@}\e[0m" ; }
function ok()  { printf "\e[32m${@}\e[0m" ; }


if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi
