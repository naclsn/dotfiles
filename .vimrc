se et gd hid is lcs=tab:>\ ,trail:~ list ls=2 mouse=nv mps=(:),{:},[:],<:> nohls nowrap nu rnu ts=4 scf sw=0 udf ww=h,l
se dir=~/.vim/cache/swap// udir=~/.vim/cache/undo//
se go-=T go-=L go+=d

if has('win16') || has('win32') || has('win64')
  se gfn=Consolas:h14 sh=powershell
el
  se gfn=Monospace\ 14
en

colo slate
sy on

let g:netrw_banner      = 0
" TODO: look again
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
let g:netrw_liststyle   = 3
let g:netrw_preview     = 1
let g:netrw_winsize     = 30
nn <C-L> :<C-U>exe get(w:,"rex","Ex")\|let w:rex="Rex"<CR>

com Scratch sil %y f|ene|pu f|0d

nn <BS> ciw
nn <C-C> :<C-U>q<CR>
nn <C-N> :<C-U>bn<CR>
nn <C-P> :<C-U>bp<CR>
nn <C-S> :<C-U>w<CR>

cno <C-A> <Home>
cno <C-B> <Left>
cno <C-D> <Del>
cno <C-F> <Right>
" TODO: maybe even more if gvim (ie. ^[b ^[f ^[d ...)
cno <C-X> <C-A>

let pairs = map(split(&mps,","),'split(v:val,":")')+[['"','"'],["'","'"],["`","`"]]
for [o,c] in pairs
  for s in [o,c]
    for [oo,cc] in pairs
      for ss in [oo,cc]
        exe "nn z".s.ss." va".o."<Esc>r".cc."gvo<Esc>r".oo."``"
      endfo
    endfo
  endfo
endfo
unl pairs

fu s:neak(d)
  let d = a:d
  let t = ""
  wh d
    let c = getchar()
    if 27 == c
      retu
    en
    let t.= nr2char(c)
    let d-= 0 < a:d ? 1 : -1
  endw
  let w:eak = (0 < a:d ? "/" : "?").t."\<CR>"
  let w:kae = (0 < a:d ? "?" : "/").t."\<CR>"
  exe "norm! ".v:count.w:eak
endf
" TODO: detect support for <Cmd>, revert to :<C-U>
no s <Cmd>cal <SID>neak(2)<CR>
no S <Cmd>cal <SID>neak(-2)<CR>
for r in ['t','T','f','F']
  exe "nn ".r." :unl! w:eak w:kae<CR>".r
endfo
no <expr> ; get(w:,"eak",";")
no <expr> , get(w:,"kae",",")

fu s:wapb()
  let l = split(execute("ls"), "\n")
  " TODO: add handling of 'd'==key to do :bd
  cal popup_menu(l, { 'callback': {_, r ->0< r ? execute("b ".matchstr(l[r-1], ' *\d\+')) : 0} })
endf
" TODO: binding not decided, would like to have a <C-W> binding for term buffer types
no q; :<C-U>cal <SID>wapb()<CR>

fu s:tree(dir, depth)
  let dir = '/' != a:dir[strlen(a:dir)-1] ? a:dir.'/' : a:dir
  let depth = a:depth+1
  let p = repeat('| ', depth)
  "cal setline('$', [dir]+map(readdir(dir), 'isdirectory(dir.v:val) ? p.v:val."/" : p.v:val'))
  "cal setline('$', [dir]+map(readdir(dir), 'isdirectory(dir.v:val) ? s:tree(dir.v:val."/", depth) : p.v:val'))
  cal setline('$', dir)
  for e in readdir(dir)
    "if isdirectory(dir.e)
    "  cal setline('$', p.e.'/')
    "  cal s:tree(dir.e, depth)
    "el
      cal setline('$', p.e)
    "en
  endfo
endf
fu s:plore(dir)
  "let d = endswith('/') ? as_is : add_it
  let b = bufadd("dir: ".a:dir)
  cal bufload(b)
  exe "b ".b
  se bl bt=nofile noswf
  "cal setline('$', a:dir)
  cal s:tree(a:dir, 0)
  "cal setline(1, ['line 1', 'line 2', 'last line'])
endf
no <C-Q> <Cmd>cal <SID>plore('/tmp/crap')<CR>

" vim: se ts=2:
