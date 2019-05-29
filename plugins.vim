let NERDCreateDefaultMappings = 0
let NERDMenuMode = 0
let NERDCommentEmptyLines = 1
let NERDDefaultAlign='left'
let NERDSpaceDelims = 1
let NERDTrimTrailingWhitespace = 1
let NERDTreeHijackNetrw = 0

call plug#begin('~/.cache/vim-plug')
Plug 'junegunn/vim-plug'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'viniciusban/vim-polyglot'
Plug 'viniciusban/vim-ft-markdown'
Plug 'viniciusban/vim-almostmonochrome'
call plug#end()

filetype plugin indent on
syntax enable

