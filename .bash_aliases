PS1="\[\e[33m\]\u\[\e[m\]:\[\e[36m\]\w\[\e[m\]\\\$ $NEST(\j)${NOTE:+ $NOTE}\n  "
PATH=$PATH:$HOME/.local/bin
export PS1
export PATH
EDITOR=$(command -v hx || command -v lvim || command -v nvim || command -v vim || echo vi)
export EDITOR
[ -x /usr/bin/dircolors ] && [ -z "$LS_COLORS" ] && eval "$(dircolors -b)"
alias grep='grep --color=auto'
alias   ls='ls -FXx --color=auto'
alias    l='ls'
alias   la='ls -A'
alias   ll='ls -go'
alias   py=$(command -v python3 || python2)
alias  gti='git'
alias    s='git status'
alias  niw='env NEST="$NEST." $SHELL'
bind -x '"\ez":fg'
export HELIX_RUNTIME="$HOME/.config/helix/runtime/"
