" ==================================
" Common settings for vim and neovim
" ==================================

let g:my_additional_installs_dir = '~/.local/share/vim'
execute('set runtimepath+=' . g:my_additional_installs_dir)

" plugins
let must_install_plugins = 0
if empty(glob(g:my_additional_installs_dir . '/autoload/plug.vim'))
    let command = '!curl -fLo ' . g:my_additional_installs_dir . '/autoload/plug.vim' .
        \ ' --create-dirs ' .
        \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    execute(command)
    let must_install_plugins = 1
endif
if empty(glob(g:my_additional_installs_dir .  '/bundle/plugins_installed.txt'))
    let must_install_plugins = 1
endif

call plug#begin(g:my_additional_installs_dir . '/bundle')
Plug 'viniciusban/vim-polyglot'  | " up to date syntax files
Plug 'viniciusban/vim-distractionfree-colorschemes'
Plug 'luochen1990/rainbow' | " colorize parentheses
Plug 'ap/vim-css-color'  | " show the color in CSS
Plug 'tpope/vim-commentary'  | " gcc, gc<motion>, {Visual}gc
Plug 'machakann/vim-sandwich'  | " sa, sd, sr
Plug 'andymass/vim-matchup'  | " %, g%, a%, i%, and more
Plug 'kana/vim-textobj-user' | " required by other text object plugins
Plug 'kana/vim-textobj-indent' | " ai, ii
Plug 'glts/vim-textobj-comment' | " ac, ic (remapped below to...)
Plug 'bps/vim-textobj-python' | " ac, ic, af, if.
Plug 'jeetsukumaran/vim-pythonsense' | " ad, id (docstring objects). See https://github.com/viniciusban/myconfigs/issues/1
Plug 'inkarkat/vim-ReplaceWithRegister'  | " <register>gr{motion}, {Visual}<register>gr
Plug 'tpope/vim-unimpaired'  | " [q, ]q, [e, ]e, etc.
Plug 'davidhalter/jedi-vim'
Plug 'SirVer/ultisnips'
Plug 'viniciusban/vim-ft-markdown'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', {'dir': g:my_additional_installs_dir . '/bundle/fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
call plug#end()

filetype plugin indent on
syntax enable

if must_install_plugins == 1
    echo 'Installing plugins...'
    silent! PlugInstall
    call writefile([''], expand(g:my_additional_installs_dir . '/bundle/plugins_installed.txt'), 'a')
    quitall
endif

" rainbow
let g:rainbow_active = 0
let g:rainbow_conf = {
    \ 'operators': '',
    \ 'guis': ['bold'],
    \ 'guifgs': ['seagreen3', 'magenta', 'royalblue3', 'orange', 'firebrick'],
\}

" vim-text-object-comment
omap aC <Plug>(textobj-comment-a)
xmap aC <Plug>(textobj-comment-a)
omap iC <Plug>(textobj-comment-i)
xmap iC <Plug>(textobj-comment-i)

" vim-textobj-python
let g:is_pythonsense_suppress_object_keymaps = 1

" jedi-vim
let g:jedi#popup_on_dot=0
let g:jedi#show_call_signatures_delay=100

" ultisnips
let g:UltiSnipsSnippetDirectories=[$HOME.'/src/vim-snippets']

" emmet
let g:user_emmet_leader_key = '<C-\>'

" NERDTree
let NERDTreeIgnore=['__pycache__[[dir]]']
let NERDCreateDefaultMappings = 0
let NERDMenuMode = 0
let NERDCommentEmptyLines = 1
let NERDDefaultAlign='left'
let NERDSpaceDelims = 1
let NERDTrimTrailingWhitespace = 1
let NERDTreeHijackNetrw = 0

" my own functions
function! Ban_Run(command)
    " Run an external command using internal or external terminal

    if !exists('g:ban_run_internal')
        if has('gui_running')
            let g:ban_run_internal = 1
        elseif has('nvim')
            let g:ban_run_internal = 1
        else
            let g:ban_run_internal = 0
        endif
    endif

    let quote = "'"
    if g:ban_run_internal == 1
        if has('nvim')
            let prefix = 'tabnew | terminal '. &shell .' -c ' . quote
            let suffix = quote
        else
            let prefix = 'tabnew | terminal ++curwin ++shell '
            let suffix = ''
        endif
        let command = substitute(a:command, quote, "'\"\\'\"'", 'g')
        let command = substitute(command, '#', '\\#', 'g')
    else
        let prefix = '!'
        let command = a:command
        let suffix = ''
    endif

    return prefix . command . suffix
endfunction

" Enable filtering the quickfix list. See `:h cfilter-plugin`
packadd cfilter


" Mappings
" --------

let mapleader=','
let maplocalleader='\'

nmap <CR> :update<CR>
nmap <BS> :noh<CR>
nmap <Space> <C-F>
map <leader>2 :NERDTreeToggle<CR>
map <leader>4 :execute 'colorscheme ' . g:next_colorscheme <CR>
map <leader>6 :b # <CR>

if !has('clipboard') && executable('clip.exe')
    vmap <leader>y "sy:call system('clip.exe', @s)<CR>
else
    vmap <leader>y "+y
endif

" Show highlight group of word under cursor
map <leader>0 :echo 'hi<' . synIDattr(synID(line('.'),col('.'),1),'name') . '> trans<'
    \ . synIDattr(synID(line('.'),col('.'),0),'name') . '> lo<'
    \ . synIDattr(synIDtrans(synID(line('.'),col('.'),1)),'name') . '>'<CR>


" Options
" -------

set termguicolors
syntax reset
silent! colorscheme whiteonblack
let &t_SI = "\<Esc>]12;green\x7" | " solid non-blinking cursor
let &t_SR = &t_SI
let &t_EI = &t_SI
set list listchars=tab:››,trail:·,nbsp:·,extends:→,precedes:←
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
