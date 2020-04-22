" ==================================
" Common settings for vim and neovim
" ==================================

let g:my_additional_installs_dir = '~/.local/share/vim'
execute('set runtimepath+=' .. g:my_additional_installs_dir)
execute 'source '. expand('<sfile>:h') .'/plugins.vim'
execute 'source '. expand('<sfile>:h') .'/functions.vim'


" Mappings
" --------

let mapleader=','
let maplocalleader='\'

nmap <CR> :update<CR>
nmap <BS> :noh<CR>
nmap <Space> <C-F>
nmap <S-Space> <C-B>
map <leader>2 :NERDTreeToggle<CR>
map <leader>3 :FZF<CR>
map <leader>6 :b # <CR>

vmap <leader>y "+y
if !has('clipboard') && executable('clip.exe')
    vmap <leader>y "gy:call system('clip.exe', @g)<CR>
endif

" Git
map <leader>ga :terminal ++shell ++close git add % 
map <leader>gd :terminal ++shell git diff % <CR><C-W>_
map <leader>gc :terminal ++shell ++close git commit -v 
map <leader>gl :terminal ++shell ++noclose git l 

" Add delimiters to selected text
xmap <leader>D :call Ban_AddDelimiterToSelectedText()<CR>

" Show highlight group of word under cursor
map <leader>0 :echo 'hi<' . synIDattr(synID(line('.'),col('.'),1),'name') . '> trans<'
    \ . synIDattr(synID(line('.'),col('.'),0),'name') . '> lo<'
    \ . synIDattr(synIDtrans(synID(line('.'),col('.'),1)),'name') . '>'<CR>


" Options
" -------

set termguicolors
syntax reset
silent! colorscheme oldschoolcolors
set guicursor=a:blinkon100
set list listchars=tab:--»,trail:·,nbsp:·,extends:→,precedes:←
set cpoptions+=n showbreak=→\ 
set expandtab tabstop=4 shiftwidth=0 softtabstop=4 | " <TAB> is 4 spaces, once for all!
set mouse=n | " enable mouse in normal mode
set hidden
set grepprg=ack\ --nogroup\ $*
set ignorecase smartcase
set number
set wildmode=list:longest,full


" Autocommands
" ------------

autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line('$') | exe 'normal! g`"' | endif
autocmd BufReadPost *.todo setlocal filetype=todo
