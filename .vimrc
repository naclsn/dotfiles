lan C
se ai bs= cot=menuone,noselect cul et fdl=999 fdm=marker ff=unix ffs=unix,dos fo=1cjnr hid is isf-== lbr lcs=tab:>\ ,trail:~ list ls=2 mouse=nrv noea nofen nohls notgc noto nowrap nu rnu ru sc scl=no so=0 spc= ssl sw=0 ts=4 ttimeout ttm=100 udf wim=longest:full,full wmnu wop=pum

" temp (to relocate)
let g:vimsyn_embed = 'pPr'
let g:man_hardwrap = 0

se spf=~/.vim/spell.utf-8.add
se dir=~/.vim/cache/swap//
if has('nvim')
  se rtp^=~/.vim/
  se udir=~/.vim/cache/nundo//
  aun PopUp
  sil! au! nvim_popupmenu
  "colo vim
el
  se udir=~/.vim/cache/undo//
  "colo default
en

se ssop=blank,buffers,folds,globals,options,resize,sesdir,slash,tabpages,terminal,unix,winsize
au SessionLoadPost * if has_key(g:,'Run') |cal execute(g:Run) |en
com Mks exe 'mks'.'!'[empty(v:this_session)] v:this_session

colo slate
sy on
filet on
filet plugin on

au BufEnter * se fo-=o
au FileType c,python sy keyword Title self
au FileType python if !filereadable('Makefile') |setl makeprg=flake8 |en
au FileType python if '0' == &tw |setl tw=88 |en

fu s:black_formatexpr()
  if !empty(v:char) || mode() =~ '[iR]' |retu |en

  let prog = ['black', '--quiet', '-l'..(&tw??78), '-', '--stdin-filename', @%]
  if @% =~ 'pyi$' |ev prog->add('--pyi') |en " is this needed if ^ is given?

  let last = v:lnum+v:count-1
  let inde = range(v:lnum, last)->map('indent(v:val)')->min() / &ts
  let text = ['if():']->repeat(inde)->map('" "->repeat(&ts*v:key)..v:val')->extend(getline(v:lnum, last))
  let fmtd = prog->systemlist(text)[inde:]

  cal deletebufline('%', v:lnum, last)
  cal append(v:lnum-1, fmtd)
endf

au FileType python setl fex=s:black_formatexpr()
au FileType python if expand('<afile>') =~ 'pyi$' |nn <buffer> gqq :!python3 -m black --quiet --pyi %<CR>|el |nn <buffer> gqq :!python3 -m black --quiet -l<C-R>=&tw??78<CR> %<CR>|en

hi clear MatchParen |hi link MatchParen Title
hi clear diffRemoved |hi link diffRemoved Identifier
hi clear diffAdded |hi link diffAdded Special
"hi Normal ctermfg=white ctermbg=black
if has_key(g:, 'terminal_ansi_colors')
  let c = matchstr(execute('hi Normal'), 'guibg=\S\+')[6:]
  let g:terminal_ansi_colors = [c]+g:terminal_ansi_colors[1:]
  exe 'hi Terminal guibg='.c
  unl c
en
au FileType xxd nn <buffer> <C-A> geebi0x<Esc><C-A>b"_2xe |nn <buffer> <C-X> geebi0x<Esc><C-X>b"_2xe

"nm <C-J> :<C-U>tabn<CR>
"nm <C-K> :<C-U>tabp<CR>
"nn <C-C> :<C-U>winc c<CR>
nn <C-N> :<C-U>bn<CR>
nn <C-P> :<C-U>bp<CR>
"nn <C-S> :<C-U>up<CR>

map! <C-Space> <Nop>

abc
ca lang setl wrap! bri! spell! spl
ca scra setl bt=nofile ft
ca hl setl hls!
ca wr setl wrap! bri!
ca pw setl pvw!
ca vb vert sb

"nm U u
"nn + :<C-U>.+
"nn - :<C-U>.-

map <space>f :<C-U>60Lex .<CR><C-W>60<Bar>
map <space>b :<C-U>Ebuffers<CR>
map <space>B :<C-U>Ebuffers!<CR>
map <space>u :<C-U>Eundotree<CR>
map <space>w <C-W>
map <space>y "+y
map <space>p "+p
map <space>P "+P
map <space>l :<C-U>let @+ = @%.':'.line('.')<CR>

"map <C-W><lt> :<C-U>winc <lt><CR><C-W>
"map <C-W>>    :<C-U>winc >   <CR><C-W>
"map <C-W>+    :<C-U>winc +   <CR><C-W>
"map <C-W>-    :<C-U>winc -   <CR><C-W>

" view sticky {{{1
"map Z/ /
"map Z<space> <space>
"map Z? ?
"map ZG GZ
"map ZZ Z
"map Zb <C-B>Z
"map Zd <C-D>Z
"map Zf <C-F>Z
"map Zg ggZ
"map Zh zhZ
"map Zj <C-E>Z
"map Zk <C-Y>Z
"map Zl zlZ
"map Zu <C-U>Z
"map Zz zzZ

" random commands {{{1
"com!                               Scratch  let ft=&ft |sil %y f |ene |pu f |0d _ |let &ft=ft |unlet ft
"com! -nargs=+ -complete=command    Less     let l=execute(<q-args>) |ene |setl bt=nofile nobl noswf |f [less] <args> |cal setline(1, split(l, '\n'))
"com!                               Watch    setl ar |au CursorHold <buffer> checkt
"com!                               ClipEdit ene |setl bh=wipe bt=nofile nobl noswf spell wrap |pu + |0d _ |no <buffer> <C-S> :<C-U>%y +<CR>
com!                               Mark     lad expand('%').':'.line('.').':'.getline('.')

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
en

" command-line {{{1
cno <C-A> <Home>
cno <C-B> <Left>
cno <C-D> <Del>
cno <C-F> <Right>
cno <C-X> <C-F>

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

" sneak movement (multi-char and multi-line 't'/'f') {{{1
fu s:neak(d)
  redr |ec '('.a:d.')'
  let l = [92, 86]
  for k in range(abs(a:d))
    if add(l, getchar())[-1] < 32 || 126 < l[-1] |retu |en
    if 39 == l[-1] |cal add(l, 39) |en
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
unl r
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
        if @# != @% |sil! bw# |en
        if filereadable(@%) |setl mod |en
      en
      let k+= 1
    el
      let d = 1
      let c.= ' '.nr
    en
  endfo
  if d |exe c |en
endf
fu s:ebuffers(bang)
  let pnr = bufnr()
  let pls = split(execute('ls'.a:bang), '\n')
  bel 10sp |ene |setl bh=wipe bt=nofile cul nobl noswf
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
  bel 10sp |ene |setl bh=wipe bt=nofile nobl noswf
  exe 'f [Edit Variable' a:name.']'
  cal setline(1, split(get(g:, a:name, ''), '\n'))
  let nr = bufnr()
  exe 'au BufLeave <buffer> ++once let '.a:name.' = join(getbufline('.nr.', 1, "$"), "\n")'
endf
com! -nargs=1 -complete=var Evariable cal <SID>evariable(<q-args>)

" navigate undo tree visually {{{1
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
  abo 20vs |ene |setl bh=wipe bt=nofile nobl noswf nonu nornu
  exe 'f [undotree -' bufname(b).']'
  cal s:eundotree_pr(x.entries, x.seq_cur, 0)
  1d
  setl noma
  try
    /(
  cat
  endt
  exe 'nn <buffer> zp :'.b.'bufdo undo <C-R>=getline(".")<CR><CR><C-^>:setl bh= ma<CR>I[<Esc>/(<CR>xf)x/[<CR>r(A)<Esc>^:setl bh=wipe noma<CR>'
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
unl km kv k v u w

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
  if bufnr() == nr |bel 30vs |en
  ene |setl bt=nofile noswf
  exe 'f [surveil -' a:buf.']' escape(a:com, '%#\$!<*')
  let menr = bufnr()
  let b:urveil = a:com
  exe 'aug surveil'.menr
  exe 'au surveil'.menr 'BufWritePost <buffer='.nr.'> let b:w=win_findbuf('.menr.') |if len(b:w) |cal deletebufline('.menr.',1,"$") |cal setbufline('.menr.',1,getbufline('.nr.',1,"$")) |cal win_execute(b:w[0],"noau ".getbufvar('.menr.',"urveil")) |en |unl b:w'
  aug END
  exe 'au BufDelete <buffer> ++once au! surveil'.menr.' |aug! surveil'.menr
endf
com! -nargs=+ -complete=buffer Surveil cal <SID>urveil(<f-args>)

" netrw, I don't like you :< {{{1
"let g:netrw_banner      = 0
"let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
"let g:netrw_preview     = 1
"let g:netrw_winsize     = 25
"aug netrw_mapping
"  au FileType netrw sil! unm <buffer> s
"  au FileType netrw sil! unm <buffer> S
"aug END
for n in ['gzip', 'netrw', 'spellfile', 'tar', 'zip']
  let g:loaded_{n} = 1
  let g:loaded_{n}Plugin = 1
  let g:loaded_{n}_plugin = 1
endfo
unl n

fu s:pellfile_wget(lang)
  if 2 == confirm('Download spl/sug for '..a:lang..'?', "&No\n&Yes")
    sil let res = system('wget -B https://ftp.nluug.nl/pub/vim/runtime/spell/ -P "$HOME/.vim/spell" -nvc -i-', [
      \ a:lang.'.utf-8.spl',
      \ a:lang.'.utf-8.sug'])
    ec res
    if res =~ 'failed:\|ERROR' |echoe 'hoe!!' |en
  en
endf
au SpellFileMissing * cal s:pellfile_wget(expand('<amatch>'))

" modeline {{{1
" vim: se fdm=marker fdl=0 ts=2:
