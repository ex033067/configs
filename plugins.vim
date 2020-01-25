let NERDTreeIgnore=['__pycache__[[dir]]']
let NERDCreateDefaultMappings = 0
let NERDMenuMode = 0
let NERDCommentEmptyLines = 1
let NERDDefaultAlign='left'
let NERDSpaceDelims = 1
let NERDTrimTrailingWhitespace = 1
let NERDTreeHijackNetrw = 0

let g:UltiSnipsSnippetDirectories=[$HOME.'/projects/vim-snippets']

call plug#begin('~/.local/share/nvim/vim-plug')
Plug 'junegunn/vim-plug'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'viniciusban/vim-polyglot'
Plug 'viniciusban/vim-ft-markdown'
Plug 'viniciusban/vim-almostmonochrome'
Plug 'machakann/vim-sandwich'

Plug 'junegunn/fzf', { 'dir': '~/.local/share/nvim/vim-plug/fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'SirVer/ultisnips'

call plug#end()

filetype plugin indent on
syntax enable

