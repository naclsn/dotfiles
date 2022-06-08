noremap <C-C> :q<CR>
noremap <C-S> :w<CR>
command! -nargs=1 Indent set tabstop=<args> shiftwidth=<args>
set nu list listchars=tab:>\ ,trail:~ laststatus=2
