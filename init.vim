execute "source ". expand("<sfile>:h") ."/plugins.vim"
execute "source ". expand("<sfile>:h") ."/functions.vim"


" Mappings
" --------

let mapleader=","
let maplocalleader="\\"

map <Space> :noh<CR>
map <leader>2 :NERDTreeToggle<CR>
map <leader>0 :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
	\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
	\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Move through the quickfix list
map <leader>< :cprev<CR>
map <leader>> :cnext<CR>


" Appearance
" ----------

set termguicolors
set background=light
syntax reset
colo vim-almostmonochrome

set listchars=tab:»·,trail:~,nbsp:·,extends:→,precedes:←


" Other
" -----

set grepprg=ack\ --nogroup\ $*

autocmd TermOpen * startinsert
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

set mouse=n " enable mouse in normal mode.
set tabstop=4
set shiftwidth=0 " indent with tabstop width
