lan C

" se {{{1
se ai bs= cot=menuone,noselect cul enc=utf-8 et fdl=999 fdm=marker ff=unix ffs=unix,dos fo=1cjnr gp= hid is isf-== lbr lcs=tab:>\ ,trail:~ list ls=2 mouse=nrv noea nofen nohls notgc noto nowrap nu rnu ru sc scl=no so=0 spc= ssl sw=0 ts=4 ttimeout ttm=100 udf wim=longest:full,full wmnu wop=pum

se spf=~/.vim/spell/my.utf-8.add
se dir=~/.vim/cache/swap//
if has('nvim')
  se rtp^=~/.vim/
  se udir=~/.vim/cache/nundo//
  aun PopUp
  sil! au! nvim_popupmenu
  map! <C-Space> <Nop>
  "colo vim
el
  se udir=~/.vim/cache/undo//
  "colo default
en

se ssop=blank,buffers,folds,globals,options,resize,sesdir,slash,tabpages,terminal,unix,winsize

" au {{{1
au BufEnter * se fo-=o
au ColorScheme * cal s:fix_colo()
au FileType c,python sy keyword Title self
au FileType python   if !filereadable('Makefile') |setl mp=flake8 |el |setl mp& |en
au FileType python   sil! let &l:tw = (readfile('setup.cfg')->matchlist('max_line_length\s\?=\s\?\(\d\+\)') ?? ['', '88'])[1]
au FileType python   nn <buffer> <silent> gqq :cal <SID>black_formatexpr(1, line('$'), '')<CR>
au FileType python   setl fex=s:black_formatexpr()
au Filetype xml      setl fp=xmllint\ --format\ -
au FileType xxd      nn <buffer> <C-A> geebi0x<Esc><C-A>b"_2xe |nn <buffer> <C-X> geebi0x<Esc><C-X>b"_2xe
au SessionLoadPost * if has_key(g:,'Run') |cal execute(g:Run) |en
au SpellFileMissing * cal s:pellfile_wget(expand('<amatch>'))

" fu used by au {{{1
fu s:black_formatexpr(lnum=v:lnum, count=v:count, char=v:char) abort
  if !empty(a:char) || mode() =~ '[iR]' |retu |en

  let lines = ['black',
      \ '--quiet', '--diff',
      \ '--line-length', &tw ?? 78,
      \ '--line-ranges', a:lnum..'-'..(a:lnum+a:count-1),
      \ '--stdin-filename', @%->shellescape(), '-']
    \ ->join()
    \ ->systemlist(getline(1, '$') + [''])
  if v:shell_error
    for l in lines |echoe l |endfo
    retu
  en
  let l = lines->len()

  let pos = getcurpos()
  let pastend = 0
  let k = 2
  wh k < l
    let nr = line('.')
    let j = lines[k]->matchstr('^@@ -\d\+,\d\+ +\zs\d\+\ze,\d\+ @@$')
    if j
      cal cursor(j, 1)
      let n = k+1

    elsei '-' == lines[k][0]
      let n = lines->match('^[^-]', k)
      if -1 == n |let n = l |en
      cal deletebufline('%', nr, nr+n-k-1)
      " if we deleted last line, we moved; next (and last) '+'s must not -1
      if line('.') != nr |let pastend = 1 |en

    elsei '+' == lines[k][0]
      let n = lines->match('^[^+]', k)
      if -1 == n |let n = l |en
      cal append(pastend ? nr : nr-1, lines[k:n-1]->map('v:val[1:]'))

    elsei ' ' == lines[k][0]
      let n = lines->match('^[^ ]', k)
      if -1 == n |let n = l |en
      cal cursor(nr+n-k, 1)

    el |echoe 'broken:' lines[k] |brea |en
    let k = n
  endw
  cal setpos('.', pos)
endf

fu s:fix_colo()
  hi clear MatchParen  |hi link MatchParen  Title
  hi clear Pmenu       |hi link Pmenu       CursorLine
  hi clear diffRemoved |hi link diffRemoved Identifier
  hi clear diffAdded   |hi link diffAdded   Special
  "hi Normal ctermfg=white ctermbg=black
  if has_key(g:, 'terminal_ansi_colors')
    let c = matchstr(execute('hi Normal'), 'guibg=\S\+')[6:]
    let g:terminal_ansi_colors = [c]+g:terminal_ansi_colors[1:]
    exe 'hi Terminal guibg='.c
    unl c
  en
endf

fu s:pellfile_wget(lang)
  if 2 == confirm('Download spl/sug for '..a:lang..'?', "&No\n&Yes")
    sil let res = system('wget -B https://ftp.nluug.nl/pub/vim/runtime/spell/ -P "$HOME/.vim/spell" -nvc -i-', [
      \ a:lang.'.utf-8.spl',
      \ a:lang.'.utf-8.sug'])
    ec res
    if res =~ 'failed:\|ERROR' |echoe 'hoe!!' |en
  en
endf

" map and ab {{{1
" bringing these back 'cause save my pinkies
nm Zb <C-B>Z
nm Zd <C-D>Z
nm Ze <C-E>Z
nm Zf <C-F>Z
nm Zu <C-U>Z
nm Zy <C-Y>Z

abc
ca lang setl wrap! bri! spell! spl
ca scra setl bt=nofile ft
ca hl setl hls!
ca wr setl wrap! bri!
ca pw setl pvw!
ca vb vert sb

" com {{{1
com! -bar Mark lad expand('%').':'.line('.').':'.getline('.')
com! -bar -bang Mks exe 'mks'.'<bang>'[empty(v:this_session)] v:this_session
com! -bar DiffOrigin vne |setl bh=wipe bt=nofile pvw ro |r ++edit # |0d_ |difft |winc p |difft
com! -nargs=1 Mv f <args> |exe '!mv # %' |bd #

" platform specific {{{1
let g:is_win = has('win16') || has('win32') || has('win64')
if g:is_win
  if !executable('bash')
    se sh=powershell
  el
    se sh=bash
  en
en
if has('gui_running')
  se go-=L go-=m go-=T wak=no
  if g:is_win
    se gfn=Consolas:h14
  elsei exists('g:neovide')
    se gfn=Monospace:h14
    let g:neovide_hide_mouse_when_typing = v:true
    let g:neovide_scroll_animation_length = 0.15
    let g:neovide_cursor_animation_length = 0.06
  el
    se go+=d gfn=Monospace\ 14
  en
  for c in split('abcdefghijklmnopqrstuvwxyz', '\zs')
    exe 'tno <M-'.c.'> <Esc>'.c
  endfo
  map! <M-BS> <Esc><BS>
  tma <S-space> <space>
en

" surround (rather 'Zurround' -- messes with 'z) {{{1
let pairs = map(split(&mps.',<:>,":",'':'',`:`', ','), 'split(v:val,":")')
fu s:urround(o, c)
  exe '"' == a:o ? 'se opfunc={_->execute(\"norm!\ `[mz`]a\\\"\\<Esc>`zi\\\"\")}' : 'se opfunc={_->execute(\"norm!\ `[mz`]a'.a:c.'\\<Esc>`zi'.a:o.'\")}'
  retu 'g@'
endf
" TODO: rewrite these as functions too
for [o,c] in pairs
  for s in [o,c]
    for [oo,cc] in pairs
      for ss in [oo,cc]
        exe 'nn ZR'.s.ss 'mzvi'.o.'<Esc>lr'.cc.'gvo<Esc>hr'.oo.'`z'
      endfo
    endfo
    exe 'nn ZD'.s 'mzvi'.o.'<Esc>lxgvo<Esc>hx`z'
    exe 'nn <expr> Z'.s '<SID>urround("'.escape(o,'"').'","'.escape(c,'"').'")'
    exe 'xn <expr> Z'.s '<SID>urround("'.escape(o,'"').'","'.escape(c,'"').'")'
  endfo
endfo
unl o c s oo cc ss

" comment with 'gc{motion}' {{{1
fu s:omment(ty='')
  if '' == a:ty
    se opfunc=<SID>omment
    retu 'g@'
  en
  let s = getpos("'[")
  let e = getpos("']")
  let p = matchlist(&cms, '^\(.*\)%s\(.*\)$')
  if 'char' == a:ty && len(p) && len(p[2])
    let l = getline(e[1]) |cal setline(e[1], l[:e[2]-1].p[2].l[e[2]:])
    let l = getline(s[1]) |cal setline(s[1], l[:s[2]-2].p[1].l[s[2]-1:])
  el
    let b = matchstr(&com, ':\(//\|--\|"\|#\|;\|%\)')[1:]
    let a = ''
    if !len(b)
      let b = p[1]
      let a = p[2]
    en
    let n = s[1]
    let ls = []
    let i = ''
    wh n <= e[1]
      cal add(ls, getline(n))
      let ii = matchstr(ls[n-s[1]], '^\s*')
      if n == s[1] || len(ii) < len(i)
        let i = ii
      en
      let n+= 1
    endw
    let n-= 1
    wh s[1] <= n
      cal setline(n, i.b.ls[n-s[1]][len(i):].a)
      let n-= 1
    endw
  en
  cal setpos('.', s)
endf
nn <expr> gc <SID>omment()
xn <expr> gc <SID>omment()
nn <expr> gcc <SID>omment().'_'

" align by with 'g={motion}' {{{1
fu s:lignby(ty='')
  if '' == a:ty
    se opfunc=<SID>lignby
    retu 'g@'
  en
  let pat = input('align pattern: ')
  if !len(pat) |retu |en
  let st = getpos("'[")[1]
  let ed = getpos("']")[1]
  let far = 0
  let lines = []
  let offsets = []
  for k in range(st, ed)
    let cur = add(offsets, match(add(lines, getline(k))[-1], pat))[-1]
    if far < cur |let far = cur |en
  endfo
  for k in range(st, ed)
    let ln = remove(lines, 0)
    let off = remove(offsets, 0)
    if -1 != off |cal setline(k, ln[:off-1].repeat(' ', far-off).ln[off:]) |en
  endfo
endfu
nn <expr> g= <SID>lignby()
xn <expr> g= <SID>lignby()

" simplest ass file explorer (likely temp experiment) {{{1
aug FileExplorer
  au!
  au BufEnter * if isdirectory(@%) && !wordcount().bytes
        \|exe 'r !dir -agop --time-style=+ %:p:S' |keepj 0d_
        \|setl nomod noswf syn=dirpager
        \|nn <buffer> <silent> <CR> :exe 'e' Cfile()<CR>
        \|nn <buffer> <silent> g<CR> :exe 'ped' Cfile()<CR>
        \|en
  fu! Cfile()
    retu matchstr(trim(@%,'/',2).'/'.matchstr(getline('.'),'\%>11c.*[ 0-9]\{-}  \zs.*'),'^\%(\./\)\?\zs.\{-}\ze/*$')
  endf
aug END

" random and modeline {{{1
for n in ['gzip', 'netrw', 'spellfile', 'tar', 'zip']
  let g:loaded_{n} = 1
  let g:loaded_{n}Plugin = 1
  let g:loaded_{n}_plugin = 1
endfo
unl n
let g:vimsyn_embed = 'pPr'
let g:man_hardwrap = 0

sy on
filet on
"filet plugin indent off
"filet plugin on

if executable('gsettings') && system('gsettings get org.gnome.desktop.interface color-scheme') !~ 'dark'
  colo shine
el
  colo slate
en

" vim: se fdm=marker fdl=0 ts=2:
