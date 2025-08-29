fu Lcov(file)
  %argd
  sign unplace * group=lcov
  sign define lcovok text=ok texthl=IncSearch
  sign define lcovko text=ko texthl=ErrorMsg

  let stats = {}
  for line in readfile(a:file)

    if line =~ '^SF:'
      let cur = line[3:]
      exe 'arge' cur
      setl scl=number
      let phits = 0 " line '-1', say, not covered

    elsei line =~ '^DA:'
      let [lnum, hits] = line[3:]->split(',')
      " basic heurstic: a line with no kwchar is likely not meaningfull (eg.
      " closing if in C-like); mark as not covered only if previous also so)
      " ((this will be wrong for many occasion - as simple as a comment line))
      if !hits && getline(lnum) !~ '\k' |let hits = phits |en
      exe 'sign place' lnum 'line='..lnum 'name=lcov'..(hits ? 'ok' : 'ko') 'group=lcov file='..fnameescape(cur)
      let phits = hits

    elsei line =~ '^FNF:' |let fnf = str2nr(line[3:])*1.0
    elsei line =~ '^FNH:' |let fnh = str2nr(line[3:])*1.0
    elsei line =~ '^BRF:' |let brf = str2nr(line[3:])*1.0
    elsei line =~ '^BRH:' |let brh = str2nr(line[3:])*1.0
    elsei line =~ '^LF:'  |let lf  = str2nr(line[3:])*1.0
    elsei line =~ '^LH:'  |let lh  = str2nr(line[3:])*1.0

    elsei line =~ '^end_of_record'
      let stats[cur] = #{function: fnh/(fnf??1), branch: brh/(brf??1), line: lh/(lf??1)}

    en
  endfo
  argded
  rew

  retu stats
endf

fu s:lcov_table(stats)
  echom 'function | branch  | line    | file'
  echom '---------+---------+---------+-'
  for it in a:stats->items()
    echom printf(' %7.3f | %7.3f | %7.3f |', it[1].function*100, it[1].branch*100, it[1].line*100) it[0]
  endfo
  echom
  echom '(remove with :sign unplace * group=lcov)'
endf

com! -nargs=1 -complete=file Lcov cal s:lcov_table(Lcov(<q-args>))

" vi:se ts=2:
