" Vim filetype plugin for a sort of "interactive/exploratory" workflow.
"
" This is a short file that really doesn't provide that much but a few tools;
" the main point is the workflow itself, this can work with plain Vim.
"
" |Primer()| below as a start. But overall the idea is to simply work in
" a file rather than a REPL, more or less like a notebook.
"
"     +,/^\.$/so " :.so on this line to run until the . line
"     let a = 0
"     py print('hi')
"     .
"
"     +,/^\.$/so " works well with the various |if_|, eg |if_pyth|
"     py <<
"     def something():
"         pass
"     .
"
" See also things like |g:vimsyn_embed|.
"
" Actually in this file:
"   * |Primer()|
"   * |Heredoc()|
"   * |Registore()|
"   * |Curl()|
"   * |PP()|, |PPl()| and |PPs()|
"
" Last Change:	2025 Jan 18
" Maintainer:	a b <a.b@c.d>
" License:	This file is placed in the public domain.
"
"  Just, know what you're using and doing-

" public functions {{{1
fu Primer()
  if getline(1) !~ '^+,'
    1i
+,/^\.$/so
ia <buffer> sofence +,/^\.$/so
ia <buffer> upfence +,/^\.$/-d_<Bar>-<Bar>cal append('.',
map <buffer> ]] /^+,<CR>
map <buffer> ][ /^\.$<CR>
map <buffer> [[ ?^+,<CR>
map <buffer> [] ?^\.$<CR>
-
.
    s/-/./
  en
endf

fu Heredoc(syntax, TAG='', Name='')
  " cal Heredoc('sh')
  " let script =<<SH
  "   # this should have sh highlight
  "   echo hello
  " SH
  let l:TAG = empty(a:TAG) ? a:syntax->fnamemodify(':t:r')->toupper() : a:TAG
  let l:Name = empty(a:Name) ? a:TAG->substitute('^\w', {c -> c[0]->toupper()}, '') : a:Name

  unl b:current_syntax
  exe 'sy include @vim'..a:Name..'Script'
    \ a:syntax =~ '/' ? a:syntax : 'syntax/'..a:syntax..'.vim'
  exe 'sy region vim'..a:Name..'Region'
    \ 'matchgroup=vimLetHereDocStart'
    \ 'start=+=<<\s*\%(trim\s*\)\?\%(eval\s*\)\?\%(trim\s*\)\?\z('..a:TAG..'\S*\)+'
    \ 'end=+^\s*\z1$+'
    \ 'contains=@vim'..a:Name..'Script'
    \ exists('g:vimsyn_folding') && (g:vimsyn_folding =~# '[hl]') ? 'fold' : ''
  exe 'sy cluster vimFuncBodyList'
    \ 'add=vim'..a:Name..'Region'
  let b:current_syntax = 'vim'
endf

fu Registore(var='') abort
  " a:var is a var name with optional .ext (eg 'g:some.json', g: optional)
  " * var exists -> store it
  " * var doesn't exist -> load it
  " * a:var itself empty -> only set b:state
  " return path
  if !exists('b:state')
    let b:state = g:->get('registore', expand('~/.cache/vimno/'))..expand('%:p')->substitute('/', '%', 'g')
    ev b:state->mkdir('p')
  en
  if empty(a:var) |retu |en

  let l:var = (a:var !~ '^\$\|^\l:' ? 'g:' : '')..a:var->fnamemodify(':r')
  let l:ext = a:var->fnamemodify(':e') ?? 'txt'

  let l:dst = b:state..'/'..l:var..'.'..l:ext
  if exists(l:var)
    ev {l:var}->writefile(l:dst)  |el
    let {l:var} = readfile(l:dst) |en
  retu l:dst
endf

fu Curl(url, head, data, dry=v:null) abort
  " url may be: [METHOD] [proto://][...]
  " * perdu.com -> GET to https://perdu.com
  " * http://perdu.com -> GET to http://perdu.com
  " * GET .. -> GET .. but use -G and --data-urlencode
  " head is a dict, data may be dict or list
  " if dry not null then return that without doing the thing
  let l:url = a:url
  let l:method = l:url->matchstr('^\u\+ ')
  let l:url = l:url[l:method->len():]
  if l:url !~ '^\l\+://' |let l:url = 'https://'..l:url |en

  let l:com = ['curl', '-so-', l:url]

  let l:encode = v:false
  if !empty(l:method)
    if 'GET ' == l:method && l:url =~ '^http'
      let l:encode = v:true
      cal add(l:com, '-G')
    el
      cal add(l:com, '-X'..l:method[:-2])
    en
  en

  for l:k in a:head->keys() |cal add(l:com, '-H'..l:k..':'..a:head[l:k]) |endfo

  let l:data = v:t_dict == a:data->type()
    \ ? a:data->keys()->map({_, k -> k..'='..a:data[k]})
    \ : a:data

  for l:it in l:data
    ev l:encode && l:it =~ '=.*[^-0-9A-Z_a-z]'
      \ ? l:com->extend(['--data-urlencode', l:it])
      \ : l:com->add('-d'..l:it)
  endfo

  echom l:com
  retu v:null == a:dry ? l:com->system() : a:dry
endf

" vim: se fdm=marker fdl=0 ts=2:
