" TODO: fix confusion with inde and wrap, wrap doesn't change

" default options {{{1
let s:default_opts = #{
  "\ wrapping width, note that |PP| use 2 cols (for '\ ') when multiline!
  \ wrap: &tw ?? 78,
  "\ indentation
  \ inde: 0,
  "\ depth stack (internal use)
  \ stack: []}

" private functions {{{1
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
    "   [1, 2, 3, <l:lval>
    "            |--------| essentially l:avail-l:accu
    "   if multiline, and if taller than large, drop to next line
    "   or if it would simply overflow
    if 1 < l:accu
        \ && (1 < len(l:lval) && l:avail-l:accu < 2*len(l:lval)
        \     || l:avail-l:accu < s:len(l:lval[0]))
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

" public functions {{{1
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
  " (without trailing \n nor leading \\)
  retu PPhl(a:ny, a:opts)
    \ ->map({_, line -> (line->len()/2)
    \   ->range()
    \   ->map({_, k -> line[2*k+1]})
    \   ->join('')})
endf

fu PPs(ny, opts={})
  " pretty print to a string, see also |PP()|
  let l:ines = PPl(a:ny, a:opts)
  retu 1 < len(l:ines) ? '\ '..l:ines->join("\n\\ ").."\n" : l:ines[0]
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

"finish
" testing {{{1
let v:errors = []
mes clear

" {{{2 simple values
cal assert_equal([
  \   ['Number', '15']],
  \ PPhl(15))
cal assert_equal([
  \   ['Number', '7.42']],
  \ PPhl(7.42))
cal assert_equal([
  \   ['Identifier', 'v:null']],
  \ PPhl(v:null))
cal assert_equal([
  \   ['Identifier', 'v:true']],
  \ PPhl(v:true))
cal assert_equal([
  \   ['Identifier', 'v:false']],
  \ PPhl(v:false))
cal assert_equal([
  \   ['Function', 'function', 'Special', '(', 'String', "'tr'", 'Special', ')']],
  \ PPhl(function('tr')))
" {{{2 simple strings
cal assert_equal([
  \   ['String', '"coucou"']],
  \ PPhl('coucou'))
" cut after ln
cal assert_equal([
  \   ['String', '"bla', 'Special', '\n', 'String', '"', 'None', ' ', 'Operator', '..'],
  \   ['String', '"bla"']],
  \ PPhl("bla\nbla"), )
" {{{2 wrapping behavior
" wrap match indent + don't cut word
cal assert_equal([
  \   ['String', '"def a():', 'Special', '\n', 'String', '"', 'None', ' ', 'Operator', '..'],
  \   ['String', '"    pass # this a "', 'None', ' ', 'Operator', '..'],
  \   ['None', '    ', 'String', '"long line aint it"']],
  \ PPhl("def a():\n    pass # this a long line aint it", #{wrap: 26}))
" still cut word if too long
cal assert_equal([
  \   ['String', '"kkkkkkkkkkkkkkkkkkkkkkkkkk "', 'None', ' ', 'Operator', '..'],
  \   ['String', '"kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk"', 'None', ' ', 'Operator', '..'],
  \   ['String', '"kkkkkkkkkkkkkkkk"']],
  \ PPhl("kkkkkkkkkkkkkkkkkkkkkkkkkk kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk"))
" don't cut escape sequences
cal assert_equal([
  \   ['String', '"abcdefhijklmnopqrs"', 'None', ' ', 'Operator', '..'],
  \   ['String', '"', 'Special', '\t', 'String', 'uvwxyz"']],
  \ PPhl("abcdefhijklmnopqrs\tuvwxyz", #{wrap: 24}))
cal assert_equal([
  \   ['String', '"abcdefhijklmnopqr"', 'None', ' ', 'Operator', '..'],
  \   ['String', '"', 'Special', '\006', 'String', 'tuvwxyz"']],
  \ PPhl("abcdefhijklmnopqr\006tuvwxyz", #{wrap: 24}))
cal assert_equal([
  \   ['String', '"abcdefhijklmnopq"', 'None', ' ', 'Operator', '..'],
  \   ['String', '"', 'Special', '\006', 'String', 'stuvwxyz"']],
  \ PPhl("abcdefhijklmnopq\006stuvwxyz", #{wrap: 24}))
cal assert_equal([
  \   ['String', '"abcdefhijklmnop', 'Special', '\006', 'String', '"', 'None', ' ', 'Operator', '..'],
  \   ['String', '"rstuvwxyz"']],
  \ PPhl("abcdefhijklmnop\006rstuvwxyz", #{wrap: 24}))
cal assert_equal([
  \   ['String', '"abcdefhijklmnopq', 'Special', '\\', 'String', '"', 'None', ' ', 'Operator', '..'],
  \   ['String', '"', 'Special', '\t', 'String', '_uvwxyz"']],
  \ PPhl("abcdefhijklmnopq\\\t_uvwxyz", #{wrap: 24}))
cal assert_equal([
  \   ['String', '"', 'Special', '\\\\', 'String', '"', 'None', ' ', 'Operator', '..'],
  \   ['String', '"', 'Special', '\\\\', 'String', '"', 'None', ' ', 'Operator', '..'],
  \   ['String', '"', 'Special', '\\\\', 'String', '"', 'None', ' ', 'Operator', '..'],
  \   ['String', '"', 'Special', '\\\\', 'String', '"', 'None', ' ', 'Operator', '..'],
  \   ['String', '"', 'Special', '\\\\', 'String', '"', 'None', ' ', 'Operator', '..'],
  \   ['String', '"', 'Special', '\\\\', 'String', '"', 'None', ' ', 'Operator', '..'],
  \   ['String', '"', 'Special', '\\\\', 'String', '"', 'None', ' ', 'Operator', '..'],
  \   ['String', '"', 'Special', '\\\\', 'String', '"', 'None', ' ', 'Operator', '..'],
  \   ['String', '"', 'Special', '\\\\\\\\', 'String', '"']],
  \ PPhl('\\\\\\\\\\\\\\\\\\\\', #{wrap: 10}))
" {{{2 lists
cal assert_equal([
  \   ['None', '[', 'Number', '1', 'None', ', ', 'Number', '2', 'None', ', ', 'Number', '3', 'None', ']']],
  \ PPhl([1, 2, 3]))
cal assert_equal([
  \   ['None', '[', 'String', '"a', 'Special', '\n', 'String', '"', 'None', ' ', 'Operator', '..'],
  \   ['None', ' ', 'String', '"b"', 'None', ', ', 'String', '"c', 'Special', '\n', 'String', '"', 'None', ' ', 'Operator', '..'],
  \   ['None', '       ', 'String', '"d"', 'None', ']']],
  \ PPhl(["a\nb", "c\nd"]))
cal assert_equal([
  \   ['None', '[', 'None', '[', 'Number', '0', 'None', ', ', 'Number', '1', 'None', ', ', 'Number', '2', 'None', ']', 'None', ','],
  \   ['None', ' ', 'None', '[', 'Number', '0', 'None', ', ', 'Number', '1', 'None', ', ', 'Number', '2', 'None', ']', 'None', ','],
  \   ['None', ' ', 'None', '[', 'Number', '0', 'None', ', ', 'Number', '1', 'None', ', ', 'Number', '2', 'None', ']', 'None', ']']],
  \ PPhl([range(3), range(3), range(3)], #{wrap: 14}))
cal assert_equal([
  \   ['None', '[', 'Number', '1', 'None', ', ', 'Number', '2', 'None', ', ', 'Number', '4', 'None', ', ', 'Special', '#{', 'Identifier', 'one', 'None', ': ', 'String', '"1"', 'None', ','],
  \   ['None', '            ', 'Identifier', 'two', 'None', ': ', 'String', '"2"', 'Special', '}', 'None', ']']],
  \ PPhl([1, 2, 4, #{one: '1', two: '2'}]))
" {{{2 dicts
cal assert_equal([
  \   ['Special', '#{', 'Identifier', 'blabla', 'None', ': ', 'Number', '17', 'None', ','],
  \   ['None', '  ', 'Identifier', 'coucou', 'None', ': ', 'Number', '42', 'Special', '}']],
  \ PPhl(#{coucou: 42, blabla: 17}))
cal assert_equal([
  \   ['Special', '{', 'String', '"bla', 'Special', '\n', 'String', '"', 'None', ' ', 'Operator', '..'],
  \   ['None', ' ', 'String', '"bla"', 'None', ': ', 'Number', '17', 'None', ','],
  \   ['None', ' ', 'String', '"4"', 'None', ': ', 'Number', '4', 'None', ','],
  \   ['None', ' ', 'String', '"coucou"', 'None', ': ', 'Number', '42', 'Special', '}']],
  \ PPhl({'coucou': 42, "bla\nbla": 17, 04: 04}))
" }}}

if !empty(v:errors)
  ec "v:errors:\n\t"..v:errors->mapnew('v:val->fnamemodify(":t")')->join("\n\t").."\n" |el
  ec 'all tests passing! \o/' |en

ev getbufinfo()->PP()
" }}}

" vim: se ts=2:
