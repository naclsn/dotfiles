" Few usufull git commands.
"
" It all just boils down to the |Giticky()| which invokes `git`
" and pumps out the result into a buffer (args given to a command
" are forwarded):
"   |:GitDiff| is `git diff`
"   |:GitLog|     `git log`
"   |:GitShow|    `git show`  understands '<commit>:<file>' arg syntax
"   |:GitBlame|   `git blame`  default if no arg: current buffer's name
"   |:GitFiles|   `git ls-tree -r --name-only`  default arg: 'HEAD'
"
" Note That:! all buffers are marked "bh=wipe" 'bh'
" Also |Giticky()| expands the argument in the context of the new buffer.
"
" Last Change:	2025 Apr 27
" Maintainer:	a b <a.b@c.d>
" License:	This file is placed in the public domain.
"
"  Just, know what you're using and doing-

fu Giticky(name, args, com=a:name, dargs='') abort
  if [''] != getline(1, '$') |th 'not touching non-empty buffer' |en
  setl bh=wipe bt=nofile fdm=syntax nobl noswf
  let exargs = (a:args ?? a:dargs)->expandcmd()
  exe 'f :Git'..toupper(a:name[0])..a:name[1:] exargs
  ev systemlist('git '..a:com..' '..exargs)->setline(1)
  setl ro
  cal call('s:git_'..a:name, [exargs])
endf

fu s:git_diff(args)
  setl ft=diff
  nn <buffer> zp :exe 'ped' search('^@@', 'bcnW')->getline()->matchstr('+\d\+') search('^---', 'bcnW')->getline()[6:]<CR>
endf

fu s:git_log(args)
  setl ft=git
  nn <buffer> <silent> zp :cal <SID>git_log_zp()<CR>
  endf
  fu s:git_log_zp() abort
    let h = search('^commit ', 'bcnW')->getline()[7:]
    let b = bufadd('')
    cal bufload(b)
    exe 'pb' b
    cal win_execute(bufwinid(b), 'exe "GitShow" "'..h..'"')
endf

fu s:git_show(args)
  if a:args =~ ':' |filet detect |el |setl ft=gitcommit |en
endf

fu s:git_files(args)
  nn <buffer> gf :GitShow <C-R>=@%->split()[-1]<CR>:<cfile><CR>
  nm <buffer> <C-W>f :sp<CR>gf
  nm <buffer> <C-W><C-F> :sp<CR>gf
endf

fu s:git_blame(rg)
  setl nonu nornu pvw
  vert winc ^
    setl crb scb sbo-=jump
    let ln = line('.')
    let id = win_getid()
  winc p
    exe ln
    setl crb scb sbo-=jump
    exe 'au BufWinLeave <buffer> ++once cal win_execute('..id..', "setl nocrb noscb sbo&")'
  winc p
  sync
endf

for [name, com, dargs] in
  \ [ ['diff', 'diff', '']
  \ , ['log', 'log', '']
  \ , ['show', 'show', '']
  \ , ['blame', 'blame', '#']
  \ , ['files', 'ls-tree -r --name-only', 'HEAD']
  \ ]
  exe 'com! -bar -nargs=* -complete=file Git'..toupper(name[0])..name[1:]
    \ 'ene |cal Giticky("'..name..'", <q-args>, "'..com..'", "'..dargs..'")'
endfo
unl name com dargs

" vim: se ts=2:
