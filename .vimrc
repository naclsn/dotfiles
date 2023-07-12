se ai et ff=unix hid is lcs=tab:>\ ,trail:~ list ls=2 mouse=nrv noea nohls noto nowrap nu rnu ssl sw=0 ts=4 udf
" isk-=_ sb spr
se spf=~/.vim/spell.utf-8.add
se dir=~/.vim/cache/swap//
if has('nvim')
  se udir=~/.vim/cache/nundo//
el
  se udir=~/.vim/cache/undo//
en

colo slate
" TODO: no work
hi link MatchParen Title
hi link diffRemoved Identifier
hi link diffAdded Special

sy on
filet on
filet plugin on

nn <BS> ciw
nn <C-C> :<C-U>bd<CR>
nn <C-N> :<C-U>bn<CR>
nn <C-P> :<C-U>bp<CR>
nn <C-S> :<C-U>up<CR>

if has('nvim')
  map <space>t :<C-U>vert abo term<CR>:setl nobl nonu nornu<CR><C-W>60<Bar>
el
  map <space>t :<C-U>vert abo term ++cols=60 ++noclose<CR>
en
"map <C-W>f :<C-U>Sex! .<CR>:setl nu rnu<CR><C-W>60<Bar>
map <space>f :<C-U>60Lex .<CR><C-W>60<Bar>
map <space>w <C-W>

" view sticky {{{1
map Z/ /
map Z<space> <space>
map Z? ?
map ZG GZ
map ZZ Z
map Zb <C-B>Z
map Zb zbZ
map Zd <C-D>Z
map Zf <C-F>Z
map Zg ggZ
map Zj <C-E>Z
map Zk <C-Y>Z
map Zt ztZ
map Zu <C-U>Z
map Zz zzZ

" random commands {{{1
com! Scratch sil %y f|ene|pu f|0d
com! -nargs=+ -complete=command Less let l=execute(<q-args>)|ene|se bt=nofile nobl nonu nornu noswf|f [less] <args>|cal setline(1, split(l, '\n'))

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
  se go+=d go-=L go-=m go-=T wak=no
  if g:is_win
    se gfn=Consolas:h14
  el
    se gfn=Monospace\ 14
  en
  for c in split('abcdefghijklmnopqrstuvwxyz', '\zs')
    exe 'tno <M-'.c.'> <Esc>'.c
  endfo
  map! <M-BS> <Esc><BS>
  map <C-Z> :<C-U>b !<CR>
en

" command-line {{{1
cno <C-A> <Home>
cno <C-B> <Left>
cno <C-D> <Del>
cno <C-F> <Right>
cno <C-X> <C-A>

" terminal things {{{1
fu s:etup_term()
  setl nobl nonu nornu
  if &sh =~ 'cmd\|powershell\|pwsh'
    tno <C-A> <Home>
    tno <C-B> <Left>
    tno <C-D> <Del>
    tno <C-E> <End>
    tno <C-F> <Right>
    tno <C-H> <BS>
    tno <C-N> <Down>
    tno <C-P> <Up>
  en
endf
if !has('nvim')
  autocmd TerminalOpen * cal <SID>etup_term()
en

" 3 names in status line {{{1
fu! Stl_3_bufnames()
  let ls = split(execute('ls'), '\n')
  if !&bl || len(ls) <3
    retu '%f'.(&ro ? '[RO]' : '%-4.4(%m%)')
  en
  let k = 0
  for v in ls
    if v =~ '^\s*'.bufnr()
      break
    en
    let k+= 1
  endfo
  let Present = {nr -> "%-16.16(%{'".substitute(substitute(bufname(nr), '%', '%%', 'g'), "'", "''", 'g')."'}"}
  let bp = Present(str2nr(ls[(k-1) % len(ls)])).'%)'
  let bc = Present(bufnr()).(&ro ? '[RO]' : '%-4.4(%m%)').'%)'
  let bn = Present(str2nr(ls[(k+1) % len(ls)])).'%)'
  retu g:actual_curbuf != bufnr() ? "%#StatusLineNC#".bp." ".bc." ".bn : "%#StatusLineNC#".bp."%#StatusLine# ".bc." %#StatusLineNC#".bn."%#StatusLine#"
endf
let &stl="%{%Stl_3_bufnames()%} %=%q %l/%L %c%V %y %{(&fenc?&fenc:&enc).'+'.&ff}"

" evaluate with 'ge{motion}' and replace with result {{{1
fu s:eval_this(ty='')
  exe 'se opfunc={_->execute(\"norm!\ `]lc`[\\<C-R>=eval(@\\\")\\<Esc>\")}'
  retu 'g@'
endf
nn <expr> ge <SID>eval_this()
xn <expr> ge <SID>eval_this()
nn <expr> gee <SID>eval_this().'_'

" surround (rather 'Zurround') {{{1
" TODO: could be better with a programmatic pending-mode (think `s:neak`)
let pairs = map(split(&mps.',<:>,":",'':'',`:`', ','), 'split(v:val,":")')
fu s:urround(o, c)
  exe '"' == a:o ? 'se opfunc={_->execute(\"norm!\ `[mz`]a\\\"\\<Esc>`zi\\\"\")}' : 'se opfunc={_->execute(\"norm!\ `[mz`]a'.a:c.'\\<Esc>`zi'.a:o.'\")}'
  retu 'g@'
endf
for [o,c] in pairs
  for s in [o,c]
    for [oo,cc] in pairs
      for ss in [oo,cc]
        exe 'nn ZR'.s.ss.' va'.o.'<Esc>r'.cc.'gvo<Esc>r'.oo.'``'
      endfo
    endfo
    exe 'nn ZD'.s.' va'.o.'<Esc>xgvo<Esc>x``'
    exe 'nn <expr> Z'.s.' <SID>urround("'.escape(o,'"').'","'.escape(c,'"').'")'
    exe 'xn <expr> Z'.s.' <SID>urround("'.escape(o,'"').'","'.escape(c,'"').'")'
    exe 'nn <expr> Z'.s.'Z <SID>urround("'.escape(o,'"').'","'.escape(c,'"').'")."_"'
  endfo
endfo

" sneak movement (multi-char and multi-line 't'/'f') {{{1
fu s:neak(d)
  let d = a:d
  let t = ''
  wh d
    redr|ec '('.d.')'.t
    let c = getchar()
    if 27 == c
      redr|ec
      retu
    en
    let t.= nr2char(c)
    let d-= 0 < a:d ? 1 : -1
  endw
  let t = '\V'.t
  let w:eak = (0 < a:d ? '/' : '?').t."\<CR>"
  let w:kae = (0 < a:d ? '?' : '/').t."\<CR>"
  exe 'norm '.v:count.w:eak
endf
if has('patch-8.3.1978') || has('nvim')
  no s <Cmd>cal <SID>neak(2)<CR>
  no S <Cmd>cal <SID>neak(-2)<CR>
el " will not have proper support for eg. visual...
  no s :<C-U>cal <SID>neak(2)<CR>
  no S :<C-U>cal <SID>neak(-2)<CR>
en
for r in ['t','T','f','F']
  exe 'nn '.r.' :unl! w:eak w:kae<CR>'.r
endfo
no <expr> ; get(w:,'eak',';')
no <expr> , get(w:,'kae',',')

" comment with 'gc{motion}' {{{1
fu s:omment(ty='')
  if '' == a:ty
    se opfunc=<SID>omment
    retu 'g@'
  en
  let s = getpos("'[")
  let e = getpos("']")
  let p = matchlist(&cms, '^\(.*\)%s\(.*\)$')
  if 'char' == a:ty && len(p[2])
    " FIXME: this is still incorrect, and TODO: also could look for s/e flags in &com
    let l = getline(e[1]) | cal setline(e[1], l[:e[2]].p[2].l[e[2]:])
    let l = getline(s[1]) | cal setline(s[1], l[:s[2]-2].p[1].l[s[2]-2:])
  el
    let q = filter(map(split(&com, ','), 'matchlist(v:val, "^b\\?:\\(.*\\)")'), 'len(v:val)')
    if len(q)
      let b = q[0][1].('b' == q[0][0][0] ? ' ' : '')
      let a = ''
    el
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

" splore (file tree) {{{1
fu s:tree(dir, depth)
  let dir = '/' != a:dir[strlen(a:dir)-1] ? a:dir.'/' : a:dir
  let depth = a:depth+1
  " XXX: could make a fancier tree ('|'/'+'/'L'/'-' probably)
  " but then commands like '<' and '>' are not helpful
  let p = repeat(repeat(' ', &ts), depth)
  for e in readdir(dir) " TODO: partition dirfirst, filter dotfiles...
    if isdirectory(dir.e) && '.git' != e && '.svn' != e
      cal append('$', p.e.'/')
      cal s:tree(dir.e, depth)
    el
      cal append('$', p.e)
    en
  endfo
endf
fu s:plore(dir)
  let d = trim(expand(a:dir), '/\', 2).'/'
  let b = bufadd('dir: '.a:dir)
  cal bufload(b)
  exe 'b '.b
  se bl bt=nofile et fdm=indent noswf sw=0 ts=3
  cal setline(1, d)
  cal s:tree(d, 0)
endf
com! -complete=dir -nargs=1 Splore cal <SID>plore(<q-args>)

" netrw {{{1
let g:netrw_banner      = 0
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
"let g:netrw_liststyle   = 3
let g:netrw_preview     = 1
let g:netrw_winsize     = 25
"nn <C-L> :<C-U>exe get(w:,'rex','Ex')<Bar>let w:rex='Rex'<CR>
aug netrw_mapping
  au FileType netrw sil! unm <buffer> s
  au FileType netrw sil! unm <buffer> S
aug END

" vim: se ts=2:
