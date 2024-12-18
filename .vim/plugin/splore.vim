" A (to me) more natural alt to netrw (no over-the-network tho)
"
" FS tree is presented as plain text and relying on Vim folds for dirs.
"   zo  open fold
"   zc  close fold
"   zM  close all folds recursively
"   and so on-
"   also:  zp or zP  open in preview window
" Initially dirs only contain a "..." entry which will be automatically
" expanded when the cursor moves onto it.
"
" All the book-keeping is kept in a syntax-concealed part past the entry;
" all lines end with " -- (..)".  For dirs, the depth as a number follows
" the "--".  This means that a line without this part is a new entry new.
" Another consequence is that lines fully deleted from the buffer are
" "out if sight - out of mind".
"
" Edit the buffer and save your changes like you would any other.  Upon
" saving, the book-keeping should be updated correctly.  Outside of unexpected
" jank/hacks, the following transactions should be explicitly supported and
" well behaved:
"
"   CREATE: by adding a line in the intended fold
"     * new plain file: "name"
"     * new plain executable file: "name*"
"     * new dir: "name/"
"     * new link: "name@ -> target" (creates the target file if doesn't exist)
"     * new link to dir: "name/@ -> target" (+ dir target if doesn't exist)
"     * new link to executable: "name*@ -> target" (same)
"     * any above through longer path: "path/to/file*@ -> target"
"
"   UPDATE: by changing the entry, keeping the concealed " -- (..)" part
"     * renaming any without changing type
"     * re-targeting link
"     * adding/removing executable (directly or through link) XXX: removing NIY
"     * empty plain file -> dir XXX: NIY
"     * empty plain file -> link XXX: NIY
"     * empty dir (or contains only empty dirs) -> file XXX: NIY
"     * empty dir (or contains only empty dirs) -> link XXX: NIY
"     * link -> file XXX: NIY
"     * link -> dir XXX: NIY
"
"   DELETE: by deleting the entry, keeping the concealed " -- (..)" part
"     * file
"     * link (to anything); only deletes the link itself
"     * dir if empty or if it contains only empty dirs recursively
"
" Last Change:	2024 Dec 17
" Maintainer:	a b <a.b@c.d>
" License:	This file is placed in the public domain.
"
"  Just, know what you're using and doing-
"
" TODO: todos

" g: variables {{{1
if &cp || exists('g:loaded_splore') |fini |en
let g:loaded_splore = 1

" XXX: idk
"if exists('g:splore_hifolded') |hi Folded ctermbg=NONE guibg=NONE |en
hi Folded ctermbg=NONE guibg=NONE

if !exists('g:splore_autocmd') |let g:splore_autocmd = 1 |en

" s: functions {{{1
fu s:trace(f, ...)
  echom a:f a:000
  cal call(a:f, a:000)
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

fu s:readlink(lnk, recursive)
  "" ``recursive`` should be eg '' or '-m'
  sil retu system(join(['readlink', a:recursive, shellescape(a:lnk)]))[:-2]
endf

fu s:writelink(lnk, target, force)
  "" ``force`` should be '' or '-f'
  sil cal system(join(['ln', a:force, '-s', shellescape(a:target), shellescape(a:lnk)]))
endf

fu s:unfold(dir, depth, at)
  let dir = '/' != a:dir[strlen(a:dir)-1] ? a:dir..'/' : a:dir
  let depth = a:depth+1
  let at = a:at
  let p = repeat("\t", depth)
  for e in readdir(dir, {e -> '.' != e && '..' != e})
    let ty = getftype(dir..e)
    if "link" == ty
      let target = s:readlink(dir..e, '-m')
      if isdirectory(target)
        cal append(at, [p..e..'/@ -> '..s:readlink(dir..e, '')..' --0'..depth..' ('..dir..e..')', p.."\t..." , p..'`---'])
        let at+= 3
      el
        cal append(at, p..e..('x' == getfperm(target)[2] ? '*' : '')..'@ -> '..s:readlink(dir..e, '')..' -- ('..dir..e..')')
        let at+= 1
      en
    elsei "dir" == ty
      cal append(at, [p..e..'/ --0'..depth..' ('..dir..e..')', p.."\t..." , p..'`---'])
      let at+= 3
    el
      cal append(at, p..e..('x' == getfperm(dir..e)[2] ? '*' : '')..' -- ('..dir..e..')')
      let at+= 1
    en
  endfo
  cal append(at, p[:-2]..'`---')
  retu at
endf

" TODO: maybe wacky, FIXME
fu s:dotdotdot()
  if 'n' == mode() && '...' == getline('.')[-3:]
    let pmod = &mod
    let ln = line('.')
    " FIXME: don't use indent
    let ed = s:unfold(matchstr(getline(ln-1), ' (.*)$')[2:-2], indent('.')/&ts-1, ln+1)
    d2
    norm! k
    if ln+1 != ed |exec ln..','..(ed-2) 'foldc!' |en
    norm! zvj
    if !pmod |setl nomod |en
  en
endf

fu s:apply()
  let lns = getline(1, '$')
  let path = [lns[0]]
  "let eds = []

  for k in range(1, len(lns)-1)
    let m = matchlist(lns[k], '\v\t+(.{-})( --(\d*) \((.*)\))?$')
    if !len(m) || '...' == m[1] |con |en
    if '`---' == m[1] |cal remove(path, -1) |con |en

    let entry = m[1] " eg. 'exe*' or 'dir/' or 'file' or 'link?@ -> target' (where '?' could be '/' or '*')
    let pfull = m[4] " hidden in ' -- (<pfull>)'
    let wasdir = !empty(m[3]) " also true for a link to dir

    let islnk = match(entry, '@ -> ')+1
    if islnk
      let target = entry[islnk+4:]
      let entry = entry[:islnk-2]
    en
    let isdir = '/' == entry[-1:]
    let isexe = '*' == entry[-1:]
    let name = trim(isexe ? entry[:-2] : entry, '/', 2)

    let full = join(path, '')..name
    "let escaped = escape(full, '\/&') " for use in :/ and :s commands

    if isdir |cal add(path, entry) |en
    if pfull == full && !islnk |con |en " XXX: will not be enough when enabling more trans

    "let ed = '/\V'..escape(lns[k], '\/')
    if empty(pfull)
      " brand new path
      let frags = filter(split(name, '/'), '!empty(v:val)')
      if 1 < len(frags)
        if isdir && !islnk
          cal s:trace('mkdir', full, 'p')
          " TODO: updating edits
          cont
        en
        cal s:trace('mkdir', join(isdir && islnk ? path[:-2] : path, '')..join(frags[:-2], '/'), 2 < len(frags) ? 'p' : '')
      en
      let name = frags[-1]

      if islnk
        cal s:trace('s:writelink', full, target, '')
        let full = '/' != target[0] ? fnamemodify(full, ':h')..'/'..target : target
        if '' != getftype(full) |cont |en
      en

      ev isdir ? s:trace('mkdir', full) : s:trace('writefile', [], full)

      " TODO: make updating edit for new directory with more than one fragment
      "let ed..= '/s/\s*$/ --'..(isdir ? len(path)-1 : '')..' ('..escaped..')'

    el
      " edition or deletion

      " TODO: enable trans:
      "   empty file to dir or link
      "   empty (recurse) dir to file or link
      "   link to dir or file

      if empty(name)
        cal s:trace('delete', pfull, wasdir && !islnk ? ['d', 'rf', ''][s:dircontent(pfull)] : '')
      elsei pfull == full && islnk
        let ptarget = s:readlink(full, '')
        if ptarget != target
          cal s:trace('s:writelink', full, target, empty(ptarget) ? '' : '-f')
        en
      el
        " TODO: handle renaming dir that where unfolded- somehow-
        cal s:trace('rename', pfull, full)
      en

      " more of TODO: edits
      "let ed..= empty(name) ? '/d' : '/s/ (.*)$/ ('..escaped..')'
    en

    if isexe
      let perm = getfperm(full)
      if '-' == perm[2]
        cal s:trace('setfperm', full, join([perm[:1], perm[3:4], perm[6:7], ''], 'x'))
      en
    en

    " maybe more of TODO: edits
    "cal add(eds, ed)
  endfo

  retu
  " XXX(wip): dead code

  let pos = getpos('.')
  for s in eds |exe s |endfo
  cal setpos('.', pos)

  let pul = &ul
  setl ul=-1
  exe "norm! a \<BS>\<Esc>"
  let &ul = pul
  setl nomod
endf

fu s:plore(dir)
  "let prefix = 'splore://'
  let prefix = ''
  let d = fnamemodify(simplify(a:dir..'/'), ':p')
  if bufexists(prefix..d) && bufnr(prefix..d) != bufnr()
    exe 'b' prefix..d
    retu
  en
  exe 'f' prefix..d

  let pul = &ul
  " TODO: fix indentexpr, add formatexpr
  setl bt=acwrite cole=3 et fdl=0 fdm=marker fdt=repeat('\|\ \ ',indent(v:foldstart)/&ts).matchstr(getline(v:foldstart),'\\t\\+\\zs.*\\ze\ --').'\ +'.(v:foldend-v:foldstart-1) fen fmr=\ --0,--- ft=splore inde=indent(v:lnum-1)+((getline(v:lnum-1)=~'\ --\\d\\+\ (.*)$')-(getline(v:lnum)=~'`---'))*&ts indk=/,o,0=`-- inex=matchstr(getline('.'),'\ (\\zs.*\\ze)$') lcs=tab:\|\  list noet noswf sw=0 ts=3 ul=-1
  %d
  cal setline(1, d)
  cal s:unfold(d, 0, 1)

  au BufWriteCmd <buffer> cal s:apply()
  au CursorMoved <buffer> cal s:dotdotdot()

  sy match Conceal /--\d* (.*)$/ conceal
  sy match Statement /^\t*.\{-}\/\ze\(@\%[ -> ]\| --\|$\)/
  sy match Structure /^\t*.\{-}\*\ze\(@\%[ -> ]\| --\|$\)/
  sy match String /@ -> .\{-}\ze\( --\|$\)/
  sy match Comment /`---/
  sy match Title /\%1l.*/

  nn <buffer> zp $h:bel vert ped  <cfile><CR><C-W>48<Bar>0
  nn <buffer> zP $h:bel      ped  <cfile><CR><C-W>48_0
  nn <buffer> zx $h:sil !xdg-open <cfile><CR><Esc><Esc>0
  let &ul = pul
  setl nomod
endf

" TODO: use as a command would :new
com! -complete=dir -nargs=1 Splore cal <SID>plore(<q-args>)

" autocommands {{{1
if g:splore_autocmd
  aug FileExplorer
    au!
    " TODO/FIXME: is broken (problem in s:plore - overall, bad handling of buffers)
    au BufEnter * if isdirectory(@%) && 1 == line('$') |cal <SID>plore(@%) |en
  aug END
en

" vim: se fdm=marker fdl=0 ts=2:
