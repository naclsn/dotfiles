" A (to me) more natural alt to netrw (no over-the-network tho)
"
" Last Change:	2024 Nov 28
" Maintainer:	a b <a.b@c.d>
" License:	This file is placed in the public domain.
"
"  Just, know what you're using and doing-
"
" TODO: doc-ish, how to (gotchas), and many hidden fixmes

" g: variables {{{1
if &cp || exists('g:loaded_splore') |fini |en
let g:loaded_splore = 1

" s: functions {{{1
fu s:plore_unfold(dir, depth, at)
  let dir = '/' != a:dir[strlen(a:dir)-1] ? a:dir.'/' : a:dir
  let depth = a:depth+1
  let at = a:at
  let p = repeat("\t", depth)
  let k = 0
  for e in readdir(dir, {e -> '.' != e && '..' != e})
    let k+= 1
    if isdirectory(dir.e) && '.git' != e && '.svn' != e
      cal append(at, [p.e.'/ --'.depth.' ('.dir.e.')', p."\t..." , p.'`---'])
      let at+= 3
    el
      cal append(at, p.e.('x' == getfperm(dir.e)[2] ? '*' : '').' -- ('.dir.e.')')
      let at+= 1
    en
  endfo
  cal append(at, p[:-2].'`---')
  retu at
endf

fu s:plore_dotdotdot()
  if '...' == getline('.')[-3:]
    let pmod = &mod
    let ln = line('.')
    let ed = <SID>plore_unfold(matchstr(getline(ln-1), ' (.*)$')[2:-2], indent('.')/&ts-1, ln+1)
    d2
    norm k
    if ln+1 != ed |exec ln.','.(ed-2) 'foldc!' |en
    norm zvj
    if !pmod |setl nomod |en
  en
endf

fu s:plore_apply()
  let lns = getline(1, '$')
  let path = [lns[0]]
  let scb = []
  let eds = []
  for k in range(1, len(lns)-1)
    let m = matchlist(lns[k], '\t\+\(.\{-}\)\( --\d* (\(.*\))\)\?$')
    if !len(m) || '...' == m[1] |con |en
    if '`---' == m[1] |cal remove(path, -1) |con |en
    let name = '/' == m[1][-1:] || '*' == m[1][-1:] ? m[1][:-2] : m[1]
    let full = join(path, '').name
    if '/' == m[1][-1:] |cal add(path, m[1]) |en
    if m[3] == full |con |en
    " TODO/FIXME: this breaks when indentation was changed in editing (does it?)
    let ed = '/\V'.escape(lns[k], '\/')
    if len(m[3])
      let ln = len(name) ? "rename('".m[3]."', '".full."')" : "delete('".m[3]."'".('/' == m[1][-1:] ? ", 'rf')" : ")")
      let ed.= len(name) ? '/s/ (.*)$/ ('.escape(full, '\/').')' : '/d'
    el
      let ln = '/' == m[1][-1:] ? "mkdir('".full."'".(name =~ '/' ? ", 'p')" : ")") : "writefile([], '".full."')"
      let ed.= '/s/\s*$/ -- ('.escape(full, '\/').')'
    en
    cal add(scb, ln)
    cal add(eds, ed)
    echom ln
  endfo
  if !len(scb) |setl nomod |retu |en
  if 1 == confirm('do?', "&Yes\n&No", 2)
    for s in scb |exe 'cal' s |endfo
    let pos = getpos('.')
    for s in eds |exe s |endfo
    cal setpos('.', pos)
    let pul = &ul
    setl ul=-1
    exe "norm a \<BS>\<Esc>"
    let &ul = pul
    setl nomod
    echom 'done'
  el
    echom 'didn''t'
  en
endf

fu s:plore(dir)
  "let prefix = 'splore://'
  let prefix = ''
  let d = fnamemodify(simplify(a:dir.'/'), ':p')
  if bufexists(prefix.d) && bufnr(prefix.d) != bufnr()
    exe 'b' prefix.d
    retu
  en
  exe 'f' prefix.d
  %d
  let pul = &ul
  setl bt=acwrite cole=3 et fdl=0 fdm=marker fdt=repeat('\|\ \ ',indent(v:foldstart)/&ts).matchstr(getline(v:foldstart),'\\t\\+\\zs.*\\ze\ --').'\ +'.(v:foldend-v:foldstart-1) fen fmr=/\ --,--- ft=splore inde=indent(v:lnum-1)+((getline(v:lnum-1)=~'\ --\\d\\+\ (.*)$')-(getline(v:lnum)=~'`---'))*&ts indk=/,o,0=`-- inex=matchstr(getline('.'),'\ (\\zs.*\\ze)$') lcs=tab:\|\  list noet noswf sw=0 ts=3 ul=-1
  au BufWriteCmd <buffer> cal <SID>plore_apply()
  cal setline(1, d)
  cal <SID>plore_unfold(d, 0, 1)
  au CursorMoved <buffer> cal <SID>plore_dotdotdot()
  sy match Conceal / --\d* (.*)$/ conceal
  sy match Statement /[^ /]\+\//
  sy match Structure /[^ *]\+\*/
  sy match Comment /`---/
  nn <buffer> zp $h:bel vert ped <cfile><CR><C-W>48<Bar>0
  nn <buffer> zP $h:bel      ped <cfile><CR><C-W>48_0
  nn <buffer> zx $h:!xdg-open    <cfile><CR><Esc><Esc>0
  let &ul = pul
  setl nomod
endf

com! -complete=dir -nargs=1 Splore cal <SID>plore(<q-args>)

" TODO: this is discussable, not everybody want something like that-
exe 'hi Folded ctermbg=NONE guibg=NONE' execute('hi Statement')[20:]

" autocommands {{{1
aug FileExplorer
  au!
  " TODO/FIXME: is broken (problem in s:plore - overall, bad handling of buffers)
  au BufEnter * if isdirectory(@%) && 1 == line('$') |cal <SID>plore(@%) |en
aug END

" vim: se fdm=marker fdl=0 ts=2:
