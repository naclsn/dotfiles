se et gd hid lcs=tab:>\ ,trail:~ list ls=2 mouse=nv mps=(:),{:},[:],<:> nohls nowrap nu rnu ts=4 scf sw=0 ww=h,l
se gfn=Monospace\ 14 go-=TL go+=d
colo slate
let g:netrw_liststyle=3

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

fu s:plop(at)
  let niw = getpos(a:at)[1:2]
  let cur = get(w:, "reflocs", [])
  let l = len(cur)
  let k = 0
  wh k < l && (cur[k][0] < niw[0] || cur[k][0] == niw[0] && cur[k][1] < niw[1])
    let k+= 1
  endw
  let w:reflocs = insert(cur, niw, k)
  ec "complete new list:"
  for it in cur
    ec "\t".join(it, ",")
  endfo
endf
fu s:reflect(count, com)
  let at = getpos('.')
  for l in w:reflocs
    cal setpos('.', [0, l[0], l[1], 0])
    exe "norm! ".a:count.a:com
  endfo
  cal setpos('.', at)
endf
fu s:mult()
  let w:multpy = 1
  for m in "BEHJKLWbehjklw" " TODO: fst
    exe "map <silent> ".m." :<C-U>cal <SID>reflect(v:count, '".m."')<CR>:norm! ".m."<CR>"
  endfo
  aug multaug
    au!
    au TextChanged * cal <SID>reflect(v:count, '.')
  aug END
  setl stl=%f\ %h%w%m%r\ %=...
  redr
  ec "-- MULTIPLE --"
endf
fu s:unmult()
  aug multaug
    au!
  aug END
  aug! multaug
  for m in "BEHJKLWbehjklw"
    exe "unm ".m
  endfo
  unl w:multpy
  setlocal stl=
  redr
  echo ""
endf
nn <silent> <C-Q> :<C-U>if exists("w:multpy")<CR>cal <SID>unmult()<CR>el<CR>cal <SID>mult()<CR>en<CR>
nn gc :<C-U>call <SID>plop('.')<CR>
