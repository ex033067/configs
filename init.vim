execute "source ". expand("<sfile>:h") ."/plugins.vim"
execute "source ". expand("<sfile>:h") ."/functions.vim"


" Mappings
" --------

let mapleader=","
let maplocalleader="\\"

map <leader><leader> :update<CR>
map <leader>2 :NERDTreeToggle<CR>

" Toggle settings
map <Space> :noh<CR>
map <leader>L :set cul!<CR>
map <leader>N :set nu!<CR>
map <leader>W :set wrap!<CR>

" Navigate the quick fix list
map <leader>< :cprev<CR>
map <leader>> :cnext<CR>

" Git
noremap GG G
map GA :!git add % <CR>
map GC :Git commit -v <CR>
map Gd :Gdiff <CR>
map GD :Git diff % <CR>
map GL :Git l <CR>
map GP :Git add --patch % <CR>

" Toggle comment
nmap <leader>c :let g:nerd_comment_type='toggle'<CR>:set opfunc=Ban_ExecNERDCommenterWithMotion<CR>g@
xmap <leader>cc <Plug>NERDCommenterToggle
nmap <leader>cc <Plug>NERDCommenterToggle

" Force comment line(s) even if already commented
xmap <leader>ca <Plug>NERDCommenterComment
nmap <leader>ca <Plug>NERDCommenterComment

" Add delimiters to selected text
xmap <leader>d :call Ban_AddDelimiterToSelectedText()<CR>

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
set guicursor=a:blinkon100
syntax reset
colo almostmonochrome
set listchars=tab:»·,trail:~,nbsp:·,extends:→,precedes:←

set shiftwidth=0 " indent with tabstop length
set mouse=n " enable mouse in normal mode

set hidden

set grepprg=ack\ --nogroup\ $*


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
