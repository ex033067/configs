set runtimepath+=~/.local/share/nvim/site
set hls
set incsearch
set ruler
set laststatus=2
set backspace=indent,eol,start
execute "source ". expand("<sfile>:h") ."/init.vim"
