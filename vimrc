" ========================
" Vim specific settings
" ========================

unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

" Enable filering the quickfix list. See details with `:h cfilter-plugin`
packadd cfilter

execute 'source '. expand('<sfile>:h') .'/settings.vim'

" Simple settings
" ---------------

set hls
set ttymouse=xterm2  | " enable resizing windows with the mouse
set scrolloff=0


" Terminal mode
" -------------

autocmd TerminalWinOpen * setlocal nonumber norelativenumber


" Git
" ---

map <leader>ga :terminal ++shell ++close git add % 
map <leader>gd :terminal ++shell git diff % <CR><C-W>_
map <leader>gc :terminal ++shell ++close git commit -v 
map <leader>gl :terminal ++shell ++noclose git l 
