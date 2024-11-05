" Vim filetype plugin for (TODO).
" Last Change:	2024 Nov 4
" Maintainer:	a b <a.b@c.d>
" License:	This file is placed in the public domain.
"
"  Just, know what you're using and doing-

" g: variables {{{1
if &cp || exists('g:loaded_vimotes') |fini |en
let g:loaded_vimotes = 1

if !exists('g:vimotes_state') |let g:vimotes_state = expand('~/.cache/vimotes/') |en
if '/' != g:vimotes_state[-1:] |let g:vimotes_state..= '/' |en

" s: functions {{{1
fu s:Echo(n, val)
  echom a:val
  let n = a:n ?? (line('.')+localtime())%9999
  exe '-5/^\s*'..(a:n ? n : '')..'Ec\(ho\)\?/'
  let i = matchstr(getline('.'), '^\s*')
  exe 's/^\s*\zs\d*/'..n
  if a:n |sil /^\(\s*\\\)\@!/;/^\(\s*"| \)\@!/-d |sil - |en
  let l = 3 == type(a:val) ? a:val : split(a:val, "\n")
  cal append('.', map(l, ''''..i..' "| ''..v:val'))
endf

fu s:Let(bang, var, eq, ...)
  if '>' == a:var[0]
    let d = g:vimotes_state..substitute(expand('%:p'), '/', '%', 'g')..'/'
    cal mkdir(d, 'p')
    let d..= a:var[1+('$'==a:var[1]):]
    exe 'let' substitute(a:var[1:], '\.', '_', 'g') '= d'
  en
  if !a:bang && '>' == a:var[0] && filereadable(d) |retu |en
  let com = join(a:000)
  echom com
  let r = '!' == com[0] ? system(com[1:]) : execute(com)
  echo r
  if '>' == a:var[0] |cal writefile(split(r, "\n"), d) |el |exe 'let' a:var a:eq 'trim(r)' |en
endf

fu s:Source(bang)
  let p = getpos('.')
  if a:bang
    g/^{{{vimotes.*/+,/^}}}$/-so
  el
    +?^{{{vimotes.*?+;/^}}}$/-so
  en
  cal setpos('.', p)
endf

" syntax {{{1
fu s:Syntax()
  if exists('b:current_syntax') |retu |en
  sy spell toplevel
  sy sync fromstart
  " TODO: Conceal for Echo ids
  sy match    vimotesComment1  /\(^\|\s\)"\{1,2}\( .*\|$\)/ contains=vimotesTodo
  sy region   vimotesComments  start=/"""\\/ end=/"""/ contains=vimotesTodo
  sy keyword  vimotesTodo      contained TODO FIXME XXX NOTE
  sy match    vimotesHeading   /^#\{1,4} .*/ contains=vimotesBold,vimotesCode,vimotesItalic,vimotesLink,vimotesMaths,vimotesStrike,vimotesUnderline
  sy match    vimotesListMark  /^\s*\(\a\|\d*\)\. /
  sy match    vimotesBold      /\V**\S\(\.\{-}\S\)\?**/
  sy match    vimotesCode      /\V``\S\(\.\{-}\S\)\?``/ contains=@NoSpell
  sy match    vimotesItalic    +\V//\S\(\.\{-}\S\)\?//+
  sy match    vimotesLink      /\V[[\S\(\.\{-}\S\)\?]]/ contains=@NoSpell
  sy match    vimotesMaths     /\V$$\S\(\.\{-}\S\)\?$$/
  sy match    vimotesStrike    /\V~~\S\(\.\{-}\S\)\?~~/
  sy match    vimotesUnderline /\V__\S\(\.\{-}\S\)\?__/
  sy region   vimotesPre       matchgroup=vimotesPreDelim start=/^{{{.*/ end=/^}}}$/ contains=@NoSpell
  sy region   vimotesPreV      matchgroup=vimotesPreDelim start=/^{{{vimotes.*/ end=/^}}}$/ contains=@NoSpell,@vimotesExpr,vimotesComment1,vimotesCommand,vimotesLet,vimotesShell,vimotesResult
  sy region   vimotesResult    contained matchgroup=vimotesComment1 start=/^\s* "|/ end=/$/ contains=@NoSpell
  sy match    vimotesLineC     contained /^\s*\\/
  sy cluster  vimotesExpr      contains=vimotesNum,vimotesStr,vimotesCall,vimotesVar,vimotesOp
  sy match    vimotesNum       contained /0o\?\o\+\|0x\h\+\|0b[01]\+\|\d\+\(\.\d\+\)\?/
  sy match    vimotesStr       contained /'[^']*\('\|$\)\|"\(\\"\|[^"]\)*\("\|$\)/ contains=@NoSpell
  sy match    vimotesCall      contained /\([abglstvw]:\|\<\h\)\(\w\|{[^}]\+}\)*\ze\s*(/ contains=@NoSpell
  sy match    vimotesVar       contained /\([$@&]\|[abglstvw]:\|\<\h\)\(\w\|{[^}]\+}\)*/ contains=@NoSpell
  sy match    vimotesOp        contained /[-+/*%.<=>&{|}!]\|\<in\>/
  sy region   vimotesCommand   contained matchgroup=vimotesKeyword start=/^\v\s*(\d*Echo|break|call|const|continue|echo|echom|else|elseif|endfor|endfunc|endif|endwhile|for|func|if|lockvar|return|unlet|unlockvar|while)!?/ skip=/\n\s*\\/ end=/$/ keepend contains=vimotesLineC,@vimotesExpr,vimotesComment1
  sy region   vimotesLet       contained matchgroup=vimotesKeyword start=/^\s*[Ll]et!\?/ skip=/\n\s*\\/ end=/$/ keepend contains=vimotesLineC,vimotesShell,@vimotesExpr,vimotesComment1
  sy region   vimotesShell     contained matchgroup=vimotesKeyword start=/!/ skip=/\n\s*\\/ end=/$/ contains=@NoSpell,vimotesLineC,vimotesShellStr,vimotesShellVar,vimotesShellOp,vimotesStr
  sy region   vimotesShellStr  contained start=/"/ skip=/\\"/ end=/"/ contains=@NoSpell,vimotesShellVar
  sy match    vimotesShellVar  contained /$\h\w*\|${\h\w\+}/ contains=@NoSpell
  sy match    vimotesShellOp   contained /\s[-+]\{1,2}\S\+\|[<|&>]/ contains=@NoSpell
  hi def link vimotesComment1  Comment
  hi def link vimotesComments  Comment
  hi def link vimotesHeading   Title
  hi def link vimotesListMark  Statement
  hi def link vimotesPreDelim  Special
  hi def      vimotesBold      cterm=bold          gui=bold
  hi def      vimotesItalic    cterm=italic        gui=italic
  hi def link vimotesLink      Underlined
  hi def      vimotesStrike    cterm=strikethrough gui=strikethrough
  hi def      vimotesUnderline cterm=underline     gui=underline
  hi def link vimotesKeyword   Keyword
  hi def link vimotesLineC     Comment
  hi def link vimotesNum       Number
  hi def link vimotesStr       String
  hi def link vimotesCall      Function
  hi def link vimotesVar       Identifier
  hi def link vimotesOp        Operator
  hi def link vimotesShellStr  String
  hi def link vimotesShellVar  Identifier
  hi def link vimotesShellOp   Operator
endf

" filetype {{{1
fu s:FileType()
  if exists('b:did_ftplugin') |retu |en
  let b:did_ftplugin = 1
  let b:undo_ftplugin = 'setl cole< com< cms< flp< ofu< syn< tfu< |delc -buffer Echo |delc -buffer Let |delc -buffer Source |nun <buffer> gO'
  setl cole=3 com=b:\"\",b:\",fb:.,b:\\ cms=\"\"\"\\%s\"\"\" flp=^\\v\\s*(\\a\|\\d*).\  ofu=s:Complete syn=vimotes tfu=s:Tag
  com -buffer -nargs=1 -complete=expression -range=0 -addr=other Echo   cal s:Echo(<count>, <args>)
  com -buffer -nargs=+ -complete=command    -bang                Let    cal s:Let(<bang>0, <f-args>)
  com -buffer                               -bang                Source cal s:Source(<bang>0)
  nn <buffer> gO :<C-U>lv /^#\{1,4} [^#]\+/j % <Bar>lop<CR>
  if !exists('b:did_indent')
    let b:did_indent = 1
    let b:undo_indent = 'setl inde< indk<'
    setl inde=s:Indent() indk+=0=end
  en
endf

fu s:Complete(findstart, base)
  if a:findstart
    retu match(getline('.')[:col('.')-2], '\($\|[bgtvw]:\|\<\h\)\w*')-1
  el
    let e = '$' == a:base[0]
    retu sort(filter(e ? keys(environ()) : map(split(execute('let'), "\n"), 'split(v:val)[0]'), 'a:base['..e..':]==v:val[:'..(len(a:base)-1-e)..']'))
  en
endf

fu s:Tag(pattern, flags, info)
  retu v:null " TODO
endf

fu s:Indent()
  let n = prevnonblank(v:lnum-1)
  return indent(n) + ((getline(n) =~ '^\\v\\s*(if\|elseif\|for\|while\|func)') - (getline('.') =~ '^\\s*end'))*&ts
endf

" autocommands {{{1
au Syntax vimotes cal s:Syntax()
au FileType vimotes cal s:FileType()
au BufNewFile,BufRead *.vimotes setf vimotes

" vim: se fdm=marker fdl=0 ts=2:
