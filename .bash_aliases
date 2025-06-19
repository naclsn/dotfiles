PS1='\e]2;${PWD##*/}\e\\\e[33m\u\e[m'$(printf %${SHLVL:-1}s |tr \  :)'\e[36m\w\e[m\$\n  '
HISTCONTROL=ignoreboth
HISTTIMEFORMAT=%T+

[ -z "$LS_COLORS" ] && eval "$($(command -v dircolors) -b)"
[ -n "$DISPLAY" ] && command -v xrdb >/dev/null && xrdb -merge ~/.Xdefaults
command_not_found_handle(){ echo "$0: $1: command not found">/dev/tty;stty sane -ixon 2>/dev/null;return 127;}

expath(){ [[ :$PATH: == *:$1:* ]]||export PATH=$1:$PATH;}
unpath(){ export PATH=${PATH/${1//\//\\\/}:/};}
expath ~/.local/bin
expath ~/.cargo/bin
expath ~/.go/bin
expath ~/.nimble/bin
expath ~/.npm-global/bin
expath ./node_modules/.bin

export        EDITOR=`command -v nvim || echo vim`
export          LESS='FR --mouse --wheel-lines=3 --use-color'
export        MANOPT='--nj --nh'
export  SYSTEMD_LESS=$LESS
export PYTHONSTARTUP=~/.pythonrc
export     NODE_PATH=~/.npm-global/lib/node_modules

here=`readlink ~/.bash_aliases`
[ -d "${here%/*}/../mopfiles/lib" ] && export PYTHONPATH="${here%/*}/../mopfiles/lib"
unset here

alias           grep='grep --color=auto'
alias             ls='ls --color=auto'
alias              l='ls -FX'
alias             la='l -A'
alias             ll='l -go'
alias             db='gdb -q --args'
alias             py='python3'
alias              s='git status'
alias          reset='stty sane -ixon'
alias         xclipp='xclip -sel c'
alias             xo='xdg-open 2>/dev/null'
alias        println='printf %s\\n'

bind -x       '"\ez":fg&>/dev/null'
bind -x       '"\eZ":fg -&>/dev/null'
bind -x       '"\eq":treest'
bind -x       '"\ee":t=`mktemp --suffix=.bash`;echo "$READLINE_LINE">"$t";$EDITOR $t;READLINE_LINE=`cat $t`;rm $t;READLINE_POINT=${#READLINE_LINE}' # for some unknown reason, this is not a useless use of cat
bind -x       '"\ey":printf %s "$READLINE_LINE" |xclip -sel c'

set -b
stty sane -ixon

# small c helpers (todo: put somewhere else) {{{
which_include()(n=$1;shift;find $(echo |${CC:-cpp} -v - `[ -n "$1" ]&&printf \ -I%s "$@"` |&awk '/^#include </{f=1;next};/^End/{f=0}f') -name "$n")
grep_macro()(n=$1;shift;printf '#include<%s>\n' "$@" |${CC:-cpp} -dM - |&grep "$n")
include_tree()(cpp -H "$@" 2>&1>/dev/null |grep --color=never '^\.\+ [^/]')
ccdo()(c=$1;shift;if [ -f "$c" ];then cc -x c "$c" -o /tmp/ccdo "$@";else cc -x c -<<<$c -o /tmp/ccdo "$@";fi&&/tmp/ccdo)
# }}}

# spaces (spce) {{{
SPCE_PROJ=${SPCE_PROJ:-~/Documents/Projects}
spce() {
  [ -n "$1" ] && set -- $SPCE_PROJ/*${1%/}*/
  case $# in
    0) cd $SPCE_PROJ;;
    1) cd $1;;
    *) select c; do cd $c; break; done;;
  esac
}
__spce() {
  local full=($SPCE_PROJ/*/)
  COMPREPLY=(`compgen -W "${full[*]#$SPCE_PROJ/}" -- $2`)
} && complete -F __spce spce
# }}}

# jobs tabs (jabs) {{{
bind -x       '"\e0":fg&>/dev/null'
bind -x       '"\e-":fg -&>/dev/null'
for n in {1..9}
  do bind -x  '"\e'$n'":fg %'$n'&>/dev/null'
done

__jabs_git() { echo git-$1; }
__jabs_man() {
  if [ 2 = $# ]
    then echo "$2($1)"
    else echo "$1`man -k ^$1\$ 2>/dev/null |awk '{printf$2}' |sed 's/)(/,/g' || echo '(man)'`"
  fi
}
__jabs_less() { echo ${1##*/}; }
__jabs_daety() {
  # TODO: could discard daety-opts, try to use -i/-a/-C, etc..
  printf ^
  if type -t __jabs_${1##*/} >/dev/null
    then __jabs_${1##*/} "$*"
    else echo $1
  fi
}
__jabs_tmux() {
  # TODO: maybe, idk
  echo tmux
}
__jabs_run() {
  case $1 in
    *.c) echo ${1%.c} $2;;
    *) echo $1;;
  esac
}
__jabs_poetry() {
  printf %s\  poy-$1
  case $1 in
    run) echo $2;;
    *) ;;
  esac
}
__jabs_python() {
  case $1 in
    -m) shift; __jabsC "$@";;
    *) echo python;;
  esac
}
__jabs_python3() {
  __jabs_python "$@";
}

__jabsC() {
  if type -t __jabs_$1 >/dev/null
    then __jabs_$1 "${@:2}"
    else echo $1
  fi
}
__jabs() {
  jobs |while read spec status comm args
    do
      comm=`__jabsC ${comm##*/} $args`
      case ${spec:3:1} in
        +) col=32;;
        -) col=34;;
        *) col=0;;
      esac
      printf '\e[%dm[%d %s]\e[m' $col ${spec:1:1} "$comm"
  done
}

PS1='$(__jabs)'$PS1
# }}}

# vim: se fdm=marker fdl=0 ts=2:
