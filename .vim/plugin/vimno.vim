" Vim filetype plugin for interactive notes. Somewhat like a minimal org mode.
" This is a short single file with filetype/indent/syntax/omnifunc/tagfunc.
"
" TODO: example + light doc for :Echo :Let :Source and jobs.
" TODO: comment Echo ids
" TODO: tagfunc
" TODO: jobs
"
" Last Change:	2024 Nov 16
" Maintainer:	a b <a.b@c.d>
" License:	This file is placed in the public domain.
"
"  Just, know what you're using and doing-

" g: variables {{{1
if &cp || exists('g:loaded_vimno') |fini |en
let g:loaded_vimno = 1

if !exists('g:vimno_state') |let g:vimno_state = expand('~/.cache/vimno/') |en
if '/' != g:vimno_state[-1:] |let g:vimno_state..= '/' |en

" s: functions {{{1
fu s:Echo(n, val)
  "" Echos in the document itself; the line with the `Echo` itself is prefixed
  "" with a (hopefully unique) number after first run, which is used to locate
  "" itself on other runs. Output is prefixed with same indentation and '"| '.
  echom a:val
  let n = a:n ?? (line('.')+localtime())%10000
  exe '-5/^\s*'..(a:n ? n : '')..'Ec\(ho\)\?/'
  let i = matchstr(getline('.'), '^\s*')
  exe 's/^\s*\zs\d*/'..n
  if a:n |sil /^\(\s*\\\)\@!/;/^\(\s*"| \)\@!/-d |sil - |en
  let l = 3 == type(a:val) ? a:val : split(a:val, "\n")
  cal append('.', map(l, ''''..i..' "| ''..v:val->trim("", 2)'))
endf

fu s:Let(bang, var, eq, ...)
  "" Similar to :let however the result is stored in a file by the var's name;
  "" the variable will contain the full file path. If the file already existed
  "" it needs `Let!` to force re-computation.
  ""  0. if value starts with !, uses system()
  ""  0. if value starts with :, uses execute()
  ""  0. otherwise it is a normal expression, uses eval()
  let d = g:vimno_state..substitute(expand('%:p'), '/', '%', 'g')..'/'
  cal mkdir(d, 'p')
  let d..= a:var[1+('$'==a:var[0]):]
  exe 'let' substitute(a:var, '\.', '_', 'g') '= d'
  if !a:bang && filereadable(d) |retu |en
  let com = join(a:000)
  echom com
  let r = '!' == com[0] ? system(com[1:]) : ':' == com[0] ? execute(com[1:]) : eval(com)
  echo r
  cal writefile(split(r, "\n"), d)
endf

fu s:Source(bang)
  "" Sources the current (or with `Source!`, every) `{{{vimno }}}` block(s).
  let p = getpos('.')
  if a:bang
    g/^{{{vimno.*/+,/^}}}$/-so
  el
    +?^{{{vimno.*?+;/^}}}$/-so
  en
  cal setpos('.', p)
endf

" syntax {{{1
fu s:Syntax()
  if exists('b:current_syntax') |retu |en
  sy spell toplevel
  sy sync fromstart
  " TODO: Comment for Echo ids
  sy match    vimnoHeading   /^#\{1,4} .*/ contains=vimnoBold,vimnoCode,vimnoItalic,vimnoLink,vimnoMaths,vimnoStrike,vimnoUnderline
  sy match    vimnoListMark  /^\s*\(\a\|\d\+\)\. /
  sy match    vimnoBold      /\V**\S\(\.\{-}\S\)\?**/
  sy match    vimnoCode      /\V``\S\(\.\{-}\S\)\?``/ contains=@NoSpell
  sy match    vimnoItalic    +\V//\S\(\.\{-}\S\)\?//+
  sy match    vimnoLink      /\V[[\S\(\.\{-}\S\)\?]]/ contains=@NoSpell
  sy match    vimnoMaths     /\V$$\S\(\.\{-}\S\)\?$$/
  sy match    vimnoStrike    /\V~~\S\(\.\{-}\S\)\?~~/
  sy match    vimnoUnderline /\V__\S\(\.\{-}\S\)\?__/
  sy region   vimnoPre       matchgroup=vimnoPreDelim start=/^{{{.*/ end=/^}}}$/ contains=@NoSpell
  sy region   vimnoPreV      matchgroup=vimnoPreDelim start=/^{{{-\?vimno.*/ end=/^}}}$/ contains=@NoSpell,@vimnoExpr,vimnoComment1,vimnoCommand,vimnoLet,vimnoShell,vimnoResult
  sy region   vimnoResult    contained matchgroup=vimnoComment1 start=/^\s* "|/ end=/$/ contains=@NoSpell
  sy match    vimnoLineC     contained /^\s*\\/
  sy cluster  vimnoExpr      contains=vimnoNum,vimnoStr,vimnoCall,vimnoVar,vimnoOp
  sy match    vimnoNum       contained /0o\?\o\+\|0x\h\+\|0b[01]\+\|\d\+\(\.\d\+\)\?/
  sy match    vimnoStr       contained /'[^']*\('\|$\)\|"\(\\"\|[^"]\)*\("\|$\)/ contains=@NoSpell
  sy match    vimnoCall      contained /\([abglstvw]:\|\<\h\)\(\w\|{[^}]\+}\)*\ze\s*(/ contains=@NoSpell
  sy match    vimnoVar       contained /\([$@&]\|[abglstvw]:\|\<\h\)\(\w\|{[^}]\+}\)*/ contains=@NoSpell
  sy match    vimnoOp        contained /[-+/*%.<=>&{|}!]\|\<in\>/
  sy region   vimnoCommand   contained matchgroup=vimnoKeyword start=/^\v\s*(\d*Echo|break|call|const|continue|echo|echom|else|elseif|endfor|endfunc|endif|endwhile|for|func|if|lockvar|return|unlet|unlockvar|while)!?/ skip=/\n\s*\\/ end=/$/ keepend contains=vimnoLineC,@vimnoExpr,vimnoComment1
  sy region   vimnoLet       contained matchgroup=vimnoKeyword start=/^\s*[Ll]et!\?/ skip=/\n\s*\\/ end=/$/ keepend contains=vimnoLineC,vimnoShell,@vimnoExpr,vimnoComment1
  sy region   vimnoShell     contained matchgroup=vimnoKeyword start=/!/ skip=/\n\s*\\/ end=/$/ contains=@NoSpell,vimnoLineC,vimnoShellStr,vimnoShellVar,vimnoShellOp,vimnoStr
  sy region   vimnoShellStr  contained start=/"/ skip=/\\"/ end=/"/ contains=@NoSpell,vimnoShellVar
  sy match    vimnoShellVar  contained /$\h\w*\|${\h\w\+}/ contains=@NoSpell
  sy match    vimnoShellOp   contained /\s[-+]\{1,2}\S\+\|[<|&>]/ contains=@NoSpell
  sy match    vimnoComment1  /\(^\|\s\)"\{1,2}\( .*\|$\)/ contains=vimnoTodo
  sy region   vimnoComments  start=/"""\\/ end=/"""/ contains=vimnoTodo
  sy keyword  vimnoTodo      contained TODO FIXME XXX NOTE
  hi def link vimnoHeading   Title
  hi def link vimnoListMark  Statement
  hi def link vimnoPreDelim  Special
  hi def      vimnoBold      cterm=bold          gui=bold
  hi def      vimnoItalic    cterm=italic        gui=italic
  hi def link vimnoLink      Underlined
  hi def      vimnoStrike    cterm=strikethrough gui=strikethrough
  hi def      vimnoUnderline cterm=underline     gui=underline
  hi def link vimnoKeyword   Keyword
  hi def link vimnoLineC     Comment
  hi def link vimnoNum       Number
  hi def link vimnoStr       String
  hi def link vimnoCall      Function
  hi def link vimnoVar       Identifier
  hi def link vimnoOp        Operator
  hi def link vimnoShellStr  String
  hi def link vimnoShellVar  Identifier
  hi def link vimnoShellOp   Operator
  hi def link vimnoComment1  Comment
  hi def link vimnoComments  Comment
  hi def link vimnoTodo      Todo
endf

" filetype {{{1
fu s:FileType()
  if exists('b:did_ftplugin') |retu |en
  let b:did_ftplugin = 1
  let b:undo_ftplugin = 'setl cole< com< cms< flp< ofu< syn< tfu< |delc -buffer Echo |delc -buffer Let |delc -buffer Source |nun <buffer> gO'
  setl cole=3 com=b:\"\",b:\",b:\"\|,fb:.,b:\\ cms=\"\"\"\\%s\"\"\" flp=^\\v\\s*(\\a\|\\d\\+).\  ofu=s:Complete syn=vimno tfu=s:Tag
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
    retu match(getline('.')[:col('.')-2], '\(\$\|[bgtvw]:\|\<\h\)\w*$')
  el
    let e = '$' == a:base[0]
    retu sort(filter(e ? map(keys(environ()), '''$''..v:val') : map(split(execute('let'), "\n"), 'split(v:val)[0]'), 'a:base==v:val[:'..(len(a:base)-1)..']'))
  en
endf

fu s:Tag(pattern, flags, info)
  retu v:null " TODO
endf

fu s:Indent()
  let n = prevnonblank(v:lnum-1)
  return indent(n) + ((getline(n) =~ '\v^\s*<(if|elseif|for|while|func)>') - (getline('.') =~ '^\s*\<end\>'))*&ts
endf

" autocommands {{{1
aug vimno
  au Syntax vimno cal s:Syntax()
  au FileType vimno cal s:FileType()
  au BufNewFile,BufRead *.vimno setf vimno
aug END

" vim: se fdm=marker fdl=0 ts=2: