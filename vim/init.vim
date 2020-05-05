" ========================
" Neovim specific settings
" ========================

execute 'source '. expand('<sfile>:h') .'/common_settings.vim'

" Terminal
" --------
tnoremap <expr> <C-r> '<C-\><C-n>"'.nr2char(getchar()).'pi' | " Paste in terminal mode
autocmd TermOpen * startinsert | " Open terminal in insert mode

"
" Language providers
" ------------------

let g:python_host_prog  = $PYENV_ROOT .'/shims/python2'
let g:python3_host_prog  = $PYENV_ROOT .'/shims/python3'


" Fix inconsistencies
" -------------------

" I don't know why neovim sets $LANG to 'en_BR', even if started with no
" 'vimrc' ('nvim -u NONE'). This makes 'ack' show a warning message every
" time it runs under neovim.
let $LANG=''


" Adjust terminal colors
" ----------------------

let g:terminal_color_0  = '#000000' | " black
let g:terminal_color_1  = '#A10605' | " dark red
let g:terminal_color_2  = '#206B00' | " dark green
let g:terminal_color_3  = '#D48E15' | " orange (dark yellow)
let g:terminal_color_4  = '#0D52BF' | " dark blue
let g:terminal_color_5  = '#7239B3' | " violet (dark magenta)
let g:terminal_color_6  = '#05979A' | " dark cyan
let g:terminal_color_7  = '#888A85' | " dark gray
let g:terminal_color_8  = '#555753' | " darker gray
let g:terminal_color_9  = '#ED5252' | " red
let g:terminal_color_10 = '#68B723' | " green
let g:terminal_color_11 = '#F9C440' | " yellow
let g:terminal_color_12 = '#3589E6' | " blue
let g:terminal_color_13 = '#A56DE2' | " purple
let g:terminal_color_14 = '#36C0C0' | " light cyan
let g:terminal_color_15 = '#ffffff' | " white
