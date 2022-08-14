#!/bin/sh
c=$1
# -l: list
# -n: nothing
# -f: force
ln() { echo ln "$@"; [ -n = "$c" ] || command ln "$@"; }
find . -type f -path ./.\* -printf '%h %p\n' -o -name .git -prune | while read dir rel
  do
    [ -l = "$c" ] && { echo ${rel#./}; continue; }
    [ -d ~/$dir ] || mkdir -p ~/$dir
    [ -f = "$c" ] && rm -f ~/$rel
    [ -e ~/$rel ] || ln -s "$(realpath $rel)" ~/$rel
done
