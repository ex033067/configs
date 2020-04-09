execute "source ". expand("<sfile>:h") ."/plugins.vim"
execute "source ". expand("<sfile>:h") ."/functions.vim"


" Mappings
" --------

let mapleader=","
let maplocalleader="\\"

map <leader><leader> :update<CR>
map <leader>2 :NERDTreeToggle<CR>
map <leader>3 :FZF<CR>
map <leader>6 :b # <CR>

vmap <leader>y "+y
if !has('clipboard') && executable('clip.exe')
	vmap <leader>y "gy:call system('clip.exe', @g)<CR>
endif

" Toggle settings
map <Space> :noh<CR>

" Git
map <leader>ga :terminal ++shell ++close git add % 
map <leader>gd :terminal ++shell git diff % <CR><C-W>_
map <leader>gc :terminal ++shell ++close git commit -v 
map <leader>gl :terminal ++shell ++noclose git l 

" Add delimiters to selected text
xmap <leader>D :call Ban_AddDelimiterToSelectedText()<CR>

" Paste in terminal mode
tnoremap <expr> <C-r> '<C-\><C-n>"'.nr2char(getchar()).'pi'

" Show highlight group of word under cursor
map <leader>0 :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
	\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
	\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>


" Options
" -------

set termguicolors
if exists('$VIM_BACKGROUND')
	let &background=$VIM_BACKGROUND
else
	set background=light
endif
syntax reset
colo almostmonochrome
set guicursor=a:blinkon100
set listchars=tab:»·,trail:~,nbsp:·,extends:→,precedes:←
set shiftwidth=0 " indent with tabstop length
set mouse=n " enable mouse in normal mode
set hidden
set grepprg=ack\ --nogroup\ $*
set ignorecase smartcase
set number relativenumber


" Autocommands
" ------------

autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
autocmd BufReadPost *.todo setlocal filetype=todo
if has('nvim')
	autocmd TermOpen * startinsert
endif


" Language providers
" ------------------

let g:python_host_prog  = $PYENV_ROOT .'/shims/python2'
let g:python3_host_prog  = $PYENV_ROOT .'/shims/python3'


" Fix inconsistencies
" -------------------

if has('nvim')
	" I don't know why neovim sets $LANG to 'en_BR', even if started with no
	" 'vimrc' ('nvim -u NONE'). This makes 'ack' show a warning message every
	" time it runs under neovim.
	let $LANG=''
endif


" Adjust terminal colors
" ----------------------

let g:terminal_color_0  = '#000000'
let g:terminal_color_1  = '#A10605'
let g:terminal_color_2  = '#206B00'
let g:terminal_color_3  = '#D48E15'
let g:terminal_color_4  = '#0D52BF'
let g:terminal_color_5  = '#7239B3'
let g:terminal_color_6  = '#05979A'
let g:terminal_color_7  = '#888A85'
let g:terminal_color_8  = '#555753'
let g:terminal_color_9  = '#ED5252'
let g:terminal_color_10 = '#68B723'
let g:terminal_color_11 = '#F9C440'
let g:terminal_color_12 = '#3589E6'
let g:terminal_color_13 = '#A56DE2'
let g:terminal_color_14 = '#36C0C0'
let g:terminal_color_15 = '#ffffff'
