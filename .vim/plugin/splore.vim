" A (to me) more natural alt to netrw (no over-the-network tho)
"
" Last Change:	2024 Dec 14
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
fu s:unfold(dir, depth, at)
  let dir = '/' != a:dir[strlen(a:dir)-1] ? a:dir.'/' : a:dir
  let depth = a:depth+1
  let at = a:at
  let p = repeat("\t", depth)
  let k = 0
  for e in readdir(dir, {e -> '.' != e && '..' != e})
    let k+= 1
    " TODO: filtering maybe
    if isdirectory(dir.e)
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

fu s:dotdotdot()
  if 'n' == mode() && '...' == getline('.')[-3:]
    let pmod = &mod
    let ln = line('.')
    let ed = s:unfold(matchstr(getline(ln-1), ' (.*)$')[2:-2], indent('.')/&ts-1, ln+1)
    d2
    norm k
    if ln+1 != ed |exec ln.','.(ed-2) 'foldc!' |en
    norm zvj
    if !pmod |setl nomod |en
  en
endf

fu s:dircontent(dir)
  "" 0 if empty, 1 if only dir, 2 if has files
  let ls = readdir(a:dir)
  if empty(ls) |retu 0 |en
  for n in ls
    let f = a:dir..'/'..n
    if filereadable(f) || isdirectory(f) && 2 == s:dircontent(f) |retu 2 |en
  endfo
  retu 1
endf

fu s:apply()
  let lns = getline(1, '$')
  let path = [lns[0]]
  let syscoms = []
  let eds = []

  for k in range(1, len(lns)-1)
    let m = matchlist(lns[k], '\v\t+(.{-})( --(\d*) \((.*)\))?$')
    if !len(m) || '...' == m[1] |con |en
    if '`---' == m[1] |cal remove(path, -1) |con |en

    let entry = m[1] " eg. 'exe*' or 'dir/' or 'file'
    let pfull = m[4] " hidden in ' -- (<pfull>)'
    let wasdir = !empty(m[3])

    let isdir = '/' == entry[-1:]
    let isexe = '*' == entry[-1:]
    let name = isdir || isexe ? entry[:-2] : entry

    let full = join(path, '')..name
    let quoted = substitute(full, "'", "''", 'g') " for use in 'sys' (function calls -> expressions)
    let escaped = escape(full, '\/&') " for use in 'ed' (:s commands using /)

    if isdir |cal add(path, entry) |en
    if pfull == full |con |en

    let ed = '/\V'..escape(lns[k], '\/')
    if empty(pfull)
      " brand new path
      let frags = filter(split(name, '/'), '!empty(v:val)')
      let sys = isdir ? "mkdir('"..quoted.."'"..(1 < len(frags) ? ", 'p')" : ")") : "writefile([], '"..quoted.."')"
      if 1 < len(frags) |echom 'TODO: make updating edit for new directory with more than one fragment' |en " (TODO)
      let ed..= '/s/\s*$/ --'..(isdir ? len(path)-1 : '')..' ('..escaped..')'
    el
      " edit or deletion
      let pquoted = substitute(pfull, "'", "''", 'g')
      let sys = empty(name) ? "delete('"..pquoted.."'"..(wasdir ? [", 'd')", ", 'rf')", ')'][s:dircontent(pfull)] : ')') : "rename('"..pquoted.."', '"..quoted.."')"
      let ed..= empty(name) ? '/d' : '/s/ (.*)$/ ('..escaped..')'
    en

    " TODO: if isexe, and applicable, chmod +x (getfperm, setfperm)

    cal add(syscoms, sys)
    cal add(eds, ed)
    echom sys
  endfo

  if !len(syscoms) |setl nomod |retu |en
  if 1 != confirm('do?', "&Yes\n&No", 2) |echom 'didn''t' |retu |en

  for s in syscoms |exe 'cal' s |endfo

  let pos = getpos('.')
  for s in eds |exe s |endfo
  cal setpos('.', pos)

  let pul = &ul
  setl ul=-1
  exe "norm a \<BS>\<Esc>"
  let &ul = pul
  setl nomod
  echom 'done'
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
  au BufWriteCmd <buffer> cal s:apply()
  cal setline(1, d)
  cal s:unfold(d, 0, 1)
  au CursorMoved <buffer> cal s:dotdotdot()
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
