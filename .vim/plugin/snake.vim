" snek
"
" Last Change:	na
" Maintainer:	no
" License:	This file is placed in the public domain.
"
"  Just, have fun dang it!

let s:best = 799
let s:file = expand('<sfile>:p')

fu s:fwch(h)
    retu nr2char(' ' == a:h ? 0x3000 : char2nr(a:h)+0xfee0)
endf

fu s:goto(x, y)
    cal setcharpos('.', [0, b:yoff+a:y+2, b:xoff+a:x+2, 0])
endf

fu s:start()
    if !exists('b:dir')
        ene
        setl bh=wipe bt=nofile nobl nocuc nocul nonu nornu noswf
        f i m p o r t a n t - w o r k . t x t
    en
    sil%d_

    let b:empty = s:fwch(' ')
    let b:walls = map(['|', '+', '-', '+', '|', '+', '-', '+'], 's:fwch(v:val)')
    let b:width = 20
    let b:height = 20
    let b:xoff = 9
    let b:yoff = 0

    let m = repeat(s:fwch(' '), b:xoff)
    cal append('$', repeat([''], b:yoff))
    cal append('$',         m..b:walls[3]..repeat(b:walls[2], b:width)..b:walls[1])
    cal append('$', repeat([m..b:walls[4]..repeat(b:empty,    b:width)..b:walls[0]], b:height))
    cal append('$',         m..b:walls[5]..repeat(b:walls[6], b:width)..b:walls[7])
    sil1d_

    let b:rev_dir = {'h':'l', 'j':'k', 'k':'j', 'l':'h'}

    let b:dir = 'l'
    let b:pend = []
    map <buffer> <silent> h :cal add(b:pend, 'h')<CR>
    map <buffer> <silent> j :cal add(b:pend, 'j')<CR>
    map <buffer> <silent> k :cal add(b:pend, 'k')<CR>
    map <buffer> <silent> l :cal add(b:pend, 'l')<CR>
    map <buffer> <silent> <Left> h
    map <buffer> <silent> <Down> j
    map <buffer> <silent> <Up> k
    map <buffer> <silent> <Right> l

    let b:tail = s:fwch('o')
    let b:head = s:fwch('e')
    let b:apple = s:fwch('@')

    let b:snake = ['l', 'j']

    cal s:goto(rand()%b:width, rand()%b:height)
    exe 'norm! r'..b:apple

    cal s:goto(0, 0)
    for d in b:snake
        exe 'norm! r'..b:tail..d
    endfo
    exe 'norm! r'..b:head

    cal timer_start(100, function("\<SID>step"), {'repeat':-1})
endf

fu s:step(timer)
    if !exists('b:dir')
        cal timer_stop(a:timer)
        retu
    en

    wh len(b:pend) && b:pend[0] == b:rev_dir[b:dir]
        cal remove(b:pend, 0)
    endw
    if len(b:pend)
        let b:dir = remove(b:pend, 0)
        wh len(b:pend) && b:pend[0] == b:dir
            cal remove(b:pend, 0)
        endw
    en

    exe 'norm! '..b:dir..'vy'
    if b:empty == @"
        cal add(b:snake, b:dir)
        for it in reverse(copy(b:snake))
            let ti = b:rev_dir[it]
            exe 'norm! '..ti..'vy'..it..'vp'..ti
        endfo
        exe 'norm! r'..b:empty..join(b:snake, '')
        cal remove(b:snake, 0)

    elsei b:apple == @"
        exe 'norm! '..b:rev_dir[b:dir]
        let p = getcharpos('.')
        wh b:empty != @"
            cal s:goto(rand()%b:width, rand()%b:height)
            exe 'norm! vy'
        endw
        exe 'norm! r'..b:apple
        cal setcharpos('.', p)
        exe 'norm! r'..b:tail..b:dir..'r'..b:head
        cal add(b:snake, b:dir)

    el
        let score = len(b:snake)*17
        echom 'Score:' score score < s:best ? '(best: '..s:best..')' : '(new best!)'
        if s:best < score
            let lines = readfile(s:file)
            let lines[7] = 'let s:best = '..score
            cal writefile(lines, s:file)
            let s:best = score
        en

        cal timer_stop(a:timer)
        unm <buffer> h
        unm <buffer> j
        unm <buffer> k
        unm <buffer> l
        unm <buffer> <Left>
        unm <buffer> <Down>
        unm <buffer> <Up>
        unm <buffer> <Right>
        map <buffer> <CR> :Snake
    en
endf

com! Snake cal s:start()
