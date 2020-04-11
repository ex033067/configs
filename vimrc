unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

set runtimepath+=~/.local/share/nvim/site
set hls
set ttymouse=xterm2  " enable resizing windows with the mouse
set scrolloff=0

execute "source ". expand("<sfile>:h") ."/init.vim"
