se ai et gd hid is lcs=tab:>\ ,trail:~ list ls=2 mouse=nv nohls nowrap nu rnu ru ts=4 scf sw=0 udf ww=h,l
se dir=~/.vim/cache/swap//
se udir=~/.vim/cache/undo//
colo slate
sy on
filet on
filet plugin on

com Scratch sil %y f|ene|pu f|0d
nn <BS> ciw
nn <C-C> :<C-U>q<CR>
nn <C-N> :<C-U>bn<CR>
nn <C-P> :<C-U>bp<CR>
nn <C-S> :<C-U>w<CR>

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
en

" buffer switcher {{{1
nn <C-W><C-E> :<C-U>ls!<CR>:b 
tnoremap <C-W><C-E> <C-W>:ls!<CR>:b 

" readline {{{1
cno <C-A> <Home>
cno <C-B> <Left>
cno <C-D> <Del>
cno <C-F> <Right>
" TODO: maybe even more if gui_running (^[b ^[f ^[d ...)
cno <C-X> <C-A>

" surround (rather 'Zurround') {{{1
" TODO: still don't like the binding leader (here 'Z')
let pairs = map(split(&mps, ','), 'split(v:val,":")') + [['"','"'],["'","'"],['`','`']]
for [o,c] in pairs
  for s in [o,c]
    for [oo,cc] in pairs
      for ss in [oo,cc]
        exe 'nn ZR'.s.ss.' va'.o.'<Esc>r'.cc.'gvo<Esc>r'.oo.'``'
      endfo
    endfo
    exe 'nn ZD'.s.' va'.o.'<Esc>dgvo<Esc>d``'
  endfo
endfo

" sneak movement (multi-char and multi-line 't'/'f') {{{1
fu s:neak(d)
  let d = a:d
  let t = ''
  wh d
    let c = getchar()
    if 27 == c
      retu
    en
    let t.= nr2char(c)
    let d-= 0 < a:d ? 1 : -1
  endw
  let w:eak = (0 < a:d ? '/' : '?').t."\<CR>"
  let w:kae = (0 < a:d ? '?' : '/').t."\<CR>"
  exe 'norm '.v:count.w:eak
endf
if has('patch-8.3.1978')
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
    wh n <= e[1]
      cal setline(n, b.getline(n).a)
      let n = n+1
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
  let p = repeat('|  ', depth)
  for e in readdir(dir)
    if isdirectory(dir.e) && '.git' != e
      cal append('$', p.e.'/')
      cal s:tree(dir.e, depth)
    el
      cal append('$', p.e)
    en
  endfo
endf
fu s:plore(dir)
  let d = expand('/' != a:dir[strlen(a:dir)-1] ? a:dir.'/' : a:dir)
  let b = bufadd('dir: '.a:dir)
  cal bufload(b)
  exe 'b '.b
  se bl bt=nofile noswf
  cal setline(1, d)
  cal s:tree(d, 0)
endf
no <C-Q> :<C-U>cal <SID>plore('~/Documents/Projects/mn')<CR>

" netrw (TODO: tree too janky, switch away) {{{1
let g:netrw_banner      = 0
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
let g:netrw_liststyle   = 3
let g:netrw_preview     = 1
let g:netrw_winsize     = 25
nn <C-L> :<C-U>exe get(w:,'rex','Ex')\|let w:rex='Rex'<CR>
aug netrw_mapping
  au FileType netrw sil! unm <buffer> s
  au FileType netrw sil! unm <buffer> S
aug END

" vim: se ts=2:
