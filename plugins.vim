let NERDCreateDefaultMappings = 0
let NERDMenuMode = 0
let NERDCommentEmptyLines = 1
let NERDDefaultAlign='left'
let NERDSpaceDelims = 1
let NERDTrimTrailingWhitespace = 1

if dein#load_state('~/.cache/dein')
	call dein#begin('~/.cache/dein')
	call dein#add('Shougo/dein.vim')
	call dein#add('tpope/vim-fugitive')
	call dein#add('scrooloose/nerdtree')
	call dein#add('scrooloose/nerdcommenter')
	call dein#add('viniciusban/vim-polyglot')
	call dein#add('viniciusban/vim-almostmonochrome')
	call dein#end()
	call dein#save_state()
endif

filetype plugin indent on
syntax enable

" Install not installed plugins on startup.
if dein#check_install()
	call dein#install()
endif
