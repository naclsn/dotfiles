" 'Tracks' time lost in Vim based on autocommands
" VimEnter/VimLeave, VimSuspend/VimResume and FocusGained/FocusLost
"
" Last Change:	2024 Dec 08
" Maintainer:	a b <a.b@c.d>
" License:	This file is placed in the public domain.
"
"  Just, know what you're using and doing-
"
" TODO: doc-ish

" g: variables {{{1
if &cp || exists('g:loaded_timet') |fini |en
let g:loaded_timet = 1

if !exists('g:timet_state') |let g:timet_state = expand('~/.cache/timet/') |en
if '/' != g:timet_state[-1:] |let g:timet_state..= '/' |en

cal mkdir(g:timet_state, 'p')

" s: functions {{{1
fu s:log_event(ev)
  cal writefile([getcwd().."\t"..a:ev.."\t"..strftime('%H:%M:%S')], g:timet_state..strftime('%Y-%m-%d'), 'a')
endf

fu s:TimetDay(day)
  ""
  "" If an argument is given it should be a %Y-%m-%d however:
  ""  0. if it's '%m-%d' then %Y is taken from current year
  ""  0. if it's '%d' then %m is taken from current month
  ""  0. special cases for \<y\%[esterday]\>
  ""  0. and if not given then today
  let today = strftime('%Y-%m-%d')
  if a:day =~ '\<y\%[esterday]\>'
    let [y, m, d] = split(a:day, '-')
    let d-= 1
    if !d
      let m-= 1
      if !m
        let y-= 1
        let m = 12
      en
      let d = [31, 28+(2 == m && 0 == y%4 && (y%100 || 0 == y%400)), 31, 30, 31, 30, 31, 31, 30, 31, 30, 31][m-1]
    en
    let day = y..'-'..m..'-'..d
  el
    let day = a:day ? [today[:7], today[:4], ''][count(a:day, '-')]..a:day : today
  en

  let lns = readfile(g:timet_state..day)
  let r = {}

  let en_evs = split('VimEnter VimResume FocusGained')
  let le_evs = split('VimLeave VimSuspend FocusLost')

  for ln in lns
    let [wd, ev, tm] = split(ln, "\t")
    if !has_key(r, wd)
      let r[wd] = #{active: v:false, last_time: 0, active_time: 0}
    en

    let [h, m, s] = split(tm, ':')
    let tm = (h*60+m)*60+s

    if r[wd].active
      if index(le_evs, ev)+1
        let r[wd].active = v:false
        let r[wd].active_time+= tm - r[wd].last_time
      en
    el
      if index(en_evs, ev)+1
        let r[wd].active = v:true
        let r[wd].last_time = tm
      en
    en
  endfo

  retu r
endf

com! -nargs=? TimetDay ec s:TimetDay(<q-args>)

" autocommands {{{1
aug timet
  au VimEnter    * cal s:log_event('VimEnter')
  au VimSuspend  * cal s:log_event('VimSuspend')
  au VimResume   * cal s:log_event('VimResume')
  au FocusLost   * cal s:log_event('FocusLost')
  au FocusGained * cal s:log_event('FocusGained')
  au VimLeave    * cal s:log_event('VimLeave')
aug END

" vim: se fdm=marker fdl=0 ts=2:
