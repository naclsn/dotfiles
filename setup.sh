#!/bin/sh
has() { c=`command -v $1` && printf "%-8s is %s\n" $1 $c || { echo no $1; exit 1; }; }
has find
has ln
has mkdir
has realpath
has rm
has readlink
echo ---

if [ %$1 = %-h ]
  then cat <<-'DOC'; exit
Usage:
  -h: help
  -l: list (implies -n, but does not create dirs)
  -n: nothing (may still create dirs)
  -f: force (rm -f existing ones)
  -o: only (next arg is a local file name/path)
  (none): setup
DOC
fi

find . -name .git -prune -o -type f -path ./.\* -printf '%h %p\n' |while read dir rel
  do
    rel=${rel#./}
    abs=`realpath $rel`

    if [ %$1 = %-l ]
      then
        if [ -e ~/$rel ]
          then
            case `readlink ~/$rel` in
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

    [ -d ~/$dir ] || mkdir -p ~/$dir
    [ %$1 = %-f ] && rm -f ~/$rel

    if ! [ -e ~/$rel ]
      then
        echo ln -s "$abs" ~/$rel
        [ %$1 = %-n ] || ln -s "$abs" ~/$rel
    fi
done
