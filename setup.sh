#!/bin/sh
has() { c=`command -v $1` && echo $1 is $c || { echo no $1; exit; }; }
has rm
has mkdir
has ln
has find
has realpath
c=$1-
if [ "$c" = -h- ]
  then cat <<-'DOC'; exit
Usage:
  -h: help
  -l: list (implies -n, but does not create dirs)
  -n: nothing (may still create dirs)
  -f: force (rm -f existing ones)
  (none): setup
DOC
fi
ln() { echo ln "$@"; [ "$c" = -n- ] || command ln "$@"; }
find . -type f -path ./.\* -printf '%h %p\n' -o -name .git -prune | while read dir rel
  do
    [ "$c" = -l- ] && { echo ${rel#./}; continue; }
    [ -d ~/$dir ] || mkdir -p ~/$dir
    [ "$c" = -f- ] && rm -f ~/$rel
    [ -e ~/$rel ] || ln -s "$(realpath $rel)" ~/$rel
done
