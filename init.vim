set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim
execute "source ". expand("<sfile>:h") ."/plugins.vim"
execute "source ". expand("<sfile>:h") ."/functions.vim"


" Mappings
" --------

let mapleader=","
let maplocalleader="\\"

" Show highlight group of word under cursor
map <leader>0 :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
	\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
	\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

map <Space> :noh<CR>
map <leader>2 :NERDTreeToggle<CR>

map <leader>< :cprev<CR>
map <leader>> :cnext<CR>

" Toggle comment in line(s)
nmap <leader>c :let g:nerd_comment_type='toggle'<CR>:set opfunc=Ban_ExecNERDCommenterWithMotion<CR>g@
xmap <leader>cc <Plug>NERDCommenterToggle
nmap <leader>cc <Plug>NERDCommenterToggle

" Force comment line(s) even if already commented
xmap <leader>ca <Plug>NERDCommenterComment
nmap <leader>ca <Plug>NERDCommenterComment

" Paste in terminal mode
tnoremap <expr> <C-r> '<C-\><C-n>"'.nr2char(getchar()).'pi'

" Options
" -------

set termguicolors
set background=light
syntax reset
colo almostmonochrome
set listchars=tab:»·,trail:~,nbsp:·,extends:→,precedes:←

set shiftwidth=0 " indent with tabstop length
set mouse=n " enable mouse in normal mode

set grepprg=ack\ --nogroup\ $*


" Autocommands
" ------------

autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
autocmd BufReadPost *.todo setlocal filetype=todo
autocmd TermOpen * startinsert
