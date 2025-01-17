" g: variables {{{1
if &cp || exists('g:loaded_vimno') |fini |en
let g:loaded_vimno = 1

if !exists('g:vimno_state') |let g:vimno_state = expand('~/.cache/vimno/') |en
if '/' != g:vimno_state[-1:] |let g:vimno_state..= '/' |en

" NOTE: this is a vim default, in that nvim only has perl/pyth/ruby
if !exists('g:vimno_avail_ifs') |let g:vimno_avail_ifs = split('tcl lua pe[rl] py[thon] rub[y] mz[scheme]') |en
cal map(g:vimno_avail_ifs, '"]" == v:val[-1:] ? substitute(v:val, ''\v(\w+)\[(\w*)]'', ''\1\2|\1'', "") : v:val')

" syntax thing: if
" sy include  @sh syntax/sh.vim
" sy region - contained matchgroup=vimnoComment1 start=/-/ end=/-/ contains=@sh
for i in g:vimno_avail_ifs " TODO/FIXME: why does it only work for the first one?
  let n = split(i, '|')[0]
  try
    exe 'sy include @'..n 'syntax/'..n..'.vim'
  cat /E484:/
    con
  endt
  exe 'sy region vimnoPreIF'..n 'matchgroup=vimnoPreDelim start=/^{{{\v[!+-]?%('..i..')>.*/ end=/^}}}$/ contains=@'..n
endfo

fu Freeze(var, do_write=v:true)
  let l:for_buf = expand('%:p')->substitute('/', '%', 'g')
  let l:and_var = a:var !~ '^\([abglstvw]:\|\$\)' ? 'g:'..a:var : a:var
  let l:path = g:vimno_state..l:for_buf..l:and_var
  if a:do_write
    let l:val = {v:var}
    if v:t_string != type(v:val) |let v:val = v:val->split('\n') |en
    cal writefile(l:val, l:path)
  en
  retu l:path
endf

fu Curl(url, head, data)
  let l:url = a:url
  let l:method = l:url->matchstr('^\u\+ ')
  if !empty(l:method) |cal add(l:com, l:method[:-2]) |en
  let l:url = l:url[l:method->len():]
  if a:url !~ '^\l\+://' |let l:url..= 'https://' |en

  let l:com = ['curl', '-s', l:url]

  for l:k in a:head->keys()
    cal add(l:com, $'-H{l:k}:{a:head[l:k]}')
  endfo

  if v:t_dict == a:data->type()
    for l:k in a:data->keys() |cal add(l:com, $'-d{l:k}={a:head[l:k]}') |endfo
  el
    for l:d in a:data->keys() |cal add(l:com, '-d'..l:d) |endfo
  en

  echom l:com
  retu l:com->system()
endf

com -nargs=+ Curl ene |cal Curl(<f-args>)->setline()

" vim: se fdm=marker fdl=0 ts=2:
