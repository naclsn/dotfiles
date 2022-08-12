#!/bin/sh
find . -type f -path ./.\* -printf '%h %p\n' -o -name .git -prune | while read dir rel
  do
    [ -d ~/$dir ] || mkdir -p ~/$dir
    [ -f = "$1" ] && rm -f ~/$rel
    [ -e ~/$rel ] || ln -s $(realpath $rel) ~/$rel
done
