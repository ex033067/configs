call plug#begin('~/.local/share/nvim/vim-plug')
Plug 'junegunn/vim-plug'


" Syntax and highlighting
" -----------------------

Plug 'viniciusban/vim-polyglot'
Plug 'viniciusban/vim-almostmonochrome'

let g:rainbow_active = 1
let g:rainbow_conf = {
	\ 'operators': '',
	\ 'guis': ['bold'],
	\ 'guifgs': ['seagreen3', 'magenta', 'royalblue3', 'orange', 'firebrick'],
\}
Plug 'luochen1990/rainbow'


" Features and shortcuts for improve editing
" ------------------------------------------

Plug 'tpope/vim-commentary'  " gcc, gc<motion>, {Visual}gc
Plug 'machakann/vim-sandwich'

" New text-objects
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent' " ai, ii
Plug 'glts/vim-textobj-comment' " ac, ic

let g:jedi#popup_on_dot=0
Plug 'davidhalter/jedi-vim'

let g:UltiSnipsSnippetDirectories=[$HOME.'/src/vim-snippets']
Plug 'SirVer/ultisnips'
Plug 'viniciusban/vim-ft-markdown'
Plug 'mattn/emmet-vim'


" File searching and handling
" ------------------------------------------

Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', {'dir': '~/.local/share/nvim/vim-plug/fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'

let NERDTreeIgnore=['__pycache__[[dir]]']
let NERDCreateDefaultMappings = 0
let NERDMenuMode = 0
let NERDCommentEmptyLines = 1
let NERDDefaultAlign='left'
let NERDSpaceDelims = 1
let NERDTrimTrailingWhitespace = 1
let NERDTreeHijackNetrw = 0
Plug 'scrooloose/nerdtree'

call plug#end()

filetype plugin indent on
syntax enable

