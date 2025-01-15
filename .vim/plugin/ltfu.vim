fu Ltfu(l)
  exe 'se' ("tfu={t->[#{name:t,filename:'"..bufname()->fnamemodify(':p')->substitute("'", "''", 'g').."',cmd:search('"..a:l->mapnew('"''..t..''\\m"->printf(v:val)')->join('\\|').."','bn')..''}]}")->escape(' \')
endf

let g:ltfu_known = #{
  \ sh:  ['^\s*%s\s*()', '^\s*function\s\+%s', '^\s*%s='],
  \ py:  ['^\s*def\s\+%s', '^\s*%s\s*='],
  \ vim: ['^\s*fu\%%[nction]\s\+%s', '^\s*let\s\+\%%($\|[bgtvw]:\|\)%s', '^\s*fu\%%[nction].\{-}[(,]\s*%s'],
  \}

com -nargs=1 Ltfu cal Ltfu(g:ltfu_known.<args>)
com -nargs=+ LtfuL cal Ltfu([<f-args>])

" vim: se fdm=marker fdl=0 ts=2:
