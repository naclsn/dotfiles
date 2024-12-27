" TODO: hello


" s: functions {{{1
fu s:attrs(ind, l)
  let l = a:l->mapnew({_, attr -> a:ind..attr->substitute('\w\+=\zs.*', '\=''"''..escape(submatch(0), ''"'')..''"''', '')})
  retu empty(a:ind) ? empty(l) ? '' : ' ['..join(l)..']' : l
endf

fu s:indexafter(l, fst, snd)
  let at = a:l->index(a:fst)+1
  retu at + a:l[at:]->index(a:snd)
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
  let at = s:indexafter(g:gvbuf->getbufline(1, '$'),
    \ 'digraph {',
    \ '')+1

  ev (['    subgraph cluster_'..a:name..' {'] +
    \ s:attrs('        ', a:000) +
    \ ['    }', ''])
    \ ->appendbufline(g:gvbuf, at)
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
    \ : s:indexafter(g:gvbuf->getbufline(1, '$'),
    \   '    subgraph cluster_'..a:000[cluster][len('in='):]..' {',
    \   '    }')

  ev [(cluster < 0 ? '    ' : '        ')..a:name..s:attrs('', a:000)]
    \ ->appendbufline(g:gvbuf, at)
endf

fu s:GVEdge(from, to, ...)
  "" some attrs:
  ""  0. label
  ""  0. class
  ""  0. style
  let at = g:gvbuf->getbufinfo()[0].linecount-1

  ev ['    '..a:from..' -> '..a:to..s:attrs('', a:000)]
    \ ->appendbufline(g:gvbuf, at)
endf

" completion {{{2
let s:attr_compl = #{
  \ class: 0,
  \ in: {-> g:gvbuf
  \   ->getbufline(1, '$')
  \   ->filter('v:val =~ "^    subgraph cluster_"')
  \   ->map('v:val->matchstr(''_\zs\w\+'')')},
  \ label: {lead -> glob(lead..'*', 1, 1)->map('v:val->fnameescape()')},
  \ margin: 0,
  \ rank: 'same min source max sink'->split(),
  \ rankdir: 'TB BT LR RL'->split(),
  \ shape: 'assembly box box3d cds circle component cylinder diamond doublecircle doubleoctagon egg ellipse fivepoverhang folder hexagon house insulator invhouse invtrapezium invtriangle larrow lpromoter none note noverhang octagon oval parallelogram pentagon plain plaintext point polygon primersite promoter proteasesite proteinstab rarrow record rect rectangle restrictionsite ribosite rnastab rpromoter septagon signature square star tab terminator threepoverhang trapezium triangle tripleoctagon underline utr'->split(),
  \ style: 0,
  \ tooltip: {lead -> glob(lead..'*', 1, 1)->map('v:val->fnameescape()')}}

fu s:compl(lead, _line, _pos)
  let attr = a:lead->matchstr('^\w\+\ze=.*')

  let F = s:attr_compl->get(attr)
  let t = type(F)
  let r = (t
    \   ? (3 == t ? F : F(a:lead[len(attr)+1:]->expand()))->mapnew('attr.."="..v:val')
    \   : s:attr_compl->keys()->map('v:val.."="'))
    \ ->sort()

  if '=' != a:lead[len(attr)]
    ev r->extend(g:gvbuf
      \ ->getbufline(1, '$')
      \ ->filter('v:val =~ ''^\v    (    )?\w+($| [)''')
      \ ->map('v:val->matchstr(''\w\+'')')
      \ ->sort(), 0)
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
