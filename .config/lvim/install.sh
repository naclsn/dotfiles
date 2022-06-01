#!/usr/bin/env bash
bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh | tee ../install.sh)
cd .
mv ../lvim.old/config.lua ../install.sh .
chmod +x install.sh
read -p 'TODO: remove next line when fixed (waiting)'
sed -i -e163d ../../.local/share/lunarvim/lvim/lua/lvim/core/nvimtree.lua
rm -ri ../lvim.old/
