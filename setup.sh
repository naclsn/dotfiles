#!/bin/sh
c=$1-
if [ "$c" = -h- ]
  then cat <<-'DOC'; exit
Usage:
  -h: help
  -l: list
  -n: nothing
  -f: force
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
