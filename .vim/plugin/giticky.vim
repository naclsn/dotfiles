
" git {{{1
fu s:Case(word)
  retu a:word->split()[0]->substitute('\v%(^|-)(\w)', '\u\1', 'g')
endf

fu s:ys_git_buflines(com, args)
  if [''] != getline(1, '$') |th 'not touching non-empty buffer' |en
  setl bh=wipe bt=nofile fdm=syntax nobl noswf
  let l:exp = a:args->expandcmd()
  exe 'f :Git'..s:Case(a:com) l:exp
  ev systemlist('git '..a:com..' '..l:exp)->setline(1)
endf

fu s:git_diff(args)
  setl ft=diff
  nn <buffer> zp :exe 'ped' search('^@@', 'bcnW')->getline()->matchstr('+\d\+') search('^---', 'bcnW')->getline()[6:]<CR>
endf

fu s:git_log_zp() abort
  let h = search('^commit ', 'bcnW')->getline()[7:]
  let b = bufadd('')
  cal bufload(b)
  exe 'pb' b
  cal win_execute(bufwinid(b), 'exe "GitShow" "'..h..'"')
endf
fu s:git_log(args)
  setl ft=git
  nn <buffer> <silent> zp :cal <SID>git_log_zp()<CR>
endf

fu s:git_show(args)
  if a:args =~ ':' |filet detect |el |setl ft=gitcommit |en
endf

" TODO: command name clash with GitL is annoying
"       -> rename to just GitTree or even GitFiles
fu s:git_ls_tree(args)
  nn <buffer> gf :GitShow <C-R>=@%->split()[-1]<CR>:<cfile><CR>
  nm <buffer> <C-W>f :sp<CR>gf
  nm <buffer> <C-W><C-F> :sp<CR>gf
endf

" TODO: just todo
"fu s:git_blame(rg)
"  setl nonu nornu pvw scb
"  winc 57<Bar>
"  winc w
"  setl scb
"endf

for n in ['diff', 'log', 'show'] ", 'ls-tree -r --name-only']
  exe 'com! -nargs=* -complete=file Git'..s:Case(n)
    \ 'ene |'
    \ 'cal s:ys_git_buflines("'..n..'", <q-args>) |'
    \ 'cal s:git_'..n->split()[0]->substitute('-', '_', 'g')..'(<q-args>)'
endfo
unl n

" vim: se ts=2:
