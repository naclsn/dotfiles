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
"   |:GitGrep|    `git grep -rn` default arg: `-w <cword>`
"
" GitShow has a more complex default with `=
"   - <cword> if in a GitB buffer
"   - <hash>~:<cfile> if in a GitD buffer and <cfile> starts with a/ or b/ (and were <hash> is taken from getline(1))
"   - otherwise empty
"
" TODO: wanna enabled somethin like:
"   GitB      -> pvw with blame
"   GitS ~    -> GitS in original window with <prior-rev>:<file>
"   GitB      -> (update) pvw with blame from rev (back)onward
"   GitS ~    -> ...
"
" Last Change:	2025 Jul 04
" Maintainer:	a b <a.b@c.d>
" License:	This file is placed in the public domain.
"
"  Just, know what you're using and doing-

fu Giticky(name, args, com=a:name, dargs='', new=':')
  " expand in current context (before ene or such)
  let exargs = (a:args ?? a:dargs)->expandcmd()
  " expect it to be eg. |:ene| or such
  exe a:new
  if [''] != getline(1, '$') |th 'not touching non-empty buffer' |en
  setl bt=nofile fdm=syntax nobl noswf
  "try
    exe 'f :Git'..toupper(a:name[0])..a:name[1:] exargs
  "cat /E95/
    "exe 'b :Git'..toupper(a:name[0])..a:name[1:] exargs
  "endt
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
  if a:args =~ ':'
    filet detect
    nn <buffer> <silent> zp :cal <SID>git_show_zp()<CR>
  el |setl ft=gitcommit |en
  endf
  fu s:git_show_zp() abort
endf

fu s:git_blame(rg)
  pc
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

fu s:git_files(args)
  nn <buffer> gf :GitShow <C-R>=@%->split()[-1]<CR>:<cfile><CR>
  nm <buffer> <C-W>f :sp<CR>gf
  nm <buffer> <C-W><C-F> :sp<CR>gf
endf

fu s:git_grep(args)
  pc
  setl nu nornu pvw
  winc ^
  norm zz
  winc p
  winc 10_
  "ec getline('.')->matchlist('\(\f\+\):\(\d\+\):')
endf

for [name, com, dargs] in
  \ [ ['diff', 'diff', '']
  \ , ['log', 'log', '']
  \ , ['show', 'show', "`=@%=~'^:GitB'?expand('<cword>'):@%=~'^:GitD'&&expand('<cfile>')=~'^[ab]/'?getline(1)->split()[1].'~:'.expand('<cfile>')[2:]:'--'`"]
  \ , ['blame', 'blame', '%']
  \ , ['files', 'ls-tree -r --name-only', 'HEAD']
  \ , ['grep', 'grep -rn', '-w <cword>']
  \ ]
  exe 'com! -bar -nargs=* -complete=file Git'..toupper(name[0])..name[1:]
    \ 'cal Giticky("'..name..'", <q-args>, "'..com..'", "'..dargs..'", "ene")'
endfo
unl name com dargs

" vim: se ts=2:
