" Vim filetype plugin for a sort of "interactive/exploratory" workflow.
"
" This file provides a few bits and bobs, but the main point is the workflow
" itself. It can work with plain Vim, if |:so| accepts a range and defaults
" to the current buffer.
"
" |Primer()| below as a start. But overall the idea is to simply work in
" a file rather than a REPL, more or less like a notebook:
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
"   * |Primer()| for a usefull header
"   * |Registore()| essentially a file path in ~/.cache
"   * |Curl()| curl(1)
"   * |:PP|, |PP()|, |PPl()| and |PPs()| pretty print
"   * |:Ypy| and |Ypy()| python with expr8->
"
" Last Change:	2025 Apr 23
" Maintainer:	a b <a.b@c.d>
" License:	This file is placed in the public domain.
"
"  Just, know what you're using and doing-

fu Primer() " {{{1
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
endf " }}}

fu Registore(var='') abort " {{{1
  " a:var is a var name with optional .ext (eg 'g:some.json', with g: optional)
  " * var exists -> store it
  " * var doesn't exist -> load it
  " * a:var itself empty -> only set b:state
  " always returns path
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
endf " }}}

fu Curl(url, head={}, data={}, dry=v:null) abort " {{{1
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

  let l:ty = a:data->type()
  if v:t_string == l:ty || v:t_blob == l:ty
    ev l:com->extend(['--data-binary', a:data])
  el
    let l:data = v:t_dict == l:ty
      \ ? a:data->keys()->map({_, k -> k..'='..a:data[k]})
      \ : a:data

    for l:it in l:data
      ev l:encode && l:it =~ '=.*[^-0-9A-Z_a-z]'
        \ ? l:com->extend(['--data-urlencode', l:it])
        \ : l:com->add('-d'..l:it)
    endfo
  en

  let l:com = l:com->map('v:val->shellescape()')->join()
  echom l:com
  retu v:null == a:dry ? l:com->system() : a:dry
endf " }}}

" PP {{{1
" private stuff {{{2
let s:default_opts = #{
  "\ wrapping width, note that |PP| use 2 cols (for '\ ') when multiline!
  \ wrap: &tw ?? 78,
  "\ indentation
  \ inde: 0,
  "\ sort dict key by default
  \ sort: 1,
  "\ put list items on same line as possible, by default no
  \ tight: 0,
  "\ depth stack (internal use) ((NIY))
  \ stack: []}

let s:bslash_table = {"\b": 'b', "\t": 't', "\n": 'n', "\f": 'f', "\r": 'r', "\e": 'e', '"': '"', '\': '\'}

fu s:len(l)
  retu (len(a:l)/2)
    \ ->range()
    \ ->reduce({acc, cur -> acc + a:l[2*cur+1]->len()}, 0)
endf

fu s:withescs(fits)
  let l:withescs = ['String', '"'..a:fits..'"']

  let l:re = '\%(\\[btnfre"\\]\|\\\o\{3}\)\+'

  let l:esc = l:withescs[-1]->match(l:re)
  wh -1 != l:esc
    let l:esctxt = l:withescs[-1]->matchstr('^'..l:re, l:esc)

    let l:till = l:esc+len(l:esctxt)
    let l:before = l:withescs[-1][:l:esc-1]
    let l:after = l:withescs[-1][l:till:]

    let l:withescs[-1] = l:before
    ev l:withescs->extend(['Special', l:esctxt, 'String', l:after])

    let l:esc = l:withescs[-1]->match(l:re)
  endw

  retu l:withescs
endf

fu s:numPPer(num, opts)
  let l:r = a:opts.inde ? ['None', ' '->repeat(a:opts.inde)] : []
  retu [l:r->extend(['Number', a:num->string()])]
endf

fu s:strPPer(str, opts)
  " break on '\n' (maybe group successive)
  " if long, break on spaces
  " if long and no space, hard break
  " at break, align with any previous indent
  let l:avail = a:opts.wrap - a:opts.inde
  let l:inde = ' '->repeat(a:opts.inde)

  if empty(a:str) |retu [empty(l:inde) ? ['String', '""'] : ['None', l:inde, 'String', '""']] |en

  let l:ns = a:str
    \ ->split("\n\\zs")
    \ ->map({_, l -> l
    \   ->substitute("[\b\t\n\f\r\e\"\\\\]", {m -> '\'..s:bslash_table[m[0]]}, 'g')
    \   ->substitute('[[:cntrl:]]', {m -> '\'..m[0]->char2nr()->printf('%03o')}, 'g')})

  let l:r = []
  let l:len = len(l:ns)
  for l:k in range(l:len)
    let l:l = l:ns[l:k]
    let l:first = 0 == l:k
    let l:last = l:len-1 == l:k

    ev l:r->add(empty(l:inde) ? [] : ['None', l:inde])

    " |--inde--'--txt--' ..|<-wrap
    "           avail
    let l:inavail = l:avail - 2 - (l:last ? 0 :3 )
    if l:inavail < 8 |let l:inavail = 8 |en

    " inner indent for use if line too long
    let l:ininde = l:l->match('\%( \|\\t\)*\zs')

    wh l:inavail < len(l:l)
      let l:cut = l:inavail-3
      let l:fits = l:l[:l:cut-1]

      " avoid cutting an escape sequence
      let l:esc = l:fits->matchlist('\(\\*\)\(\\\o\{,2}\)$')
      if !empty(l:esc) && 0 == len(l:esc[1]) % 2
        let l:cut-= len(l:esc[2])
        let l:fits = l:l[:l:cut-1]
      en

      " try to avoid cutting a word (\o stuff: don't count an oct esc as word)
      let l:wor = l:fits->matchstr('\%(\\\l\)\?\zs\w\+$')
      if !empty(l:wor) && l:wor != l:fits && l:l[l:cut] =~ '\w' && l:fits[-4:] !~ '\\\o\{3}'
        let l:cut-= len(l:wor)
        let l:fits = l:l[:l:cut-1]
      en

      ev l:r[-1]->extend(s:withescs(l:fits))
      ev l:r[-1]->extend(['None', ' ', 'Operator', '..'])
      ev l:r->add(empty(l:inde) ? [] : ['None', l:inde])

      let l:l = l:l[l:cut:]
      " still some left so use inner indent
      if l:ininde && !empty(l:l)
        ev l:r[-1]->extend(['None', ' '->repeat(l:ininde)])
      en
    endw

    if !empty(l:l) |ev l:r[-1]->extend(s:withescs(l:l)) |en
    if !l:last |ev l:r[-1]->extend(['None', ' ', 'Operator', '..']) |en
  endfo

  retu l:r
endf

fu s:funcPPer(func, opts)
  let l:r = a:opts.inde ? ['None', ' '->repeat(a:opts.inde)] : []
  retu [l:r->extend(['Function', 'function', 'Special', '(', 'String', a:func->string()[9:-2], 'Special', ')'])]
endf

fu s:listPPer(list, opts)
  " only multi-line if needed:
  " * any item is
  " * total len would be long
  let l:avail = a:opts.wrap - a:opts.inde
  let l:inde = ' '->repeat(a:opts.inde)
  let l:accu = 1 " accu for current line len

  let l:r = [empty(l:inde) ? [] : ['None', l:inde]]
  if empty(a:list) |ev l:r[-1]->extend(['None', '[']) |en

  let l:first = 1
  for l:val in a:list
    " assume we'll be doing ', '..
    if !l:first |let l:accu+= 2 |en

    let a:opts.inde+= l:accu
    let l:lval = PPhl(l:val, a:opts)
    let a:opts.inde-= l:accu
    " remove first indent
    ev l:lval[0]->remove(0, 1)

    " doesn't apply for first item in the line (1 == l:accu)
    " always drop next line if a:opts.tight false
    "   [1, 2, 3, <l:lval>
    "            |--------| essentially l:avail-l:accu
    "   if multiline, and if taller than large, drop to next line
    "   or if it would simply overflow
    if 1 < l:accu && ( !a:opts.tight ||
        \    (1 < len(l:lval) && l:avail-l:accu < 2*len(l:lval)
        \     || l:avail-l:accu < s:len(l:lval[0])) )
      ev l:r[-1]->extend(['None', ','])
      ev l:r->add(['None', l:inde..' '])
      let l:accu = 1

      let a:opts.inde+= l:accu
      let l:lval = PPhl(l:val, a:opts)
      let a:opts.inde-= l:accu
      " remove first indent
      ev l:lval[0]->remove(0, 1)
    elsei l:first
      ev l:r[-1]->extend(['None', '['])
      let l:first = 0
    el
      ev l:r[-1]->extend(['None', ', '])
    en

    ev l:r[-1]->extend(l:lval[0])
    if 1 != len(l:lval) |ev l:r->extend(l:lval[1:]) |en

    let l:accu+= s:len(l:lval[-1])
  endfo
  ev l:r[-1]->extend(['None', ']'])

  retu l:r
endf

fu s:dictPPer(dict, opts)
  " align value with key like
  " {"a": "bla" ..
  "       "bla"}
  " long keys will go like
  " {"long-key":
  "   "bla" ..
  "   "bla"}
  " if all keys are ident-valid, use #{} syntax (then long keys be long)
  let l:avail = a:opts.wrap - a:opts.inde
  let l:inde = ' '->repeat(a:opts.inde)
  let l:keys = a:dict->keys()
  if a:opts.sort |ev l:keys->sort() |en
  let l:allok = -1 == l:keys->match('[^-0-9A-Z_a-z]')

  let l:r = [empty(l:inde) ? [] : ['None', l:inde]]
  if empty(a:dict) |ev l:r[-1]->extend(['Special', '{}']) |retu l:r |en
  ev l:r[0]->extend(['Special', l:allok ? '#{' : '{'])

  for l:key in l:keys
    if l:key != l:keys[0] |ev l:r->add(['None', l:inde..(l:allok ? '  ' : ' ')]) |en

    if l:allok
      let l:keytxt = type('') == type(l:key) ? l:key : l:key->string()
      ev l:r[-1]->extend(['Identifier', l:keytxt])
      let l:keylen = len(l:keytxt)
    el
      let a:opts.inde+= 1
      let l:keytxt = PPhl(l:key, a:opts)
      let a:opts.inde-= 1

      " remove first indent
      ev l:keytxt[0]->remove(0, 1)
      ev l:r[-1]->extend(l:keytxt[0])

      if 1 == len(l:keytxt)
        let l:keylen = s:len(l:keytxt)
      el
        ev l:r->extend(l:keytxt[1:])
        let l:keylen = s:len(l:keytxt[-1])
      en
    en

    let l:pinde = a:opts.inde

    if l:keylen < l:avail/3
      ev l:r[-1]->extend(['None', ': '])
      let a:opts.inde+= 1+l:allok+l:keylen+2
    el
      " key considered too long, drop value to next line
      ev l:r[-1]->extend(['None', ':'])
      ev l:r->add(['None', l:inde..'   '])
      let a:opts.inde+= 3
    en

    let l:lval = PPhl(a:dict[l:key], a:opts)
    let a:opts.inde = l:pinde

    " remove first indent
    ev l:lval[0]->remove(0, 1)
    ev l:r[-1]->extend(l:lval[0])
    if 1 != len(l:lval) |ev l:r->extend(l:lval[1:]) |en

    ev l:r[-1]->extend(l:key == l:keys[-1] ? ['Special', '}'] : ['None', ','])
  endfo

  retu l:r
endf

fu s:specialPPer(val, opts)
  " v:true, v:false and v:null
  let l:r = a:opts.inde ? ['None', ' '->repeat(a:opts.inde)] : []
  retu [l:r->extend(['Identifier', a:val->string()])]
endf

fu s:blobPPer(blob, opts)
  " not sure, likely the 0z notation, with '.'s and '\n's
  let l:r = a:opts.inde ? ['None', ' '->repeat(a:opts.inde)] : []
  retu [l:r->extend(['Error', 'NIY: blobPPer'])]
endf

let s:pper_map = [
  \  funcref('s:numPPer'),
  \  funcref('s:strPPer'),
  \  funcref('s:funcPPer'),
  \  funcref('s:listPPer'),
  \  funcref('s:dictPPer'),
  \  funcref('s:numPPer'),
  \  funcref('s:specialPPer'),
  \  funcref('s:specialPPer'),
  \  0, 0,
  \  funcref('s:blobPPer'),
  \ ]
" }}}

fu PPhl(ny, opts={})
  " pretty print to a list of lines with highlight info
  " (without trailing \n nor leading \\)
  " the result is basically tokens as follow:
  " "[<hl-grp-1>, <tok-1>, <hl-grp-2>, <tok-2>, ..]"
  " mostly internal use, see rather |PPl()|
  let l:PPer = s:pper_map[type(a:ny)]
  retu l:PPer(a:ny, a:opts->extend(s:default_opts, 'keep'))
endf

fu PPl(ny, opts={})
  " pretty print to a list of lines
  " (with leading \\)
  retu PPhl(a:ny, a:opts)
    \ ->map({_, line -> '\ '..(line->len()/2)
    \   ->range()
    \   ->map({_, k -> line[2*k+1]})
    \   ->join('')})
endf

fu PPs(ny, opts={})
  " pretty print to a string, see also |PP()|
  " (with trailing \n and leading \\)
  let l:ines = PPl(a:ny, a:opts)
  retu 1 < len(l:ines) ? l:ines->join("\n").."\n" : l:ines[0]
endf

fu PP(ny, name='_', opts={})
  " pretty print to |:echo| and forward value, see also |PPs()|
  " (with trailing \n and leading \\)
  let l:ines = PPhl(a:ny, a:opts)

  ec ''
  echoh Keyword    |echon 'let'
  echoh None       |echon ' '
  echoh Identifier |echon a:name
  echoh None       |echon ' '
  echoh Operator   |echon '='

  for l:l in l:ines
    if 1 < len(l:ines)
      echoh None    |ec '  '
      echoh Special |echon '\'
      echoh None    |echon ' '
    el
      echoh None    |echon ' '
    en

    for l:k in range(len(l:l)/2)
      exe 'echoh' l:l[2*l:k] |echon l:l[2*l:k+1]
    endfo
  endfo

  echoh None
  retu a:ny
endf

com -nargs=+ -complete=expression PP cal PP(<args>, <q-args>)
" }}}

" Ypy {{{1
" Vim's `expr8->` in :py -- somewhat
"
" Adds :Ypy and Ypy() that acts (somewhat) like :py and pyeval(), but is added
" to the syntax the concepts of 'subject' so that the following does what
" you'd expect:
"
"   range(3)->map(str, _)->list(_)->print(_)
"   # 'subject' at 1st `->` is `range(3)`
"   #           at 2nd `->` is `map(str, range(3))`
"   #           ... and so on
"
" `->` essentially makes a `_N` variable of the preceding expression, and in
" the following expression `_` is the latest `_N` at current depth:
"
"   1 -> (_+_) -> print(_) # prints 2
"   1 -> (_+_) -> print(_0) # prints 1 except it doesn't because fixme
"
"   set()->(_.update(coucou) or _.update(blabla) or _)->print(_)
"
" Be prepared for jank 'cause idc. Use :NotYpy to 'help' debugging.
" Why 'Ypy'? 'cause :Y is easy to type, :y <crap> will complain, and y not.

let s:loaded = 0
fu s:ypy()
  if s:loaded |retu |en
  let s:loaded = 1
  py <<
from pprint import pp
import tokenize
_LOWPREC = {tokenize.NOTEQUAL, tokenize.PERCENT, tokenize.PERCENTEQUAL, tokenize.AMPER, tokenize.AMPEREQUAL, tokenize.STAR, tokenize.DOUBLESTAR, tokenize.DOUBLESTAREQUAL, tokenize.STAREQUAL, tokenize.PLUS, tokenize.PLUSEQUAL, tokenize.COMMA, tokenize.MINUS, tokenize.MINEQUAL, tokenize.SLASH, tokenize.DOUBLESLASH, tokenize.DOUBLESLASHEQUAL, tokenize.SLASHEQUAL, tokenize.COLON, tokenize.COLONEQUAL, tokenize.SEMI, tokenize.LESS, tokenize.LEFTSHIFT, tokenize.LEFTSHIFTEQUAL, tokenize.LESSEQUAL, tokenize.EQEQUAL, tokenize.GREATER, tokenize.GREATEREQUAL, tokenize.RIGHTSHIFT, tokenize.RIGHTSHIFTEQUAL, tokenize.AT, tokenize.ATEQUAL, tokenize.CIRCUMFLEX, tokenize.CIRCUMFLEXEQUAL, tokenize.VBAR, tokenize.VBAREQUAL}
_CLOSERS = {tokenize.LPAR: tokenize.RPAR, tokenize.LSQB: tokenize.RSQB, tokenize.LBRACE: tokenize.RBRACE}
_DISCARD = {tokenize.NEWLINE, tokenize.COMMENT, tokenize.NL, tokenize.ENCODING}

def ypytr(script: str):
    tokens = tokenize.generate_tokens(iter([script]).__next__)
    n = 0

    def tt(close: int, subj: "list[str]") -> "list[str]":
        r: "list[str]" = []
        subst = 0

        for tok in tokens:
            et = tok.exact_type
            if et is close:
                r.append(tok.string)
                break

            if et not in _DISCARD:
                if et in _CLOSERS.keys():
                    subtt = [tok.string]
                    subtt.extend(tt(_CLOSERS[et], subj))
                    r.extend(subtt)

                elif tokenize.NAME == et and "_" == tok.string:
                    if 1 == len(subj) and "_" == subj[0][0] and subj[0][1:].isdigit():
                        r.append(subj[0])
                    else:
                        nonlocal n
                        r.extend([f"(_{n}:=(", *subj, "))"])
                        subj = [f"_{n}"]
                        n+= 1

                elif et in _LOWPREC:
                    r.append(tok.string)
                    subst = len(r)

                elif tokenize.RARROW == et:
                    r = r[:subst] + tt(close, r[subst:])
                    break

                else: r.append(tok.string)
        return r

    return " ".join(tt(tokenize.ENDMARKER, ["_"]))

def ypy(script: str): return eval(ypytr(script))
.
endf

fu Ypy(script)
  cal s:ypy()
  retu pyeval('(_:=ypy(r""" '..a:script..' """))')
endf
com -nargs=+ Ypy cal s:ypy() |py pp(_:=ypy(r""" <args> """))
com -nargs=+ NotYpy cal s:ypy() |py print(ypytr(r""" <args> """))
" }}}

" vim: se fdm=marker fdl=0 ts=2:
