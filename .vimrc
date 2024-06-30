lan C
se ai bs= cot=menuone,noselect cul et fdl=0 fdm=marker ff=unix ffs=unix,dos fo+=1cjr hid is lbr lcs=tab:>\ ,trail:~ list ls=2 mouse=nrv noea nofen nohls noto nowrap nu rnu ru scl=number so=0 spc= ssl sw=0 ts=4 udf wim=longest:full,full wmnu wop=pum
se spf=~/.vim/spell.utf-8.add
se dir=~/.vim/cache/swap//
if has('nvim')
  se udir=~/.vim/cache/nundo//
el
  se udir=~/.vim/cache/undo//
en
se ssop=blank,buffers,folds,globals,resize,sesdir,slash,terminal,unix,winsize,winpos
au SourcePost Session*.vim if has_key(g:,'Run')|cal execute(g:Run)|en
au BufEnter * se fo-=o

colo slate
sy on
filet on
filet plugin on

au FileType c,py sy keyword Title self
hi clear MatchParen | hi link MatchParen Title
hi clear diffRemoved | hi link diffRemoved Identifier
hi clear diffAdded | hi link diffAdded Special
hi Normal ctermfg=white ctermbg=black
if has_key(g:, 'terminal_ansi_colors')
  let c = matchstr(execute('hi Normal'), 'guibg=\S\+')[6:]
  let g:terminal_ansi_colors = [c]+g:terminal_ansi_colors[1:]
  exe 'hi Terminal guibg='.c
  unl c
en
au FileType xxd nn <C-A> geebi0x<Esc><C-A>b"_2xe|nn <C-X> geebi0x<Esc><C-X>b"_2xe

nn <C-C> :<C-U>q!<CR>
nn <C-N> :<C-U>bn<CR>
nn <C-P> :<C-U>bp<CR>
nn <C-S> :<C-U>up<CR>

nm U u
nn + :<C-U>.+
nn - :<C-U>.-

nm <C-J> :<C-U>py print()<C-B>

if has('nvim')
  map <space>t :<C-U>vert abo ter<CR>:setl nobl nonu nornu<CR><C-W>60<Bar>i
  tmap <C-W>N <C-\><C-N>
el
  map <space>t :<C-U>vert abo ter ++cols=60 ++noclose<CR>
  fu s:etup_term()
    setl nobl nonu nornu
    if 'cmd' == &sh
      tno <C-A> <Home>
      tno <C-B> <Left>
      tno <C-D> <Del>
      tno <C-E> <End>
      tno <C-F> <Right>
      tno <C-H> <BS>
      tno <C-N> <Down>
      tno <C-P> <Up>
    elseif &sh =~ 'powershell\|pwsh'
      cal term_sendkeys('', '$_psss=@{EditMode="Emacs";Colors=@{Operator="$([char]27)[m";Parameter="$([char]27)[m"}};set-psreadlineoption @_psss'."\r")
    en
  endf
  autocmd TerminalOpen * cal <SID>etup_term()
en
map <space>f :<C-U>60Lex .<CR><C-W>60<Bar>
map <space>b :<C-U>Ebuffers<CR>
map <space>B :<C-U>Ebuffers!<CR>
map <space>u :<C-U>Eundotree<CR>
map <space>w <C-W>
map <space>y "+y
map <space>p "+p
map <space>P "+P
map <space>l :<C-U>let @+ = @%.':'.line('.')<CR>

map <C-W><lt> :<C-U>winc <lt><CR><C-W>
map <C-W>>    :<C-U>winc >   <CR><C-W>
map <C-W>+    :<C-U>winc +   <CR><C-W>
map <C-W>-    :<C-U>winc -   <CR><C-W>

" view sticky {{{1
map Z/ /
map Z<space> <space>
map Z? ?
map ZG GZ
map ZZ Z
map Zb <C-B>Z
map Zd <C-D>Z
map Zf <C-F>Z
map Zg ggZ
map Zh zhZ
map Zj <C-E>Z
map Zk <C-Y>Z
map Zl zlZ
map Zu <C-U>Z
map Zz zzZ

" random commands {{{1
"com!                               Scratch  let ft=&ft|sil %y f|ene|pu f|0d _|let &ft=ft|unlet ft
"com! -nargs=+ -complete=command    Less     let l=execute(<q-args>)|ene|setl bt=nofile nobl noswf|f [less] <args>|cal setline(1, split(l, '\n'))
"com!                               Watch    setl ar|au CursorHold <buffer> checkt
"com!                               ClipEdit ene|setl bh=wipe bt=nofile nobl noswf spell wrap|pu +|0d _|no <buffer> <C-S> :<C-U>%y +<CR>
com!                               Mark     lad expand('%').':'.line('.').':'.getline('.')

com! -nargs=* -complete=file -bang GitDiff  ene|setl bh=wipe bt=nofile fdm=syntax ft=diff      nobl noswf|f [git-diff] <args>|cal setline(1, systemlist('git diff '.(<bang>0?'--staged ':'').<q-args>))|no <buffer> gf ?diff --git<CR>f/l<C-W><C-S>vEgf
com! -nargs=*                      GitLog   ene|setl bh=wipe bt=nofile fdm=syntax ft=todo      nobl noswf|f [git-log] <args> |cal setline(1, systemlist('git log '.<q-args>))
com! -nargs=* -complete=file       GitShow  ene|setl bh=wipe bt=nofile fdm=syntax ft=gitcommit nobl noswf|f [git-show] <args>|cal setline(1, systemlist('git show '.<q-args>))

abc
ca lang se wrap! spell! spl
ca scra se bt=nofile ft
ca hl se hls!

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
  elsei exists('g:neovide')
    se gfn=Monospace:h14
    let g:neovide_hide_mouse_when_typing = v:true
    let g:neovide_scroll_animation_length = 0.15
    let g:neovide_cursor_animation_length = 0.06
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
  map <C-W><C-Z> <C-W><C-^><C-W>H<C-W>60<Bar>
en

" command-line {{{1
cno <C-A> <Home>
cno <C-B> <Left>
cno <C-D> <Del>
cno <C-F> <Right>
cno <C-O> <C-F>
cno <C-X> <C-A>

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
  redr|ec '('.a:d.')'
  let l = [92, 86]
  for k in range(abs(a:d))
    if add(l, getchar())[-1] < 32 || 126 < l[-1]|retu|en
    if 39 == l[-1]|cal add(l, 39)|en
  endfo
  let s = "cal search('".join(map(l, 'nr2char(v:val)'), '')."', "
  let g:eak = s.(a:d < 0 ? "'sb', line('w0'))" : "'sz', line('w$'))")
  let g:kae = s.(a:d < 0 ? "'sz', line('w$'))" : "'sb', line('w0'))")
  exe g:eak
  if has('patch-8.3.1978') || has('nvim')
    let g:eak = "\<Cmd>".g:eak."\<CR>"
    let g:kae = "\<Cmd>".g:kae."\<CR>"
  el
    let g:eak = ":\<C-U>".g:eak."\<CR>"
    let g:kae = ":\<C-U>".g:kae."\<CR>"
  en
endf
if has('patch-8.3.1978') || has('nvim')
  no s <Cmd>cal <SID>neak(2)<CR>
  no S <Cmd>cal <SID>neak(-2)<CR>
el
  no s :<C-U>cal <SID>neak(2)<CR>
  no S :<C-U>cal <SID>neak(-2)<CR>
en
for r in ['t','T','f','F']
  exe 'nn '.r.' :unl! g:eak g:kae<CR>'.r
endfo
no <expr> ; get(g:,'eak',';')
no <expr> , get(g:,'kae',',')

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

" align by with 'g={motion}' {{{1
fu s:lignby(ty='')
  if '' == a:ty
    se opfunc=<SID>lignby
    retu 'g@'
  en
  let pat = input('align pattern: ')
  let st = getpos("'[")[1]
  let ed = getpos("']")[1]
  let far = 0
  let lines = []
  let offsets = []
  for k in range(st, ed)
    let cur = add(offsets, match(add(lines, getline(k))[-1], pat))[-1]
    if far < cur | let far = cur | en
  endfo
  for k in range(st, ed)
    let ln = remove(lines, 0)
    let off = remove(offsets, 0)
    cal setline(k, ln[:off-1].repeat(' ', far-off).ln[off:])
  endfo
endfu
nn <expr> g= <SID>lignby()
xn <expr> g= <SID>lignby()
nn <expr> g== <SID>lignby().'_'

" splore (file tree - only relative to cwd) {{{1
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
    let ln = line('.')
    let ed = <SID>plore_unfold(matchstr(getline(ln-1), ' (.*)$')[2:-2], indent('.')/&ts-1, ln+1)
    d2
    norm k
    if ln+1 != ed | exec ln.','.(ed-2) 'foldc!' | en
    norm zvj
  en
endf
fu s:plore_apply()
  let lns = getline(1, '$')
  let path = [resolve(getcwd().'/'.lns[0]).'/']
  let scb = []
  for k in range(1, len(lns)-1)
    let m = matchlist(lns[k], '\t\+\(.\{-}\)\( --\d* (\(.*\))\)\?$')
    if !len(m) || '...' == m[1] | con | en
    if '`---' == m[1] | cal remove(path, -1) | con | en
    let name = '/' == m[1][-1:] || '*' == m[1][-1:] ? m[1][:-2] : m[1]
    let full = join(path,'').name
    if '/' == m[1][-1:] | cal add(path, m[1]) | en
    if m[3] == full | con | en
    if len(m[3])
      let ln = len(name) ? "rename('".m[3]."', '".full."')" : "delete('".m[3]."'".('/' == m[1][-1:] ? ", 'rf')" : ")")
    el
      let ln = '/' == m[1][-1:] ? "mkdir('".full."'".(name =~ '/' ? ", 'p')" : ")") : "writefile([], '".full."')"
    en
    cal add(scb, ln)
    echom ln
  endfo
  if !len(scb) | setl nomod | retu | en
  if 1 == confirm('do?', "&Yes\n&No", 2)
    for s in scb | exe 'cal' s | endfo
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
fu s:plore(bang, dir)
  if !len(a:dir) && 'splore://' == @%[:8]
    if !a:bang | retu | en
    let d = @%[9:]
    %d
  el
    let d = trim(expand(len(a:dir) ? a:dir : '.'), '/\', 2).'/'
    try
      exe 'b' 'splore://'.d
      if a:bang | %d | el | retu | en
    cat
      ene
      exe 'f' 'splore://'.d
    endt
  en
  let pul = &ul
  setl bt=acwrite cole=3 et fdm=marker fdt=repeat('\|\ \ ',indent(v:foldstart)/&ts).matchstr(getline(v:foldstart),'\\t\\+\\zs.*\\ze\ --').'\ +'.(v:foldend-v:foldstart-1) fen fmr=/\ --,--- ft=splore inde=indent(v:lnum-1)+((getline(v:lnum-1)=~'\ --\\d\\+\ (.*)$')-(getline(v:lnum)=~'`---'))*&ts indk=/,o,0=`-- inex=matchstr(getline('.'),'\ (\\zs.*\\ze)$') lcs=tab:\|\  list noet noswf sw=0 ts=3 ul=-1
  au BufWriteCmd <buffer> cal <SID>plore_apply()
  cal setline(1, d)
  cal <SID>plore_unfold(resolve(getcwd().'/'.d), 0, 1)
  au CursorMoved <buffer> cal <SID>plore_dotdotdot()
  sy match Conceal / --\d* (.*)$/ conceal
  sy match Statement /[^ /]\+\//
  sy match Structure /[^ *]\+\*/
  sy match Comment /`---/
  nn <buffer> zp $h:<C-U>bel vert ped <cfile><CR><C-W>48<Bar>0
  nn <buffer> zP $h:<C-U>bel ped <cfile><CR><C-W>48_0
  let &ul = pul
  setl nomod
endf
com! -complete=dir -nargs=? -bang Splore cal <SID>plore(<bang>0, <q-args>)
exe 'hi Folded ctermbg=NONE guibg=NONE' execute('hi Statement')[20:]

" buffer pick/drop/rename {{{1
fu s:ebuffers_apply(bufdo)
  let nls = getline(1, '$')
  let k = 0
  let c = a:bufdo
  let d = 0
  for l in b:ls
    let nr = matchstr(l, '^\s*\d\+')
    if k < len(nls) && nls[k][:len(nr)-1] == nr
      let nn = matchstr(nls[k], '"[^"]\+"')
      if matchstr(l, '"[^"]\+"') != nn
        exe 'b' nr '|f' nn[1:-2]
        if @# != @% | sil! bw # | en
        if filereadable(@%) | setl mod | en
      en
      let k+= 1
    el
      let d = 1
      let c.= nr
    en
  endfo
  if d | exe c | en
endf
fu s:ebuffers(bang)
  let pnr = bufnr()
  let pls = split(execute('ls'.a:bang), '\n')
  bel 10sp|ene|setl bh=wipe bt=nofile cul nobl noswf
  exe 'f [Buffer List'.a:bang.']'
  let pul = &ul
  setl ul=-1
  let b:ls = pls
  cal matchadd('String', '"[^"]*"')
  cal matchadd('Comment', '\%6ch')
  cal matchadd('Special', '\%6ca')
  cal matchadd('Comment', '^\s*\d\+u.*$')
  %d _
  cal setline(1, b:ls)
  au BufLeave <buffer> ++once cal clearmatches()
  exe 'au BufLeave <buffer> ++once cal <SID>ebuffers_apply("' ('!'==a:bang?'bw':'bd') '")'
  map <buffer> <silent> <CR> :<C-U>let l=getline('.')<Bar>bw<Bar>exe ''==l?'ene':'b'.matchstr(l,'^\s*\d\+')<Bar>unl l<CR>
  sil! exe '/^\s*'.pnr.'\D'
  norm! zz
  let &ul = pul
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

" navigate undo tree visually {{{1
" FIXME: do apply without switching buffer
fu s:eundotree_pr(nodes, cur, depth)
  let d = a:depth+1
  let ind = repeat('  ', d)
  for n in a:nodes
    cal append('$', ind.(a:cur == n.seq ? '('.n.seq.')' : n.seq))
    if has_key(n, 'alt')
      cal s:eundotree_pr(n.alt, a:cur, d)
    en
  endfo
endf
fu s:eundotree()
  let x = undotree()
  let b = bufnr()
  abo 20vs|ene|setl bh=wipe bt=nofile nobl noswf nonu nornu
  exe 'f [undotree -' bufname(b).']'
  cal s:eundotree_pr(x.entries, x.seq_cur, 0)
  1d
  setl noma
  /(
  exe 'no <buffer> <CR> :<C-U>'.b.'bufdo undo <C-R>=getline(".")<CR><CR><C-^>:setl ma<CR>I[<Esc>/(<CR>xf)x/[<CR>r(A)<Esc>^:setl noma<CR>'
endf
com! Eundotree cal <SID>eundotree()

" ASETNIOP layout using mapmode-l {{{1
aug asetniop
  au!
  au InsertEnter * se to tm=100
  au InsertLeave * se noto
aug END
lmapc
let km =<< trim KEYMAP
a a
b fj
c sf
d ds
e d
f fa
g fl
h jk
i k
j js
k ks
l lk
m j;
n j
o l
p ;
q aj
r fd
s s
t f
u jl
v fk
w sa
x da
y jd
z ak
! ;k
@ :K
' ;d
" :D
<BS> ;f
; ;l
: :L
, kd
< KD
. ls
> LS
/ ;a
? :A
( al
[ AL
) ;s
] :S
- ld
_ LD
KEYMAP
for kv in km
  let [k, v] = split(kv)
  exe 'lm' v k
  exe 'lm' v[1].v[0] k
  let u = toupper(k)
  if u != k
    let w = (';'==v[0]?':':toupper(v[0])).(';'==v[1]?':':toupper(v[1]))
    exe 'lm' w u
    exe 'lm' w[1].w[0] u
  en
endfo
unl km k v w

" ansimple (handle a restricted few escape sequences) {{{1
fu! s:ansimple_ft()
    sy match ansimpleConceal /\e\[\d*m/ conceal
    let ww =<< trim ANSIMPLE
      Bold      1  \(0\|22\) =bold
      Underline 4  \(0\|24\) =underline
      Black     30 0         fg=Black
      Red       31 0         fg=Red
      Green     32 0         fg=Green
      Yellow    33 0         fg=Yellow
      Blue      34 0         fg=Blue
      Magenta   35 0         fg=Magenta
      Cyan      36 0         fg=Cyan
      White     37 0         fg=White
ANSIMPLE
    for nsev in ww
      let [n, s, e, v] = split(nsev)
      exe 'sy region ansimple'.n 'concealends matchgroup=ansimpleConceal start=/\e\['.s.'m/  end=/\e\['.e.'\?m/ contains=@ansimpleAll'
      exe 'hi ansimple'.n 'cterm'.v 'gui'.v
    endfo
    exe 'sy cluster ansimpleAll contains='.join(map(ww, '"ansimple".split(v:val)[0]'), ',')
    se cocu=nc cole=3
endf
au FileType ansimple cal <SID>ansimple_ft()

" surveil (update a copy-buffer and filter with command) {{{1
fu s:urveil(buf, com='%!cat')
  let nr = bufnr(a:buf)
  if bufnr() == nr|bel 30vs|en
  ene|setl bt=nofile noswf
  exe 'f [surveil -' a:buf.']' escape(a:com, '%#\$!<*')
  let menr = bufnr()
  let b:urveil = a:com
  exe 'aug surveil'.menr
  exe 'au surveil'.menr 'BufWritePost <buffer='.nr.'> let b:w=win_findbuf('.menr.')|if len(b:w)|cal deletebufline('.menr.',1,"$")|cal setbufline('.menr.',1,getbufline('.nr.',1,"$"))|cal win_execute(b:w[0],"noau ".getbufvar('.menr.',"urveil"))|en|unl b:w'
  aug END
  exe 'au BufDelete <buffer> ++once au! surveil'.menr.'|aug! surveil'.menr
endf
com! -nargs=+ -complete=buffer Surveil cal <SID>urveil(<f-args>)

" netrw, I don't like you :< {{{1
let g:netrw_banner      = 0
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
let g:netrw_preview     = 1
let g:netrw_winsize     = 25
aug netrw_mapping
  au FileType netrw sil! unm <buffer> s
  au FileType netrw sil! unm <buffer> S
aug END

" modeline {{{1
" vim: se fdm=marker fdl=0 ts=2:
