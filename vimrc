set runtimepath+=~/.local/share/nvim/site
set incsearch hls
set laststatus=2 ruler showcmd
set backspace=indent,eol,start

execute "source ". expand("<sfile>:h") ."/init.vim"
