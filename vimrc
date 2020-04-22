unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

" Enable filering the quickfix list. See details with `:h cfilter-plugin`
packadd cfilter

execute 'source '. expand('<sfile>:h') .'/settings.vim'

set hls
set ttymouse=xterm2  | " enable resizing windows with the mouse
set scrolloff=0

autocmd TerminalWinOpen * setlocal nonumber norelativenumber
