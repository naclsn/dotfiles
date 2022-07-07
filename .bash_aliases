PPS1=$PS1
export           PS1="\[\e[33m\]\u\[\e[m\]:\[\e[36m\]\w\[\e[m\]\\\$ $(printf %${SHLVL}s|tr \  \()\j)\n  "
export          PATH=$PATH:$HOME/.local/bin
export        EDITOR=$(command -v hx || command -v vim || echo vi)
export          LESS=FiJR
export HELIX_RUNTIME=$HOME/.local/share/helix/runtime
export PYTHONSTARTUP=$HOME/.pythonrc
alias           grep='grep --color=auto'
alias             ls='ls -FXx --color=auto'
alias             la='ls -A'
alias             ll='ls -go'
alias              l='ls'
alias           info='info --vi-keys'
alias             py='python3'
alias            gti='git'
alias              s='git status'
alias              x='chmod +x'
alias          reset='stty sane -ixon'
bind -x '"\ez":fg 2>/dev/null 1>&2'
[ -z "$LS_COLORS" ] && eval "$($(command -v dircolors))"
command_not_found_handle()(m="$1: command not found  ";while :;do printf %s\\r "$m";m=${m#?}${m%%${m#?}};sleep .2;done)
which_include()(gcc -v -E -</dev/null 2>&1|awk '/^#include </{f=1;next}/^End/{f=0}f'|xargs -L1 -I{} find {} -name "$1")
reset
