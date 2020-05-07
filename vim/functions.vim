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
