noremap <C-C> :q<CR>
noremap <C-S> :w<CR>
noremap U <C-R>
noremap l <space>
noremap h <BS>
noremap ge G
noremap gh 0
noremap gl $
noremap gs ^
noremap gn :bn<CR>
noremap gp :bp<CR>
noremap x V
noremap s :s/
command! -nargs=1 Indent set tabstop=<args> shiftwidth=<args>
set nu list listchars=tab:>\ ,trail:~ laststatus=2
