" default options {{{1
let s:default_opts = #{
    "\ text width before wrapping
    \ tw: &tw ?? 78,
    "\ indentation
    \ inde: 0,
    "\ depth stack (internal use)
    \ stack: [],
    "\ put coloration hints (mostly internal use)
    \ colo: v:false}

" private functions {{{1
let s:bslash_table = {"\b": '\b', "\t": '\t', "\n": '\n', "\v": '\v', "\f": '\f', "\r": '\r', "\e": '\e', '"': '\"', '\': '\\'}

func s:strPPer(str, opts) abort
    " break on '\n' (maybe group successive)
    " if long, break on spaces
    " if long and no space, hard break
    " at break, align with any previous indent (assume tab of 8)
    let l:ns = a:str
        \ ->split("\n\\zs")
        \ ->map({_, l -> l
        \     ->substitute('['..s:bslash_table->keys()->join('')..']', {m -> s:bslash_table[m[0]]}, 'g')
        \     ->substitute('[[:cntrl:]]', {m -> '\'..m[0]->char2nr()->printf('%03o')}, 'g')})

    let l:k = 0
    while l:k < l:ns->len()
        if l:k |let l:ns[l:k-1]..= ' ..' |en

        let l:indent = l:ns[l:k]->matchstr('^\s*')->len()
        let l:avail = max([a:tw-l:indent, 9])

        let l:ns[l:k] = "'"..l:ns[l:k]
        while a:tw < l:ns[l:k]->len()
            let l:space = l:ns[l:k][:l:avail-1]->reverse()->match(' ')+1 ?? l:avail

            ev l:ln->insert(l:ns[l:k][:l:space].."' ..", l:k)
            let l:k+= 1

            let l:ns[l:k] = ' '->repeat(l:indent).."'"..l:ns[l:k][l:space+1:]

        endwhile
        let l:ns[l:k]..= "'"

        let l:k+= 1
    endwhile

    return l:ns
endfunc

func s:listPPer(list, opts) abort
    " only multi-line if needed:
    " * any item is
    " * total len would be long
endfunc

func s:dictPPer(dict, opts) abort
    " similar to list
    " idquitek about keys tho
endfunc

func s:blobPPer(blob, opts) abort
    " not sure, likely the 0z notation, with '.'s and '\n's
endfunc

" public functions {{{1
let s:pper_map = {1: 's:strPPer', 3: 's:listPPer', 4: 's:dictPPer', 10: 's:blobPPer'}->map('funcref(v:val)')

func PPl(ny, opts={}) abort
    " pretty print to a list of lines
    " (without trailing \n nor leading \\)
    eval a:opts->has_key() ?? a:opts->extend(s:default_opts, 'keep')
    let l:PPer = s:pper_map->get(type(a:ny))
    return 0 == l:PPer ? [string(a:ny)] : l:PPer(a:ny, a:opts)
endfunc

func PP(ny) abort
    " pretty print to |:echo| and forward value
    " (with trailing \n and leading \\)
    echo a:ny
    "echo '\ '..PPl(a:ny)->join("\n\\ ").."\n" " TODO: use echoh+echon
    return a:ny
endfunc

" testing {{{1
"finish
let v:errors = []

cal assert_equal(1, 2)
cal assert_notequal(2, 2)

"cal PP(v:errors->mapnew('v:val->fnamemodify(":t")'))
ec "v:errors:\n\t"..v:errors->mapnew('v:val->fnamemodify(":t")')->join("\n\t").."\n"
