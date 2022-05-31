export PS1="\[\e[33m\]\u\[\e[m\]:\[\e[36m\]\w\[\e[m\]\\\$ (\j)\n  "
export EDITOR=$(command -v hx || command -v nvim || command -v vim || echo vi)
export HELIX_RUNTIME="$HOME/.config/helix/runtime/"
if [ -x /usr/bin/dircolors ]
  then
    eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
fi
alias l='ls -CF'
alias la='ls -A'
alias cd..='cd ..'
alias py='python3'
alias gti='git'
alias s='git status'
type -t python >/dev/null || alias python='python2'
bind -x '"\ez":fg'
