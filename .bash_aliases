PS1="\[\e[33m\]\u\[\e[m\]:\[\e[36m\]\w\[\e[m\]\\\$ $(printf %${SHLVL}s|tr \  \()\j)\n  "
PATH=$PATH:$HOME/.local/bin:$HOME/otawa/bin
export PS1
export PATH
EDITOR=$(command -v hx || command -v vim || echo vi)
export EDITOR
[ -z "$LS_COLORS" ] && eval "$($(command -v dircolors))"
alias  grep='grep --color=auto'
alias    ls='ls -FXx --color=auto'
alias    la='ls -A'
alias    ll='ls -go'
alias     l='ls'
alias  info='info --vi-keys'
alias    py="$(command -v python3 || echo python2)"
alias  maje='make'
alias   gti='git'
alias     s='git status'
alias reset='stty sane -ixon'
bind -x '"\ez":fg'
export HELIX_RUNTIME="$HOME/.config/helix/runtime/"
command_not_found_handle()(m="$1: command not found";k=0;while :;do paste -d\\n <(seq -f%.f%%7+31 $k $((k+${#m}))|bc) <(echo $m|fold -w1)|xargs -d\\n -L2 printf '\e[%dm%s';k=$((k+1));sleep .2;printf '\r';done)
which_include()(gcc -v -E - </dev/null 2>&1|awk '/^#include </{f=1;next}/^End/{f=0}f'|xargs -L1 -I{} find '{}' -name $1)
reset
