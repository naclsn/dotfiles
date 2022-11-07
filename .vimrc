set et gd hid lcs=tab:>\ ,trail:~ list ls=2 mouse=nv mps=(:),{:},[:],<:> nohls nowrap nu rnu ts=4 scf sw=0 ww=h,l

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

" XXX: does not work with visual modes
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
no s :<C-U>cal <SID>neak(2)<CR>
no S :<C-U>cal <SID>neak(-2)<CR>
for r in "tTfF"
  exe "nn ".r." :unl! w:eak w:kae<CR>".r
endfo
" XXX: impacts '/' hist
no <expr> ; get(w:,"eak",";")
no <expr> , get(w:,"kae",",")

" TODO: do
fu s:reflect(com)
  echo "reflect: ".a:com
  "exe "norm! ".v:count.a:com
endf
fu s:crap()
  let w:crappy = 1
  for m in "BEHJKLWbehjklw" " TODO: fst
    exe "map <silent> ".m." :<C-U>cal <SID>reflect('".m."')<CR>:norm! ".m."<CR>"
  endfo
  aug crapau
    au!
    au TextChanged * cal <SID>reflect('.')
  aug END
  setlocal stl=%f\ %h%w%m%r\ %=...
  redr
  ec "-- MULTIPLE --"
endf
fu s:uncrap()
  aug crapau
    au!
  aug END
  aug! crapau
  for m in "BEHJKLWbehjklw"
    exe "unm ".m
  endfo
  unl w:crappy
  setlocal stl=
  redr
  echo ""
endf
nn <silent> <C-@> :<C-U>if exists("w:crappy")<CR>cal <SID>uncrap()<CR>el<CR>cal <SID>crap()<CR>en<CR>
