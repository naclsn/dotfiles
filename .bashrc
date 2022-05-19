_ifbe() (type -t "$1" && echo ${2:-1} || echo $3)
export PS1="\[\e[33m\]\u\[\e[m\]:\[\e[36m\]\w\[\e[m\]\\\$ (\j)\n  "
export EDITOR=$(_ifbe hx || _ifbe vim vim vi)
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
type -t python >/dev/null || alias python='python'
bind -x '"\ez":fg>/dev/null'
