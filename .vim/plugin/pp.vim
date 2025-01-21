" default options {{{1
let s:default_opts = #{
  "\ wrapping width, note that |PP| use 2 cols (for '\ ') when multiline!
  \ wrap: &tw ?? 78,
  "\ indentation
  \ inde: 0,
  "\ depth stack (internal use)
  \ stack: []}

" private functions {{{1
let s:bslash_table = {"\b": '\b', "\t": '\t', "\n": '\n', "\f": '\f', "\r": '\r', "\e": '\e', '"': '\"', '\': '\\'}

fu s:numPPer(num, opts)
  retu [['Number', a:num->string()]]
endf

fu s:strPPer(str, opts)
  " break on '\n' (maybe group successive)
  " if long, break on spaces
  " if long and no space, hard break
  " at break, align with any previous indent
  let l:ns = a:str->split("\n\\zs")
  ev l:ns->map({_, l -> l
    \   ->substitute('['..s:bslash_table->keys()->join('')..']', {m -> s:bslash_table[m[0]]}, 'g')
    \   ->substitute('[[:cntrl:]]', {m -> '\'..m[0]->char2nr()->printf('%03o')}, 'g')})

  let l:r = []
  let l:len = len(l:ns)
  for l:k in range(l:len)
    let l:l = l:ns[l:k]
    let l:first = 0 == l:k
    let l:last = l:len-1 == l:k

    ev l:r->add(a:opts.inde ? ['None', ' '->repeat(a:opts.inde)] : [])

    " |--inde--'--txt--' ..|<-wrap
    "           avail
    let l:avail = a:opts.wrap-a:opts.inde - 2 - (l:last ? 0 :3 )
    if l:avail < 8 |let l:avail = 8 |en

    let l:ininde = l:l->match('\%( \|\\t\)*\zs')

    wh l:avail < len(l:l)
      let l:cut = l:avail-3
      let l:fits = l:l[:l:cut-1]

      " avoid cutting an escape sequence
      let l:esc = l:fits->matchlist('\(\\\+\)\o\{,2}$')
      if !empty(l:esc) && len(l:esc[1]) % 2
        let l:cut-= len(l:esc[0])
        let l:fits = l:l[:l:cut-1]
      en
      let l:l = l:l[l:cut:]

      ev l:r[-1]->extend([
        \ 'String', '"'..l:fits..'"',
        \ 'None', ' ',
        \ 'Operator', '..'])
      ev l:r->add([])

      if l:ininde && !empty(l:l)
        ev l:r[-1]->extend(['None', ' '->repeat(l:ininde)])
      en
    endw

    if !empty(l:l) |ev l:r[-1]->extend(['String', '"'..l:l..'"']) |en
    if !l:last |ev l:r[-1]->extend([
      \ 'None', ' ',
      \ 'Operator', '..']) |en
  endfo

  retu l:r
endf

fu s:funcPPer(func, opts)
  retu [['Function', 'function', 'Special', '(', 'String', a:func->string()[9:-2], 'Special', ')']]
endf

fu s:listPPer(list, opts)
  " only multi-line if needed:
  " * any item is
  " * total len would be long
endf

fu s:dictPPer(dict, opts)
  " similar to list
  " idquitek about keys tho
endf

fu s:specialPPer(val, opts)
  retu [['Identifier', a:val->string()]]
endf

fu s:blobPPer(blob, opts)
  " not sure, likely the 0z notation, with '.'s and '\n's
  retu [['Error', 'NIY: blobPPer']]
endf

" public functions {{{1
let s:pper_map = {
  \   0: funcref('s:numPPer'),
  \   1: funcref('s:strPPer'),
  \   2: funcref('s:funcPPer'),
  \   3: funcref('s:listPPer'),
  \   4: funcref('s:dictPPer'),
  \   5: funcref('s:numPPer'),
  \   6: funcref('s:specialPPer'),
  \   7: funcref('s:specialPPer'),
  \  10: funcref('s:blobPPer'),
  \ }

fu PPhl(ny, opts={})
  " pretty print to a list of lines with highlight info
  " (without trailing \n nor leading \\)
  " the result is basically tokens as follow: >
  "     [<hl-grp-1>, <tok-1>, <hl-grp-2>, <tok-2>, ..]
  " < mostly internal use, see rather |PPl|
  let l:PPer = s:pper_map[type(a:ny)]
  retu l:PPer(a:ny, a:opts->extend(s:default_opts, 'keep'))
endf

fu PPl(ny, opts={})
  " pretty print to a list of lines
  " (without trailing \n nor leading \\)
  retu PPhl(a:ny, a:opts)
    \ ->map({_, line -> range(line->len()/2)
    \   ->map({_, k -> line[2*k+1]})
    \   ->join('')})
endf

fu PPs(ny, opts={})
  " pretty print to a string, see also |PP|
  let l:ines = PPl(a:ny, a:opts)
  retu 1 < len(l:ines) ? '\ '..l:ines->join("\n\\ ").."\n" : l:ines[0]
endf

fu PP(ny, opts={})
  " pretty print to |:echo| and forward value, see also |PPs|
  " (with trailing \n and leading \\)
  let l:ines = PPhl(a:ny, a:opts)

  for l:l in l:ines
    if 1 < len(l:ines)
      echoh Special |echon '\'
      echoh None    |echon ' '
    en

    for l:k in range(len(l:l)/2)
      exe 'echoh' l:l[2*l:k] |echon l:l[2*l:k+1]
    endfo

    echoh None |ec ''
  endfo

  retu a:ny
endf

" testing {{{1
"finish
let v:errors = []
mes clear

" {{{2
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
" {{{2
" simple strings
cal assert_equal([
  \   ['String', '"coucou"']],
  \ PPhl('coucou'))
" cut after ln
cal assert_equal([
  \   ['String', '"bla\n"', 'None', ' ', 'Operator', '..'],
  \   ['String', '"bla"']],
  \ PPhl("bla\nbla"), )
" wrap match indent
cal assert_equal([
  \   ['String', '"def a():\n"', 'None', ' ', 'Operator', '..'],
  \   ['String', '"    pass # this a lon"', 'None', ' ', 'Operator', '..'],
  \   ['None', '    ', 'String', '"g line aint it"']],
  \ PPhl("def a():\n    pass # this a long line aint it", #{wrap: 26}))
" {{{2
" dont cut escape sequences
cal assert_equal([
  \   ['String', '"abcdefhijklmnopqrs"', 'None', ' ', 'Operator', '..'],
  \   ['String', '"\tuvwxyz"']],
  \ PPhl("abcdefhijklmnopqrs\tuvwxyz", #{wrap: 24}))
cal assert_equal([
  \   ['String', '"abcdefhijklmnopqr"', 'None', ' ', 'Operator', '..'],
  \   ['String', '"\006tuvwxyz"']],
  \ PPhl("abcdefhijklmnopqr\006tuvwxyz", #{wrap: 24}))
cal assert_equal([
  \   ['String', '"abcdefhijklmnopq"', 'None', ' ', 'Operator', '..'],
  \   ['String', '"\006stuvwxyz"']],
  \ PPhl("abcdefhijklmnopq\006stuvwxyz", #{wrap: 24}))
cal assert_equal([
  \   ['String', '"abcdefhijklmnop\006"', 'None', ' ', 'Operator', '..'],
  \   ['String', '"rstuvwxyz"']],
  \ PPhl("abcdefhijklmnop\006rstuvwxyz", #{wrap: 24}))
" {{{2
cal assert_equal([
  \   ['Function', 'function', 'Special', '(', 'String', "'tr'", 'Special', ')']],
  \ PPhl(function('tr')))
" }}}

if !empty(v:errors) |ec "v:errors:\n\t"..v:errors->mapnew('v:val->fnamemodify(":t")')->join("\n\t").."\n" |en

cal PP("def a():\n    pass # this a long line aint it", #{wrap: 26})
