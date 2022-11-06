command! -nargs=1 Indent set tabstop=<args> shiftwidth=<args>
set gd hid lcs=tab:>\ ,trail:~ list ls=2 mouse=nv mps=(:),{:},[:],<:> nohls nowrap nu rnu scf ww=h,l

nn <BS> ciw
nn <C-C> :<C-U>q<CR>
nn <C-L> :<C-U>exe get(w:,"rex","Ex")\|let w:rex="Rex"<CR>
nn <C-N> :<C-U>bn<CR>
nn <C-P> :<C-U>bp<CR>
nn <C-S> :<C-U>w<CR>
no g. `^

" TODO: find decent mappings (eg. cant use 'r', 'am' and 'im' have delays/timeouts...)
vn am <Esc>%v%
vn im <Esc>%v%<Esc>`>hv`<l
for [o,c] in map(split(&mps,","),'split(v:val,":")')
  for s in [o,c]
    exe "nn dm".s." va".o."<Esc>dlgvo<Esc>dl"
    exe "vn am".s." <Esc>`>a".c."<Esc>`<i".o."<Esc>"
    exe "vn im".s." <Esc>`>i".c."<Esc>`<a".o."<Esc>"
    for [oo,cc] in map(split(&mps,","),'split(v:val,":")')
      for ss in [oo,cc]
        exe "nn rm".s.ss." va".o."<Esc>r".cc."gvo<Esc>r".oo
      endfo
    endfo
  endfo
endfo

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
  exe ":norm! ".v:count.w:eak
  cal histdel("/", -1)
endf
no s :<C-U>call <SID>neak(2)<CR>
no S :<C-U>call <SID>neak(-2)<CR>
for r in "tTfF"
  exe "nn ".r." :unl! w:eak w:kae<CR>".r
endfo
" XXX: impacts '/' hist...
no <expr> ; get(w:,"eak",";")
no <expr> , get(w:,"kae",",")

" TODO: autocmds of interest:
"       - CursorMoved
"       - InsertLeave
"       - ModeChanged
"       - TextChanged
"       - TextYankPost

cno <C-A> <Home>
cno <C-B> <Left>
cno <C-D> <Del>
cno <C-F> <Right>
