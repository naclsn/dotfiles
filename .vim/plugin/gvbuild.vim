" Build a dot-graphviz-based [mental-] map while browsing a codebase..
"
" Commands have some completion.
"
"   :GVG[raph] <filename.gv> rankdir=LR [and other attr]
"
" This will load the buffer in the back and set it to receive updates.
"
"   :GVC[luster] c1 label=yey\ how\ you? [other attr]
"   :GVN[ode] n1 in=c1 label=% [other attr]
"   :GVN[ode] n2 tooltip=hello [other attr]
"   :GVE[dge] n1 n2 style=dashed [..]
"
"   digraph {
"       rankdir="LR"
"
"       subgraph cluster_c1 {
"           label="yey how you?"
"           n1 [label="<% at time of the n1 command>"]
"       }
"
"       n2 [tooltip="hello"]
"       n1 -> n2 [style="dashed"]
"   }
"
" If python "xdot" is installed, this will open it in an other window
" and it should get updated as the buffer is edited:
"
"   :GVX[dot]
"
" Last Change:	2024 Dec 27
" Maintainer:	a b <a.b@c.d>
" License:	This file is placed in the public domain.
"
"  Just, know what you're using and doing-

" s: functions {{{1
fu s:attrs(ind, l)
  let l = a:l->mapnew({_, attr -> a:ind..attr->substitute('\w\+=\zs.*', '\=''"''..escape(submatch(0)->expand(), ''"'')..''"''', '')})
  retu empty(a:ind) ? empty(l) ? '' : ' ['..join(l)..']' : l
endf

fu s:indexafter(l, fst, snd)
  let at = a:l->index(a:fst)+1
  retu at + a:l[at:]->index(a:snd)
endf

fu s:lines()
  retu g:gvbuf->getbufline(1, '$')
endf

fu s:update(at, l)
  ev a:l->appendbufline(g:gvbuf, a:at)
  ev s:lines()->writefile(g:gvbuf->bufname()->resolve())
  cal setbufvar(g:gvbuf, '&mod', 0)
endf

" command functions {{{2
fu s:GVGraph(...)
  "" some attrs:
  ""  0. rankdir=LR|TB
  ""  0. rank=same
  let g:gvbuf = empty(a:000) ? bufnr() : bufadd(a:000[0])
  let name = g:gvbuf->bufname()
  if name !~ '.gv$'
    unl g:gvbuf
    th "buffer name doesn't end in '.gv': '"..name..", refusing to edit!"
  en
  ev g:gvbuf->bufload()

  if 1 == g:gvbuf->getbufinfo()[0].linecount
    ev (['digraph {'] +
      \ s:attrs('    ', a:000[1:]) +
      \ ['', '}'])
      \ ->setbufline(g:gvbuf, 1)
  en
endf

fu s:GVCluster(name, ...)
  "" some attrs:
  ""  0. label
  ""  0. rank
  let at = s:indexafter(s:lines(),
    \ 'digraph {',
    \ '')+1

  cal s:update(at,
    \ ['    subgraph cluster_'..a:name..' {'] +
    \ s:attrs('        ', a:000) +
    \ ['    }', ''])
endf

fu s:GVNode(name, ...)
  "" some attrs:
  ""  0. in=<name> ('fake' attr, not a dot/gv one)
  ""  0. label
  ""  0. tooltip
  ""  0. shape
  ""  0. class
  ""  0. style
  let cluster = a:000->match('^in=')
  let at = cluster < 0
    \ ? g:gvbuf->getbufinfo()[0].linecount-1
    \ : s:indexafter(s:lines(),
    \   '    subgraph cluster_'..a:000[cluster][len('in='):]..' {',
    \   '    }')

  cal s:update(at,
    \ [(cluster < 0 ? '    ' : '        ')..a:name..s:attrs('', a:000)])
endf

fu s:GVEdge(from, to, ...)
  "" some attrs:
  ""  0. label
  ""  0. class
  ""  0. style
  let at = g:gvbuf->getbufinfo()[0].linecount-1

  cal s:update(at,
    \ ['    '..a:from..' -> '..a:to..s:attrs('', a:000)])
endf

" completion {{{2
let s:compl_map = #{
  \ class: 0,
  \ in: {-> s:lines()
  \   ->filter('v:val =~ "^    subgraph cluster_"')
  \   ->map('v:val->matchstr(''_\zs\w\+'')')},
  \ label: {lead -> glob(lead..'*', 1, 1)->map('v:val->fnameescape()')},
  \ margin: 0,
  \ rank: 'same min source max sink'->split(),
  \ rankdir: 'TB BT LR RL'->split(),
  \ shape: 'assembly box box3d cds circle component cylinder diamond doublecircle doubleoctagon egg ellipse fivepoverhang folder hexagon house insulator invhouse invtrapezium invtriangle larrow lpromoter none note noverhang octagon oval parallelogram pentagon plain plaintext point polygon primersite promoter proteasesite proteinstab rarrow record rect rectangle restrictionsite ribosite rnastab rpromoter septagon signature square star tab terminator threepoverhang trapezium triangle tripleoctagon underline utr'->split(),
  \ style: 'bold dashed diagonals dotted filled invis rounded solid striped tapered wedged'->split(),
  \ tooltip: {lead -> glob(lead..'*', 1, 1)->map('v:val->fnameescape()')}}

fu s:compl(lead, _line, _pos)
  let attr = a:lead->matchstr('^\w\+\ze=.*')

  let F = s:compl_map->get(attr)
  let t = type(F)
  let r = (t
    \   ? (3 == t ? F : F(a:lead[len(attr)+1:]->expand()))->mapnew('attr.."="..v:val')
    \   : s:compl_map->keys()->map('v:val.."="'))
    \ ->sort()

  if '=' != a:lead[len(attr)]
    ev r->extend(s:lines()
      \   ->filter('v:val =~ ''^\v    (    )?\w+($| [)''')
      \   ->map('v:val->matchstr(''\w\+'')')
      \   ->sort(), 0)
  el
    let pat = '\v<'..attr..'>\="([^\\"]|.*)"'
    ev r->extend(s:lines()
      \   ->filter('v:val =~ pat')
      \   ->map('v:val->matchlist(pat)[1]'), 0)
      \ ->sort()->uniq()
  en

  let n = a:lead->len()-1
  retu empty(a:lead) ? r : r->filter('v:val[:n] == a:lead')
endf

" commands {{{1
com -bar -nargs=* -complete=file               GVGraph   cal s:GVGraph  (<f-args>)
com -bar -nargs=+ -complete=customlist,s:compl GVCluster cal s:GVCluster(<f-args>)
com -bar -nargs=+ -complete=customlist,s:compl GVNode    cal s:GVNode   (<f-args>)
com -bar -nargs=+ -complete=customlist,s:compl GVEdge    cal s:GVEdge   (<f-args>)

com -bar GVXdot cal system('python3 -m xdot '..g:gvbuf->bufname()->shellescape()..' &')

" vim: se fdm=marker fdl=0 ts=2:
