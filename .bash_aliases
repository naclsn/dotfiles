#!/usr/bin/env bash
PPS1=$PS1
PS1="\[\e[33m\]\u\[\e[m\]:\[\e[36m\]\w\[\e[m\]\\\$ $(printf %${SHLVL}s|tr \  \()\j)\n  "
export          PATH=./node_modules/.bin:$HOME/.npm-global/bin:$HOME/.local/bin:$PATH # :/
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
alias         treest='treest --printer=fancy --rcfile='"'$HOME/.treestrc'"' -CdFIjwX'
alias           info='info --vi-keys'
alias             db='gdb -q --args'
alias             py='python3'
alias              s='git status'
alias          reset='stty sane -ixon'
alias         xargsa='xargs -d\\n -a'
bind -x       '"\ez":fg&>/dev/null;(exec&>/dev/null;(sleep .4;stty echo)&)'
bind -x       '"\ee":t=`mktemp --suffix=.bash`;echo "$READLINE_LINE">"$t";$EDITOR $t;READLINE_LINE=`<"$t"`;rm $t'
set -b
[ -z "$LS_COLORS" ] && eval "$($(command -v dircolors) -b)"
[ -n "$DISPLAY" ] && command -v xrdb >/dev/null && xrdb -merge "$HOME/.Xdefaults"
command_not_found_handle()(echo "$1": command not found>/dev/tty;exit 127) # TODO: make it useful
which_include()(gcc -v -E -</dev/null 2>&1|awk '/^#include </{f=1;next}/^End/{f=0}f'|xargs -I{} find {} -name "$1")
file_which()(file "$(which "$@")")
reset
