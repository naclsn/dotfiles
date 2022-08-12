#!/usr/bin/env bash
PPS1=$PS1
PS1="\[\e[33m\]\u\[\e[m\]:\[\e[36m\]\w\[\e[m\]\\\$ $(printf %${SHLVL}s|tr \  \()\j)\n  "
export          PATH=$PATH:$HOME/.local/bin
export        EDITOR=hx
export          LESS='FiR --mouse --wheel-lines=3'
export HELIX_RUNTIME=$HOME/.local/share/helix/runtime
export PYTHONSTARTUP=$HOME/.pythonrc
alias           grep='grep --color=auto'
alias             ls='ls --color=auto'
alias             la='ls -FXxA'
alias             ll='ls -FXgo'
alias              l='ls -FXx'
alias           tree='tree --dirsfirst'
alias         treest='treest --printer=fancy -FXcdj'
alias           info='info --vi-keys'
alias             db='gdb -q --args'
alias             py='python3'
alias              s='git status'
alias          reset='stty sane -ixon'
bind -x       '"\ez":fg&>/dev/null'
set -b
[ -z "$LS_COLORS" ] && eval "$($(command -v dircolors) -b)"
[ -n "$DISPLAY" ] && command -v xrdb >/dev/null && xrdb -merge "$HOME/.Xdefaults"
# TODO: make it useful
#command_not_found_handle()(set -e;tty>/dev/null;echo "$1": command not found)
which_include()(gcc -v -E -</dev/null 2>&1|awk '/^#include </{f=1;next}/^End/{f=0}f'|xargs -I{} find {} -name "$1")
file_which()(file "$(which "$@")")
reset
