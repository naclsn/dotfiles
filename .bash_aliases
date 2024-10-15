PS1='\e[33m\u\e[m'$(printf %${SHLVL:-1}s |tr \  :)'\e[36m\w\e[m\$\n  '
HISTCONTROL=ignoreboth
HISTTIMEFORMAT=%T+

expath(){ [[ :$PATH: == *:$1:* ]]||export PATH=$1:$PATH;}
expath ~/.local/bin
expath ~/.cargo/bin
expath ~/.nimble/bin
expath ~/.npm-global/bin
expath ./node_modules/.bin

export        EDITOR=`command -v nvim || echo vim`
export          LESS='FiR --mouse --wheel-lines=3 --use-color'
export        MANOPT='--nj --nh'
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
alias          today="$EDITOR \"+cd ~/.local/share/today |cal map(glob('*.md',1,1),'execute(''bad ''.v:val)') |e "'`date +%Y-%m-%d`.md |se spell wrap"' # inspired by https://git.sr.ht/~sotirisp/today
alias             xo='xdg-open 2>/dev/null'

bind -x       '"\ez":fg&>/dev/null'
bind -x       '"\eZ":fg -&>/dev/null'
bind -x       '"\eq":r=`treest`;READLINE_LINE=${r:-$READLINE_LINE};READLINE_POINT=${#READLINE_LINE}'
bind -x       '"\ee":t=`mktemp --suffix=.bash`;echo "$READLINE_LINE">"$t";$EDITOR $t;READLINE_LINE=`cat $t`;rm $t;READLINE_POINT=${#READLINE_LINE}' # for some unknown reason, this is not a useless use of cat
bind -x       '"\ey":printf %s "$READLINE_LINE" |xclip -sel c'

[ -z "$LS_COLORS" ] && eval "$($(command -v dircolors) -b)"
[ -n "$DISPLAY" ] && command -v xrdb >/dev/null && xrdb -merge ~/.Xdefaults

# some functions {{{
command_not_found_handle(){ echo "$1: command not found">/dev/tty;stty sane -ixon 2>/dev/null;return 127;}
which_include()(n=$1;shift;find $(echo |${CC:-cpp} -v - `[ -n "$1" ]&&printf \ -I%s "$@"` |&awk '/^#include </{f=1;next};/^End/{f=0}f') -name "$n")
grep_macro()(n=$1;shift;printf '#include<%s>\n' "$@" |${CC:-cpp} -dM - |&grep "$n")
include_tree()(cpp -H "$@" 2>&1>/dev/null |grep --color=never '^\.\+ [^/]')
ccdo()(c=$1;shift;if [ -f "$c" ];then cc -x c "$c" -o /tmp/ccdo "$@";else cc -x c -<<<$c -o /tmp/ccdo "$@";fi&&/tmp/ccdo)
unset which # fedora

set -b
reset

ok() { # inspired by https://github.com/ErrorNoInternet/ok
  db=~/.cache/ok
  case ${1##*-} in
    h*) echo Usage: ok '[help|list|merge|reset|clear|show]' >&2;;
    l*) ${PAGER:-less} "$db";;
    m*) cat "$db" "$2" |sort -n >"$db";;
    r*|c*) rm -f "$db";;
    s*)
      touch "$db"
      echo OK count: `wc -l <"$db"`
      ;;
    *) echo `date +%s` "`history -p !-2`" >>"$db"; history -d -1;;
  esac
  unset db
}

spce () {
  PROJ=${PROJ:-~/Documents/Projects/}
  cd `[ -n "$1" ] && find "$PROJ" -maxdepth 1 -name "*$1*" -type d || echo "$PROJ"`
}
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
__jabs_run() {
    case $1 in
        *.c) echo ${1%.c} $2;;
        *) echo $1;;
    esac
}

__jabs() {
  jobs |while read spec status comm args
    do
      comm=${comm##*/}
      type -t __jabs_$comm >/dev/null && comm=`__jabs_$comm $args`
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
