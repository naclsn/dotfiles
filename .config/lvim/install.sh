#!/usr/bin/env bash
bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh | tee "$0")
cp ../lvim.old/config.lua .
rm -ri ../lvim.old/
