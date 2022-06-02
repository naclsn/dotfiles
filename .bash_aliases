PS1="\[\e[33m\]\u\[\e[m\]:\[\e[36m\]\w\[\e[m\]\\\$ $NEST(\j)${NOTE:+ $NOTE}\n  "
PATH=$PATH:$HOME/.local/bin
export PS1
export PATH
EDITOR=$(command -v hx || command -v vim || echo vi)
export EDITOR
[ -x /usr/bin/dircolors ] && [ -z "$LS_COLORS" ] && eval "$(dircolors -b)"
alias grep='grep --color=auto'
alias   ls='ls -FXx --color=auto'
alias   la='ls -A'
alias   ll='ls -go'
alias    l='ls'
alias info='info --vi-keys'
alias   py=$(command -v python3 || echo python2)
alias maje='make'
alias  gti='git'
alias    s='git status'
alias  niw='env NEST="$NEST." $SHELL'
bind -x '"\ez":fg'
export HELIX_RUNTIME="$HOME/.config/helix/runtime/"
command_not_found_handle()(m="command not found: $1";k=0;while :;do paste -d\\n <(seq -f%.f%%7+31 $k $((k+${#m}))|bc) <(echo $m|fold -w1)|xargs -d\\n -L2 printf '\e[%dm%s';k=$((k+1));sleep .2;printf '\r';done)
