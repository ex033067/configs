" vim: foldlevel=0 foldenable


augroup aug_list_items
    " {{{1
    au!

    " add item
    autocmd FileType markdown,text inoremap <buffer> <localleader>i - [ ]<Space>

    " mark item as doing/done
    autocmd FileType markdown,text nnoremap <silent> <buffer> <localleader>* :keeppatterns :s/^\(\s*- \[\).]/\1*]/<CR>
    autocmd FileType markdown,text nnoremap <silent> <buffer> <localleader>x :keeppatterns :s/^\(\s*- \[\).]/\1x]/<CR>

    " go to next/previous list item (any level)
    autocmd FileType markdown,text nnoremap <silent> <buffer> ]- :call search('^\s*- ', "z")<CR>
    autocmd FileType markdown,text nnoremap <silent> <buffer> [- :call search('^\s*- ', "b")<CR>

    " go to next/previous sibling
    autocmd FileType markdown,text nnoremap <silent> <buffer> ]= ^:call search("^". strpart(getline("."), 0, col(".")), "z")<CR>
    autocmd FileType markdown,text nnoremap <silent> <buffer> [= ^:let _pat=strpart(getline("."), 0, col("."))<CR>0:call search("^". _pat, "b")<CR>

    " go to parent
    autocmd FileType markdown,text nnoremap <silent> <buffer> [_ ^:call search('\%<' .col("."). 'c\S', "b")<CR>
augroup END |" 1}}}
