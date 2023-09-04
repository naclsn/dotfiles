lan C
se ai cul et ff=unix ffs=unix,dos hid is lcs=tab:>\ ,trail:~ list ls=2 mouse=nrv noea nohls noto nowrap nu rnu ru scl=number so=0 ssl sw=0 ts=4 udf wim=longest:full,full wmnu wop=pum
au FileType * se fo+=j fo-=o
" isk-=_ sb spr
se spf=~/.vim/spell.utf-8.add
se dir=~/.vim/cache/swap//
if has('nvim')
  se udir=~/.vim/cache/nundo//
el
  se udir=~/.vim/cache/undo//
en
se ssop=blank,buffers,folds,globals,resize,sesdir,slash,terminal,unix,winsize,winpos
au SourcePost Session*.vim exe get(g:, 'Run', 'echom ''no "Run" in this session''')

colo slate
sy on
filet on
filet plugin on

hi clear MatchParen | hi link MatchParen Title
hi clear diffRemoved | hi link diffRemoved Identifier
hi clear diffAdded | hi link diffAdded Special
hi Normal ctermfg=white ctermbg=black

" nn <BS> ciw
nn <C-C> :<C-U>bd<CR>
nn <C-N> :<C-U>bn<CR>
nn <C-P> :<C-U>bp<CR>
nn <C-S> :<C-U>up<CR>

nn + :<C-U>.+
nn - :<C-U>.-

if has('nvim')
  map <space>t :<C-U>vert abo term<CR>:setl nobl nonu nornu<CR><C-W>60<Bar>i
  tmap <C-W>N <C-\><C-N>
el
  map <space>t :<C-U>vert abo term ++cols=60 ++noclose<CR>
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
  autocmd TerminalOpen * cal <SID>etup_term()
en
map <space>f :<C-U>60Lex .<CR><C-W>60<Bar>
map <space>b :<C-U>Ebuffer<CR>
map <space>B :<C-U>Ebuffer!<CR>
map <space>w <C-W>
map <space>a :<C-U>argdo norm 

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
map Zh zhZ
map Zj <C-E>Z
map Zk <C-Y>Z
map Zl zlZ
map Zt ztZ
map Zu <C-U>Z
map Zz zzZ

" random commands {{{1
com!                               Scratch  let ft=&ft|sil %y f|ene|pu f|0d _|let &ft=ft|unlet ft
com! -nargs=+ -complete=command    Less     let l=execute(<q-args>)|ene|setl bt=nofile nobl noswf|f [less] <args>|cal setline(1, split(l, '\n'))
com!                               ClipEdit ene|setl bh=wipe bt=nofile nobl noswf spell wrap|pu +|0d _|no <buffer> <C-S> :<C-U>%y +<CR>
com! -nargs=* -complete=file -bang GitDiff  ene|setl bh=wipe bt=nofile ft=diff nobl noswf|f [git-diff] <args>|cal setline(1, systemlist('git diff '.(<bang>0?'--staged ':'').<q-args>))|no <buffer> gf ?diff --git<CR>f/l<C-W><C-S>vEgf
com!                         -bang GitMsg   exe 'GitDiff<bang>'|42vs msg|setl spell|cal setline(1,['','']+map(systemlist('git status -sb'),'strlen(v:val)?"# ".v:val:"#"'))|cal <SID>git_msg_sb_syn()
fu s:git_msg_sb_syn()
  sy match Keyword /\%^.*\%<51v./
  sy match diffRemoved /[ MTADRCU]/ contained
  sy match diffAdded /[ MTADRCU]/ contained nextgroup=diffRemoved
  sy match Comment /^# / contains=String,diffAdded,diffRemoved nextgroup=diffAdded
  sy match Comment /^# \(??\|!!\|##\) .*/
endf

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
  tma <S-space> <space>
  if has('nvim')
    map <C-Z> :<C-U>b term:<CR>
  el
    map <C-Z> :<C-U>b !<CR>
  en
en

" command-line {{{1
cno <C-A> <Home>
cno <C-B> <Left>
cno <C-D> <Del>
cno <C-F> <Right>
cno <C-O> <C-F>
cno <C-X> <C-A>

" better v_! (filters exact selection) {{{1
xm ! "pc<C-R>=(system(input('<Bar>!','','shellcmd'),@p)??@p).nr2char(27)<CR>

" evaluate with 'ge{motion}' and replace with result {{{1
fu s:eval_this(ty='')
  exe 'se opfunc={_->execute(\"norm!\ `]lc`[\\<C-R>=eval(@\\\")\\<Esc>\")}'
  retu 'g@'
endf
nn <expr> ge <SID>eval_this()
xn <expr> ge <SID>eval_this()
"nn <expr> gee <SID>eval_this().'_'

" surround (rather 'Zurround' -- messes with 'z) {{{1
let pairs = map(split(&mps.',<:>,":",'':'',`:`', ','), 'split(v:val,":")')
fu s:urround(o, c)
  exe '"' == a:o ? 'se opfunc={_->execute(\"norm!\ `[mz`]a\\\"\\<Esc>`zi\\\"\")}' : 'se opfunc={_->execute(\"norm!\ `[mz`]a'.a:c.'\\<Esc>`zi'.a:o.'\")}'
  retu 'g@'
endf
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
el
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
    let l = getline(e[1]) | cal setline(e[1], l[:e[2]-1].p[2].l[e[2]:])
    let l = getline(s[1]) | cal setline(s[1], l[:s[2]-2].p[1].l[s[2]-1:])
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
  setl bl bt=nofile et fdm=indent noswf sw=0 ts=3
  cal setline(1, d)
  cal s:tree(d, 0)
endf
com! -complete=dir -nargs=1 Splore cal <SID>plore(<q-args>)

" buffer pick/drop {{{1
fu s:ebuffers_apply(bufdo)
  let nls = getline(1, '$')
  let k = 0
  let c = a:bufdo
  for l in b:ls
    let nr = matchstr(l, '^\s*\d\+')
    if k < len(nls) && nls[k][:len(nr)-1] == nr
      let k+= 1
    el
      let c.= ' '.nr
    en
  endfo
  exe c
endf
fu s:ebuffers(bang)
  let pnr = bufnr()
  let pls = split(execute('ls'.a:bang), '\n')
  bel 10sp|ene|setl bh=wipe bt=nofile cul nobl noswf
  f [Buffer List]
  let b:ls = pls
  cal matchadd('Comment', '^\s*\d\+u.*$')
  %d _
  cal setline(1, b:ls)
  exe 'au BufLeave <buffer> ++once cal <SID>ebuffers_apply("' ('!'==a:bang?'bw':'bd') '")'
  map <buffer> <silent> <CR> :<C-U>let l=getline('.')<Bar>bw<Bar>exe ''==l?'ene':'b'.matchstr(l,'\d\+')<CR>
  sil! exe '/^\s*'.pnr.'\D'
  norm! zz
endf
com! -bang Ebuffers cal <SID>ebuffers('<bang>')

" edit a variable (eg ':Eva Run') {{{1
fu s:evariable(name)
  bel 10sp|ene|setl bh=wipe bt=nofile nobl noswf
  exe 'f [Edit Variable' a:name.']'
  cal setline(1, split(get(g:, a:name, ''), '\n'))
  let nr = bufnr()
  exe 'au BufLeave <buffer> ++once let '.a:name.' = join(getbufline('.nr.', 1, "$"), "\n")'
endf
com! -nargs=1 -complete=var Evariable cal <SID>evariable(<q-args>)

" netrw {{{1
let g:netrw_banner      = 0
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
"let g:netrw_liststyle   = 3
let g:netrw_preview     = 1
let g:netrw_winsize     = 25
let g:netrw_chgwin      = 2
aug netrw_mapping
  au FileType netrw sil! unm <buffer> s
  au FileType netrw sil! unm <buffer> S
aug END

" vim: se ts=2:
