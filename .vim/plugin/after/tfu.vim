fu! Tfu(...)
  if empty(&tfu)
    exe 'se' ("tfu={t->[#{name:t,filename:'"..bufname()->fnamemodify(':p')->substitute("'", "''", 'g').."',cmd:('"..a:000->mapnew('"''..t..''\\m"->printf(v:val)')->join('\\|').."'->search('bn')??'')..''}]}")->escape(' \')
  en
endf

aug tfu
  au!

  au FileType bash,zsh,sh       cal Tfu('^\s*%s\s*()', '^\s*function\s\+%s', '^\s*%s=')
  au FileType python,python2    cal Tfu('^\s*def\s\+%s', '^\s*%s\s*=')
  au FileType vim               cal Tfu('^\s*fu\%%[nction]\s\+%s', '^\s*let\s\+\%%($\|[bgtvw]:\|\)%s', '^\s*fu\%%[nction].\{-}[(,]\s*%s')

aug END
