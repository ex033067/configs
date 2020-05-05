" ========================
" Vim specific settings
" ========================

unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

execute 'source '. expand('<sfile>:h') .'/common_settings.vim'

" Simple settings
" ---------------

set hls
set ttymouse=xterm2  | " enable resizing windows with the mouse
set scrolloff=0


" Terminal mode
" -------------

silent! autocmd TerminalWinOpen * setlocal nonumber norelativenumber
silent! autocmd TerminalOpen * setlocal nonumber norelativenumber


" Git
" ---

map <leader>ga :terminal ++shell ++close git add % 
map <leader>gd :terminal ++shell git diff % <CR><C-W>_
map <leader>gc :terminal ++shell ++close git commit -v 
map <leader>gl :terminal ++shell ++noclose git l 


" Truecolor under tmux
" --------------------

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
