se ai et hid is lcs=tab:>\ ,trail:~ list ls=2 mouse=nv nohls noto nowrap nu rnu ru ts=4 scf sw=0 udf
se dir=~/.vim/cache/swap//
se udir=~/.vim/cache/undo//
colo slate
sy on
filet on
filet plugin on

nn <BS> ciw
nn <C-C> :<C-U>q<CR>
nn <C-N> :<C-U>bn<CR>
nn <C-P> :<C-U>bp<CR>
nn <C-S> :<C-U>w<CR>

map <C-W>t :<C-U>vert term ++cols=50<CR>
map <C-W>f :<C-U>(TODO) ... cols=50
map <C-W>b :<C-U>ls! "(TODO)<CR>
map <space>w <C-W>

com Scratch sil %y f|ene|pu f|0d
com! -nargs=+ -complete=command Less ene|se bt=nofile nobl nonu nornu noswf|cal execute(<q-args>)->split('\n')->setline(1)

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

" buffer switcher / file switch {{{1
" TODO: todo
"nn <C-W><C-E> :<C-U>ls!<CR>:b 
"tnoremap <C-W><C-E> <C-W>:ls!<CR>:b 

" readline {{{1
cno <C-A> <Home>
cno <C-B> <Left>
cno <C-D> <Del>
cno <C-F> <Right>
" TODO: maybe even more if gui_running (^[b ^[f ^[d ...)
cno <C-X> <C-A>

" surround (rather 'Zurround') {{{1
" TODO: still don't like the binding leader (here 'Z')
let pairs = map(split(&mps, ','), 'split(v:val,":")') + [['<','>'],['"','"'],["'","'"],['`','`']]
for [o,c] in pairs
  for s in [o,c]
    for [oo,cc] in pairs
      for ss in [oo,cc]
        exe 'nn ZR'.s.ss.' va'.o.'<Esc>r'.cc.'gvo<Esc>r'.oo.'``'
      endfo
    endfo
    exe 'nn ZD'.s.' va'.o.'<Esc>xgvo<Esc>x``'
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
" TODO: fixme!
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
    " FIXME: this jank and no work
    let n = s[1]
    let ls = []
    let i = ''
    wh n <= e[1]
      cal add(ls, getline(n))
      let ii = matchstr(ls[n-s[1]], '^\s*')
      if len(ii) < len(i)
        let i = ii
      en
      let n = n+1
    endw
    wh s[1] <= n
      echom len(ls).' - '.len(ls[n-s[1]]).' - '.(n-s[1])
      cal setline(n, i.b.ls[n-s[1]][len(i):].a)
      let n = n-1
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
com -complete=dir -nargs=1 Splore cal <SID>plore(<q-args>)

" netrw {{{1
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
