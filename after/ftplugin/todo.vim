" todo items
"
" In normal mode:
"
" \* mark item as doing.
" \- mark item as cancelled.
" \x mark item as done.
" \D move item block to done.todo.
"
" z[ jump to previous sibling item.
" z] jump to next sibling item.
" zp jump to parent item.
"
" CTRL+k move item upwards.
" CTRL+j move item downwards.
"

setlocal textwidth=0
setlocal foldmethod=indent
setlocal foldlevel=3
setlocal autoindent
setlocal formatoptions+=n
setlocal comments=fb:-[\ ],fb:-[*],fb:-[x],fb:-,fb:*
setlocal tabstop=4
setlocal expandtab

" Add items
imap <silent> <buffer> -<Tab> -<Esc>:call ban#todo#AddNewTodoItem()<CR>^xA
imap <silent> <buffer> --<Tab> -<Esc>:call ban#todo#AddNewTodoSubitem()<CR>^xA
imap <silent> <buffer> -n<Tab> -<Esc>:call ban#todo#AddNewTodoNoteitem()<CR>^xA

" Mark items
nmap <silent> <buffer> <localleader>* :call ban#todo#MarkTodoItemAsDoing()<CR>
nmap <silent> <buffer> <localleader>x :call ban#todo#MarkTodoItemAsDone()<CR>
nmap <silent> <buffer> <localleader>- :call ban#todo#MarkTodoItemAsCancelled()<CR>

" Move item block to done.todo
nmap <silent> <buffer> <localleader>D :call ban#todo#MoveTodoItemBlockToDone()<CR>

" Jump to near items
noremap <silent> <buffer> z[ :call ban#todo#GoToPrevSiblingTodoItem()<CR>
noremap <silent> <buffer> z] :call ban#todo#GoToNextSiblingTodoItem()<CR>
noremap <silent> <buffer> zp :call ban#todo#GoToParentTodoItem()<CR>

" Move item up and down
nmap <silent> <buffer> <C-k> :call ban#todo#MoveTodoItemUp()<CR>
nmap <silent> <buffer> <C-j> :call ban#todo#MoveTodoItemDown()<CR>
