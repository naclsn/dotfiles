#!/bin/sh
cd "${0%/*}"
has() { c=`command -v $1` && printf "%-8s is %s\n" $1 $c || { echo no $1; exit 1; }; }
has find
has ln
has mkdir
has readlink
has realpath
has rm
echo ---

if [ %$1 = %-h ]
  then cat <<-'DOC'; exit 1
Usage: one of
  -h: help
  -l: list
  -n: nothing
  -f: force (rm -f existing ones)
  -o: only (next arg is a local file)
  (one arg): same as only
  (none): setup all
DOC
fi
[ 1 -eq $# ] && [ ${1#-} = $1 ] && set -- -o $1
[ %$1 = %-o ] && if [ -f $2 ]
  then
    abs=`command realpath $2`
    set -- -o ${abs#`command realpath $PWD`/}
  else
    echo no such file $2
    exit 1
fi

command find . -name .git -prune -o -type f -path ./.\* -printf '%h %p\n' |while read dir rel
  do
    rel=${rel#./}
    abs=`command realpath $rel`

    if [ %$1 = %-l ]
      then
        if [ -e ~/$rel ]
          then
            case `command readlink ~/$rel` in
              '') msg=unlinked;;
              $abs) msg=linked;;
              *) msg=other;;
            esac
          else msg=missing
        fi
        printf '%-20s\t%s\n' $rel $msg
        continue
    fi

    [ %$1 = %-o ] && ! [ $rel = $2 ] && continue

    [ %$1 = %-n ] || [ -d ~/$dir ] || command mkdir -p ~/$dir
    [ %$1 = %-f ] && command rm -f ~/$rel

    if [ -e ~/$rel ]
      then
        [ %$1 = %-o ] && echo file exists $2
      else
        echo ln -s "$abs" ~/$rel
        [ %$1 = %-n ] || command ln -s "$abs" ~/$rel
    fi
done
