#!/bin/sh
has() { c=`command -v $1` && echo $1 is $c || { echo no $1; exit; }; }
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
  (none): setup
DOC
fi

find . -type f -path ./.\* -printf '%h %p\n' -o -name .git -prune | while read dir rel
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
        printf '%s\t%s\n' $rel $msg
        continue
    fi

    [ -d ~/$dir ] || mkdir -p ~/$dir
    [ %$1 = %-f ] && rm -f ~/$rel

    if ! [ -e ~/$rel ]
      then
        echo ln -s "$abs" ~/$rel
        [ %$1 = %-n ] || ln -s "$abs" ~/$rel
    fi
done
