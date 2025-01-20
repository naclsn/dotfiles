" Vim filetype plugin for a sort of "interactive/exploratory" workflow.
"
" This is a short file that really doesn't provide that much but a few tools;
" the main point is the workflow itself, this can work with plain Vim.
"
" Last Change:	2025 Jan 18
" Maintainer:	a b <a.b@c.d>
" License:	This file is placed in the public domain.
"
"  Just, know what you're using and doing-

" g: variables {{{1
"if &cp || exists('g:loaded_vimno') |fini |en
"let g:loaded_vimno = 1

if !exists('g:persistate') |let g:persistate = expand('~/.cache/vimno/') |en
if '/' != g:persistate[-1:] |let g:persistate..= '/' |en

com SourceFold exe foldlevel() ? "norm! [zms'']z:'s,so\<CR>''" : ''
nn zS :SourceFold<CR>

" REM:
"   g:vimsyn_embed == 0   : don't embed any scripts
"   g:vimsyn_embed =~# 'l' : embed Lua
"   g:vimsyn_embed =~# 'm' : embed MzScheme
"   g:vimsyn_embed =~# 'p' : embed Perl
"   g:vimsyn_embed =~# 'P' : embed Python
"   g:vimsyn_embed =~# 'r' : embed Ruby
"   g:vimsyn_embed =~# 't' : embed Tcl

" s: functions {{{1
fu s:filetype()
  if exists('g:vimsyn_folding') && (g:vimsyn_folding =~# '[hl]')
    com! -bar -nargs=+ VimFoldl <args> fold |el
    com! -bar -nargs=+ VimFoldl <args>      |en
  if g:vimsyn_embed =~# 'l' |VimFoldl sy region vimLuaRegion      matchgroup=vimLetHereDocStart start=+=<<\s*\%(trim\s*\)\?\%(eval\s*\)\?\%(trim\s*\)\?\z(LUA\S*\)+  end=+^\s*\z1$+ contains=@vimLuaScript      |en
  if g:vimsyn_embed =~# 'm' |VimFoldl sy region vimMzSchemeRegion matchgroup=vimLetHereDocStart start=+=<<\s*\%(trim\s*\)\?\%(eval\s*\)\?\%(trim\s*\)\?\z(MZ\S*\)+   end=+^\s*\z1$+ contains=@vimMzSchemeScript |en
  if g:vimsyn_embed =~# 'p' |VimFoldl sy region vimPerlRegion     matchgroup=vimLetHereDocStart start=+=<<\s*\%(trim\s*\)\?\%(eval\s*\)\?\%(trim\s*\)\?\z(PERL\S*\)+ end=+^\s*\z1$+ contains=@vimPerlScript     |en
  if g:vimsyn_embed =~# 'P' |VimFoldl sy region vimPythonRegion   matchgroup=vimLetHereDocStart start=+=<<\s*\%(trim\s*\)\?\%(eval\s*\)\?\%(trim\s*\)\?\z(PY\S*\)+   end=+^\s*\z1$+ contains=@vimPythonScript   |en
  if g:vimsyn_embed =~# 'r' |VimFoldl sy region vimRubyRegion     matchgroup=vimLetHereDocStart start=+=<<\s*\%(trim\s*\)\?\%(eval\s*\)\?\%(trim\s*\)\?\z(RUBY\S*\)+ end=+^\s*\z1$+ contains=@vimRubyScript     |en
  if g:vimsyn_embed =~# 't' |VimFoldl sy region vimTclRegion      matchgroup=vimLetHereDocStart start=+=<<\s*\%(trim\s*\)\?\%(eval\s*\)\?\%(trim\s*\)\?\z(TCL\S*\)+  end=+^\s*\z1$+ contains=@vimTclScript      |en
  delc VimFoldl

  " Adds Support For: >vim
  "     let script =<<SH
  "       # this should have sh highlight
  "       echo hello
  "     SH
  " <
  cal IncludeSyntax('sh')

  " For Example: >vim
  "     let x = systemlist(cmd)
  "     cal writefile(x, b:state..'/a.txt')
  " < see |Store|
  let b:state = g:persistate..expand('%:p')->substitute('/', '%', 'g')
  ev b:state->mkdir('p')
endf

" public functions {{{1
fu IncludeSyntax(syntax, Name='', TAG='')
  let l:Name = empty(a:Name) ? a:syntax->fnamemodify(':t:r')->substitute('^\w', {c -> c[0]->toupper()}) : a:Name
  let l:TAG = empty(a:TAG) ? a:Name->toupper() : a:TAG

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

fu Storable(var, ext='txt')
  retu a:var !~ '^\$\|^\l:' ? 'g:'..a:var : a:var
endf

fu Storage(var, ext='txt')
  retu b:state..'/'..Storable(a:var, a:ext)..'.'..a:ext
endf

fu Store(var, ext='txt')
  let l:var = Storable(a:var, a:ext)
  ev {l:var}->writefile(Storage(l:var))
endf

fu Restore(var, ext='txt')
  let l:var = Storable(a:var, a:ext)
  let {l:var} = readfile(Storage(l:var))
endf

fu Curl(url, head, data) abort
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
  retu l:com->systemlist()
endf

" vim: se fdm=marker fdl=0 ts=2:
