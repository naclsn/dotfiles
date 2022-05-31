#!/usr/bin/env bash
bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh | tee ../install.sh)
cd .
mv ../lvim.old/config.lua ../install.sh .
chmod +x install.sh
sed -i -e163d ../../.local/share/lunarvim/lvim/lua/lvim/core/nvimtree.lua # TODO: remove when fixed
rm -ri ../lvim.old/
