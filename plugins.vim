let NERDTreeIgnore=['__pycache__[[dir]]']
let NERDCreateDefaultMappings = 0
let NERDMenuMode = 0
let NERDCommentEmptyLines = 1
let NERDDefaultAlign='left'
let NERDSpaceDelims = 1
let NERDTrimTrailingWhitespace = 1
let NERDTreeHijackNetrw = 0

let g:UltiSnipsSnippetDirectories=[$HOME.'/projects/vim-snippets']

let g:rainbow_active = 1
let g:rainbow_conf = {
	\ 'operators': '',
	\ 'guis': ['bold'],
	\ 'guifgs': ['seagreen3', 'magenta', 'royalblue3', 'orange', 'firebrick'],
\}

let g:jedi#popup_on_dot=0

call plug#begin('~/.local/share/nvim/vim-plug')
Plug 'junegunn/vim-plug'

# Syntax and highlighting
Plug 'viniciusban/vim-polyglot'
Plug 'viniciusban/vim-almostmonochrome'
Plug 'luochen1990/rainbow'

# Features and shortcuts for improve editing
Plug 'scrooloose/nerdcommenter'
Plug 'machakann/vim-sandwich'
Plug 'davidhalter/jedi-vim'
Plug 'SirVer/ultisnips'
Plug 'viniciusban/vim-ft-markdown'

# File searching and handling
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', {'dir': '~/.local/share/nvim/vim-plug/fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'

call plug#end()

filetype plugin indent on
syntax enable

