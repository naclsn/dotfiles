export           PS1="\[\e[33m\]\u\[\e[m\]:\[\e[36m\]\w\[\e[m\]\\\$ $(printf %${SHLVL}s|tr \  \()\j)\n  "
export          PATH=$PATH:$HOME/.local/bin
export        EDITOR=hx-envi
export          LESS=FiJR
export HELIX_RUNTIME=$HOME/.local/share/helix/runtime
export PYTHONSTARTUP=$HOME/.pythonrc
alias           grep='grep --color=auto'
alias             ls='ls -FXx --color=auto'
alias             la='ls -A'
alias             ll='ls -go'
alias              l='ls'
alias           tree='tree --dirsfirst'
alias           info='info --vi-keys'
alias             py='python3'
alias            gti='git'
alias              s='git status'
alias              x='chmod +x'
alias          reset='stty sane -ixon'
bind -x '"\ez":fg 2>/dev/null 1>&2'
[ -z "$LS_COLORS" ] && eval "$($(command -v dircolors) -b)"
[ -n "$DISPLAY" ] && command -v xrdb >/dev/null && xrdb -merge "$HOME/.Xdefaults"
command_not_found_handle()(m="$1: command not found  ";while :;do printf %s\\r "$m";m=${m#?}${m%%${m#?}};sleep .2;done)
which_include()(gcc -v -E -</dev/null 2>&1|awk '/^#include </{f=1;next}/^End/{f=0}f'|xargs -L1 -I{} find {} -name "$1")
reset
tmux_ws() (
  # Usage: [path] [--] [new-session args] ; path cannot start with a -
  set -x
  if [ -z "${1%%-*}" ]
    then path=$( (
        tmux list-sessions -F '#{session_name}'
        find ~/otawa/src -mindepth 1 -maxdepth 1 -type d
      ) | dmenu)
    else path="$1"; shift
  fi
  if [ -n "$path" ]
    then
      path=$(realpath "$path")
      name=$(basename "$path")
      #tmux new-session -As "$name" -c "$path" -e TMUX_PWD="$path" $*
      id=$(tmux new-session -PF '#{session_id}' -ds "$name" -c "$path" $*)
      tmux set-environment -t "$id" TMUX_PWD "$path"
      tmux attach-session -t "$id"
  fi
) # FIXME: (still) ^Z
