" Vim filetype plugin for interactive notes. Somewhat like a minimal org mode.
" This is a short single file with filetype/indent/syntax/omnifunc/tagfunc.
"
" Last Change:	2024 Nov 27
" Maintainer:	a b <a.b@c.d>
" License:	This file is placed in the public domain.
"
"  Just, know what you're using and doing-
"
" TODO: example
" TODO: fix Source and make it work with |if_tcl.txt| |if_lua.txt|
"       |if_perl.txt| |if_pyth.txt| |if_ruby.txt| |if_mzsch.txt|
" TODO: comment Echo/Let ids and !.. :.. syntaxes
" TODO: fix @Spell/@NoSpell situation
" TODO: tagfunc
" TODO: jobs

" g: variables {{{1
if &cp || exists('g:loaded_vimno') |fini |en
let g:loaded_vimno = 1

if !exists('g:vimno_state') |let g:vimno_state = expand('~/.cache/vimno/') |en
if '/' != g:vimno_state[-1:] |let g:vimno_state..= '/' |en

" NOTE: this is a vim default, in that nvim only has perl/pyth/ruby
if !exists('g:vimno_avail_ifs') |let g:vimno_avail_ifs = split('tcl lua pe[rl] py[thon] rub[y] mz[scheme]') |en
cal map(g:vimno_avail_ifs, '"]" == v:val[-1:] ? substitute(v:val, ''\v(\w+)\[(\w*)]'', ''\1\2|\1'', "") : v:val')

" s: functions {{{1
fu s:Echo(n, ...)
  "" Echos in the document itself; the line with the `Echo` itself is prefixed
  "" with a (hopefully unique) number after first run, which is used to locate
  "" itself on other runs. Output is prefixed with same indentation and '"| '.
  ""  0. if value starts with !, uses system()
  ""  0. if value starts with :, uses execute()
  ""  0. otherwise it is a normal expression, uses eval()
  let c = join(a:000)
  let r = '!' == c[0] ? system(c[1:]) : ':' == c[0] ? execute(c[1:]) : eval(c)
  echo r
  let n = a:n ?? (line('.')+localtime())%10000
  exe '-5/^\s*'..(a:n ? n : '')..'\vEcho?|Let!/'
  let i = matchstr(getline('.'), '^\s*')
  exe 's/^\s*\zs\d*/'..n
  if a:n |sil /^\(\s*\\\)\@!/;/^\(\s*"| \)\@!/-d |sil - |en
  let l = 3 == type(r) ? r : split(r, "\n")
  cal append('.', map(l, '"'..i..' \"| "..v:val->trim("", 2)'))
endf

fu s:Let(bang, n, var, eq, ...)
  "" Similar to :let however the result is stored in a file by the var's name;
  "" the variable will contain the full file path. If the file already existed
  "" do :cal var->delete(). `Let!` will also `Echo`. See g:vimno_state as well
  "" as $VIMNO_CACHE.
  ""  0. if value starts with !, uses system()
  ""  0. if value starts with :, uses execute()
  ""  0. otherwise it is a normal expression, uses eval()
  let d = $VIMNO_CACHE..'/'
  let d..= a:var['$'==a:var[0]:]
  exe 'let' substitute(a:var, '[./]', '_', 'g') '= d'
  if filereadable(d) |retu |en
  cal mkdir(fnamemodify(d, ':h'), 'p')
  let c = join(a:000)
  echom c
  let r = '!' == c[0] ? system(c[1:]) : ':' == c[0] ? execute(c[1:]) : eval(c)
  let g:l = split(r, "\n")
  cal writefile(g:l, d)
  if a:bang |cal s:Echo(a:n, 'g:l') |el |echo r |en
  unl g:l
endf

fu s:Source(bang)
  th 'NIY: wip'
  "" Sources the current (or with `Source!`, every) `{{{xlang }}}` block(s).
  "" # leading char # 1st :So!  # :Source   # :Source!  #
  "" | '!'          | O         | O         | O         |  " always sourced
  "" | '+'          | O         | O         | -         |  " at 1st :So! only
  "" | '-' or none  | -         | O         | -         |  " manually only
  "" | any other    | -         | -         | -         |  " never sourced
  let i = getpos('.')
  let l = 'vimno|'..join(g:vimno_avail_ifs, '|')
  if a:bang
    let c = exists('b:did_vimno_first_source') ? '!' : '[!+]'
    let b:did_vimno_first_source = 1
    cal cursor(1, 1)
    wh search('^{{{\v'..c..'%('..l..')>.*')
      let p = getpos('.')[1]
      let q = search('/^}}}$/') " {{{
      if !q |th 'no ending }}}' |en
      let n = " TODO(wip)
      if n
        cal append(p, n..' <<')
        let q+= 1
      en
      exe p ',' q 'so'
      if n| exe p 'd'| en
      cal cursor(1, q)
    endw
  el
    +?\v^{{{-=(vimno|py(thon)?).*?+;/^}}}$/-so
    " TODO(wip)
  en
  cal setpos('.', i)
endf

" syntax {{{1
fu s:Syntax()
  if exists('b:current_syntax') |retu |en
  sy clear
  sy spell toplevel
  sy sync fromstart
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
  sy region   vimnoPreSh     matchgroup=vimnoPreDelim start=/^{{{\v(ba|z|k|da|)sh>.*/ end=/^}}}$/ keepend contains=@NoSpell,vimnoShLine
  sy region   vimnoPreVn     matchgroup=vimnoPreDelim start=/^{{{[!+-]\?vimno\>.*/ end=/^}}}$/ contains=@NoSpell,@vimnoExpr,vimnoComment1,vimnoCommand,vimnoLet,vimnoShell,vimnoResult
  sy include  @sh syntax/sh.vim
  sy region   vimnoShLine    contained matchgroup=vimnoComment1 start=/^\S*[#$] / end=/$/ contains=@sh
  sy region   vimnoResult    contained matchgroup=vimnoComment1 start=/^\s* "|/ end=/$/ contains=@NoSpell
  sy match    vimnoLineC     contained /^\s*\\/
  sy cluster  vimnoExpr      contains=vimnoNum,vimnoStr,vimnoCall,vimnoVar,vimnoOp
  sy match    vimnoNum       contained /0o\?\o\+\|0x\h\+\|0b[01]\+\|\d\+\(\.\d\+\)\?/
  sy match    vimnoStr       contained /'[^']*\('\|$\)\|"\(\\"\|[^"]\)*\("\|$\)/ contains=@NoSpell
  sy match    vimnoCall      contained /\([abglstvw]:\|\<\h\)\(\w\|{[^}]\+}\)*\ze\s*(/ contains=@NoSpell
  sy match    vimnoVar       contained /\([$@&]\|[abglstvw]:\|\<\h\)\(\w\|{[^}]\+}\)*/ contains=@NoSpell
  sy match    vimnoOp        contained /[-+/*%.<=>&{|}!]\|\<in\>/
  sy region   vimnoCommand   contained matchgroup=vimnoKeyword start=/^\v\s*(\d*Echo|break|call|const|continue|echo|echom|else|elseif|endfor|endfunc|endif|endwhile|for|func|if|lockvar|return|unlet|unlockvar|while)!?/ skip=/\n\s*\\/ end=/$/ keepend contains=vimnoLineC,@vimnoExpr,vimnoComment1
  sy region   vimnoLet       contained matchgroup=vimnoKeyword start=/^\v\s*(\d*Let|let)!?/ skip=/\n\s*\\/ end=/$/ keepend contains=vimnoLineC,vimnoShell,@vimnoExpr,vimnoComment1
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
  hi def link vimnoCode      Special
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
  for i in ['python|py'] "g:vimno_avail_ifs TODO/FIXME: why does it only work for the first one?
    let n = split(i, '|')[0]
    try
      exe 'sy include @'..n 'syntax/'..n..'.vim'
    cat /E484:/
      con
    endt
    exe 'sy region vimnoPreIF'..n 'matchgroup=vimnoPreDelim start=/^{{{\v[!+-]?%('..i..')>.*/ end=/^}}}$/ contains=@'..n
  endfo
endf

" filetype {{{1
fu s:FileType()
  if exists('b:did_ftplugin') |retu |en
  let b:did_ftplugin = 1
  let b:undo_ftplugin = 'setl cole< com< cms< flp< ofu< syn< tfu< |delc -buffer Echo |delc -buffer Let |delc -buffer Source |sil! nun <buffer> gO |unl $VIMNO_CACHE'
  setl cole=3 com=b:\"\",b:\",b:\"\|,fb:.,b:\\ cms=\"\"\"\\%s\"\"\" flp=^\\v\\s*(\\a\|\\d\\+).\  ofu=s:Complete syn=vimno tfu=s:Tag
  com -buffer -nargs=1 -complete=expression       -range=0 -addr=other Echo   cal s:Echo  (         <count>, <f-args>)
  com -buffer -nargs=+ -complete=command    -bang -range=0 -addr=other Let    cal s:Let   (<bang>0, <count>, <f-args>)
  com -buffer                               -bang                      Source cal s:Source(<bang>0)
  nn <buffer> gO :<C-U>lv /^#\{1,4} [^#]\+/j % <Bar>lop<CR>
  " TODO: mouai :/ use au BufEnter/Leave or something
  let $VIMNO_CACHE = g:vimno_state..substitute(expand('%:p'), '/', '%', 'g')
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
    retu sort(filter(e ? map(keys(environ()), '"$"..v:val') : map(split(execute('let'), "\n"), 'split(v:val)[0]'), 'a:base==v:val[:'..(len(a:base)-1)..']'))
  en
endf

fu s:Tag(pattern, flags, info)
  retu v:null " TODO
endf

fu s:Indent()
  let n = prevnonblank(v:lnum-1)
  return indent(n) + ((getline(n) =~ '\v^\s*<(if|elseif|for|while|func)>|:\s\*$') - (getline('.') =~ '^\s*\<end\>'))*&ts
endf

" autocommands {{{1
aug vimno
  au Syntax vimno cal s:Syntax()
  au FileType vimno cal s:FileType()
  au BufNewFile,BufRead *.vimno setf vimno
aug END

" vim: se fdm=marker fdl=0 ts=2:
