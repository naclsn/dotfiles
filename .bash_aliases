# PS1="\[\e[33m\]\u\[\e[m\]:\[\e[36m\]\w\[\e[m\]\\\$ $(printf %${SHLVL}s|tr \  \()\j)\n  "
PS1='\e[33m\u\e[m:\e[36m\w\e[m\$\n  '

expath(){ [[ :$PATH: == *:$1:* ]]||export PATH=$1:$PATH;}
expath ~/.local/bin
expath ~/.cargo/bin
expath ~/.npm-global/bin
expath ./node_modules/.bin

export        EDITOR=hx
export          LESS='FiR --mouse --wheel-lines=3'
export PYTHONSTARTUP=~/.pythonrc
export     NODE_PATH=~/.npm-global/lib/node_modules

alias           grep='grep --color=auto'
alias             ls='ls --color=auto'
alias             la='ls -FXxA'
alias             ll='ls -FXgo'
alias              l='ls -FXx'
alias           tree='tree --dirsfirst'
alias            tre='treest'
alias           info='info --vi-keys'
alias             db='gdb -q --args'
alias             py='python3'
alias              s='git status'
alias          reset='stty sane -ixon'
alias         xargsa='xargs -d\\n -a'
alias         xclipp='xclip -sel c'
alias             ff='firefox'

# (2 lines) obsoleted by jabs, may remove
bind -x       '"\ez":fg&>/dev/null'
bind -x       '"\eZ":fg -&>/dev/null'
bind -x       '"\eq":r=`treest`;READLINE_LINE=${r:-$READLINE_LINE};READLINE_POINT=${#READLINE_LINE}'
bind -x       '"\ee":t=`mktemp --suffix=.bash`;echo "$READLINE_LINE">"$t";$EDITOR $t;READLINE_LINE=`cat $t`;rm $t;READLINE_POINT=${#READLINE_LINE}' # for some unknown reason, this is not a useless use of cat
bind -x       '"\ey":printf %s "$READLINE_LINE" | xclip -sel c'

[ -z "$LS_COLORS" ] && eval "$($(command -v dircolors) -b)"
[ -n "$DISPLAY" ] && command -v xrdb >/dev/null && xrdb -merge ~/.Xdefaults

command_not_found_handle(){ echo "$1: command not found">/dev/tty;stty sane -ixon 2>/dev/null;return 127;}
which_include()(find `gcc -v -E -</dev/null 2>&1|awk '/^#include </{f=1;next}/^End/{f=0}f'` -name "$1")
fwhich()(file "$(which "$@")")
unset which # fedora

set -b
reset

ok() { # inspired by https://github.com/ErrorNoInternet/ok 
  db=~/.cache/ok
  case ${1##*-} in
    h*) echo Usage: ok >&2;;
    l*) ${PAGER:-less} "$db";;
    m*) cat "$db" "$2" | sort -n >"$db";;
    r*|c*) rm -f "$db";;
    s*)
      touch "$db"
      echo OK count: `wc -l <"$db"`
      ;;
    *) echo `date +%s` "`history -p !-2`" >>"$db"; history -d -1;;
  esac
  unset db
}

# jobs tabs (jabs)
bind -x       '"\e0":fg&>/dev/null'
bind -x       '"\e-":fg -&>/dev/null'
for n in {1..9}
  do bind -x  '"\e'$n'":fg %'$n'>/dev/null'
done

__jabs_git() { echo git-$1; }
__jabs_man() {
  if [ 2 == $# ]
    then echo "$2($1)"
    else echo "$1(.)"
  fi
}
__jabs_less() { echo ${1##*/}; }

__jabs() {
  jobs | while read spec status comm args
    do
      type -t __jabs_${comm##*/} >/dev/null && comm=`__jabs_${comm##*/} $args`
      case ${spec:3:1} in
        +) col=32;;
        -) col=34;;
        *) col=0;;
      esac
      printf '\b\e[%dm[%d %s]\e[m ' $col ${spec:1:1} $comm
  done
}

PS1='$(__jabs)'$PS1
