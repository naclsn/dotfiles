" Build a dot-graphviz-based [mental-] map while browsing a codebase..
"
" Commands have some completion.
"
"   :GVG[raph] <filename.gv> rankdir=LR [and other attr]
"
" This will load the buffer in the back and set it to receive updates.
" (Personal choice: <bang> will set colors to some light on gray.)
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
"   :GVX[dot]! " doesn't background if no <bang>
"
" (Lastly, if using the GVG! colors, here's a patch to maybe apply:
"  ~/.local/lib/python3.00/site-packages/xdot/ui/window.py:583
"       window.override_background_color(Gtk.StateFlags.NORMAL, Gdk.RGBA(.2, .2, .2))
"  in "class DotWindow", after "window = self")
"
" Last Change:	2024 Dec 27
" Maintainer:	a b <a.b@c.d>
" License:	This file is placed in the public domain.
"
"  Just, know what you're using and doing-
"
" TODO: fix completion based on in-gv attrs values (doesn't appear at all)
"       ensure consistent undo / have a way to GVU or to edit last thingy

" s: functions {{{1
fu s:attrs(ind, l)
  let l:l = a:l
    \ ->mapnew({_, attr -> a:ind..attr->substitute('\w\+=\zs.*', '\=''"''..escape(submatch(0)->expand(), ''"'')..''"''', '')})
    \ ->filter('v:val !~ "^in="')
    \ ->sort()
  retu empty(a:ind) ? empty(l:l) ? '' : ' ['..join(l:l)..']' : l
endf

fu s:indexafter(l, fst, snd)
  let l:at = a:l->index(a:fst)+1
  retu l:at + a:l[l:at:]->index(a:snd)
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
fu s:GVGraph(gray, name='%', ...)
  "" some attrs:
  ""  0. rankdir=LR|TB
  ""  0. rank=same
  let g:gvbuf = '%' == a:name ? bufnr() : a:name->bufadd()
  let l:name = g:gvbuf->bufname()
  if l:name !~ '.gv$'
    unl g:gvbuf
    th "name doesn't end in '.gv': '"..l:name.."', refusing to edit in case that's a mistake"
  en
  ev g:gvbuf->bufload()

  if 1 == g:gvbuf->getbufinfo()[0].linecount
    ev (['digraph {'] +
      \ s:attrs('    ', a:000) +
      \ (a:gray ? [
        \ '    bgcolor="#333333"',
        \ '    color="#eeeeee" fontcolor="#eeeeee"',
        \ '    node [color="#eeeeee" fontcolor="#eeeeee"]',
        \ '    edge [color="#eeeeee" fontcolor="#eeeeee"]'] : []) +
      \ ['', '}'])
      \ ->setbufline(g:gvbuf, 1)
  en
endf

fu s:GVCluster(name, ...)
  "" some attrs:
  ""  0. label
  ""  0. rank
  if a:name !~ '^\h\w*$'
    th "GVCluster needs a cluster name first; got '"..a:name.."'"
  en
  if -1 != s:lines()->match('^    subgraph cluster_'..a:name)
    th "cluster '"..a:name.."' already exists"
  en

  let l:at = s:indexafter(s:lines(),
    \ 'digraph {',
    \ '')+1

  cal s:update(l:at,
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
  if a:name !~ '^\h\w*$'
    th "GVNode needs a node name first; got '"..a:name.."'"
  en
  if -1 != s:lines()->match('^\v    (    )?'..a:name..'+($| [)')
    th "node '"..a:name.."' already exists"
  en
  let l:cluster = a:000->matchstr('^in=\zs.*')[3:]
  if !empty(l:cluster) && l:cluster !~ '^\h\w*$'
    th "GVNode's `in=` needs a cluster name; got '"..l:cluster.."'"
  en

  let l:at = empty(cluster)
    \ ? g:gvbuf->getbufinfo()[0].linecount-1
    \ : s:indexafter(s:lines(),
    \   '    subgraph cluster_'..cluster..' {',
    \   '    }')

  cal s:update(l:at,
    \ [(cluster < 0 ? '    ' : '        ')..a:name..s:attrs('', a:000)])
endf

fu s:GVEdge(from, to, ...)
  "" some attrs:
  ""  0. label
  ""  0. class
  ""  0. style
  if a:from !~ '^\h\w*$' || a:to !~ '^\h\w*$'
    th "GVEdge needs two node names first; got '"..a:from.."' and '"..a:to.."'"
  en

  let l:at = g:gvbuf->getbufinfo()[0].linecount-1

  cal s:update(l:at,
    \ ['    '..a:from..' -> '..a:to..s:attrs('', a:000)])
endf

" completion {{{2
let s:colors = 'black red green yellow blue magenta cyan gray white transparent \#333333 \#eeeeee'->split()
let s:arrows = 'box crow diamond dot ediamond empty halfopen inv invdot invempty invodot none normal obox odiamond odot open tee vee'->split()
let s:compl_map = #{
  \ arrowhead: s:arrows,
  \ arrowtail: s:arrows,
  \ bgcolor: s:colors,
  \ class: 0,
  \ color: s:colors,
  \ fillcolor: s:colors,
  \ fontcolor: s:colors,
  \ in: {-> s:lines()->filter('v:val =~ "^    subgraph cluster_"')->map('v:val->matchstr(''_\zs\w\+'')')},
  \ label: {lead -> glob(lead..'*', 1, 1)->map('v:val->fnameescape()')},
  \ layout: 'circo dot fdp neato nop nop1 nop2 osage patchwork sfdp twopi'->split(),
  \ margin: 0,
  \ pad: 0,
  \ rank: 'same min source max sink'->split(),
  \ rankdir: 'TB BT LR RL'->split(),
  \ shape: 'assembly box box3d cds circle component cylinder diamond doublecircle doubleoctagon egg ellipse fivepoverhang folder hexagon house insulator invhouse invtrapezium invtriangle larrow lpromoter none note noverhang octagon oval parallelogram pentagon plain plaintext point polygon primersite promoter proteasesite proteinstab rarrow record rect rectangle restrictionsite ribosite rnastab rpromoter septagon signature square star tab terminator threepoverhang trapezium triangle tripleoctagon underline utr'->split(),
  \ style: 'bold dashed diagonals dotted filled invis rounded solid striped tapered wedged'->split(),
  \ tooltip: {lead -> glob(lead..'*', 1, 1)->map('v:val->fnameescape()')}}

fu s:compl(lead, _line, _pos)
  let l:attr = a:lead->matchstr('^\w\+\ze=.*')

  let F = s:compl_map->get(l:attr)
  let t = type(l:F)
  let r = (l:t
    \   ? (3 == l:t ? l:F : l:F(a:lead[len(l:attr)+1:]->expand()))->mapnew('l:attr.."="..v:val')
    \   : s:compl_map->keys()->map('v:val.."="'))
    \ ->sort()

  if '=' != a:lead[len(l:attr)]
    ev r->extend(s:lines()
      \   ->filter('v:val =~ ''^\v    (    )?\w+($| [)''')
      \   ->map('v:val->matchstr(''\w\+'')')
      \   ->sort(), 0)
  el
    let l:pat = '\v<'..l:attr..'>\="([^\\"]|.*)"'
    ev r->extend(s:lines()
      \   ->filter('v:val =~ l:pat')
      \   ->map('v:val->matchlist(l:pat)[1]'), 0)
      \ ->sort()->uniq()
  en

  let l:n = a:lead->len()-1
  retu empty(a:lead) ? r : r->filter('v:val[:l:n] == a:lead')
endf

" commands {{{1
com -bang -bar -nargs=* -complete=file               GVGraph   cal s:GVGraph  (<bang>0, <f-args>)
com       -bar -nargs=+ -complete=customlist,s:compl GVCluster cal s:GVCluster(<f-args>)
com       -bar -nargs=+ -complete=customlist,s:compl GVNode    cal s:GVNode   (<f-args>)
com       -bar -nargs=+ -complete=customlist,s:compl GVEdge    cal s:GVEdge   (<f-args>)

com -bang -bar GVXdot cal system('python3 -m xdot '..g:gvbuf->bufname()->shellescape()..'&'[<bang>1])

" vim: se fdm=marker fdl=0 ts=2:
