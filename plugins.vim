let NERDCreateDefaultMappings = 0
let NERDMenuMode = 0
let NERDCommentEmptyLines = 1
let NERDDefaultAlign='left'
let NERDSpaceDelims = 1
let NERDTrimTrailingWhitespace = 1

let g:neosnippet#snippets_directory = '~/projects/vim-config.tool/local-snippets'

if dein#load_state('~/.cache/dein')
	call dein#begin('~/.cache/dein', [expand('$MYVIMRC'), expand('<sfile>')])
	call dein#add('Shougo/dein.vim')
	call dein#add('tpope/vim-fugitive')
	call dein#add('scrooloose/nerdtree')
	call dein#add('scrooloose/nerdcommenter')
	call dein#add('Shougo/neosnippet.vim')
	call dein#add('Shougo/neosnippet-snippets')
	call dein#add('viniciusban/vim-polyglot')
	call dein#add('viniciusban/vim-ft-markdown')
	call dein#add('viniciusban/vim-almostmonochrome')
	call dein#add('python-rope/ropevim')
	call dein#end()
	call dein#save_state()
endif

filetype plugin indent on
syntax enable

" Install not installed plugins on startup.
if dein#check_install()
	call dein#install()
endif
