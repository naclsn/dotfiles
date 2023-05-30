se et gd hid is lcs=tab:>\ ,trail:~ list ls=2 mouse=nv mps=(:),{:},[:],<:> nohls nowrap nu rnu ts=4 scf sw=0 udf ww=h,l
se gfn=Monospace\ 14 go-=T go-=L go+=d
colo slate
let g:netrw_liststyle=3
let g:netrw_bufsettings='noma nomod nu nobl nowrap ro'

com Scratch sil %y f|ene|pu f|0d

nn <BS> ciw
nn <C-C> :<C-U>q<CR>
nn <C-L> :<C-U>exe get(w:,"rex","Ex")\|let w:rex="Rex"<CR>
nn <C-N> :<C-U>bn<CR>
nn <C-P> :<C-U>bp<CR>
nn <C-S> :<C-U>w<CR>

cno <C-A> <Home>
cno <C-B> <Left>
cno <C-D> <Del>
cno <C-F> <Right>

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
  let v = index(['v','V','\<C-V>'], mode())+1
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
  exe ":norm! ".v:count.w:eak
  if v
    norm gv;
  en
endf
no s :<C-U>cal <SID>neak(2)<CR>
no S :<C-U>cal <SID>neak(-2)<CR>
for r in "tTfF"
  exe "nn ".r." :unl! w:eak w:kae<CR>".r
endfo
no <expr> ; get(w:,"eak",";")
no <expr> , get(w:,"kae",",")
