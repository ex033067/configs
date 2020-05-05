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

function! Ban_AddDelimiterToSelectedText() range
    " It works only in one line by now.
    let counterchars = {'(': '()', ')': '()', '[': '[]', ']': '[]', '{': '{}', '}': '{}', '<': '<>', '>': '<>'}
    let counterparts = {'/*': ['/*', '*/'], '*/': ['/*', '*/'], '{{': ['{{', '}}'], '}}': ['{{', '}}'], '{%': ['{%', '%}'], '%}': ['{%', '%}'], '{#': ['{#', '#}'], '#}': ['{#', '#}'] }
    let linenum = line("'<")
    let line = getline("'<")
    let [start_position, end_position] = [getpos("'<")[2], getpos("'>")[2]]
    let delimiter = input('Type delimiter:')
    if has_key(counterchars, delimiter)
        let opening_delimiter = strcharpart(counterchars[delimiter], 0, 1)
        let closing_delimiter = strcharpart(counterchars[delimiter], 1)
    elseif has_key(counterparts, delimiter)
        let opening_delimiter = counterparts[delimiter][0] .' '
        let closing_delimiter = ' '. counterparts[delimiter][1]
    elseif len(delimiter) > 1 && strcharpart(delimiter, 0, 1) == '<'
        let opening_delimiter = delimiter
        let closing_delimiter = '</' . strcharpart(delimiter, 1)
    else
        let [opening_delimiter, closing_delimiter] = [delimiter, delimiter]
    endif

    let before = strcharpart(line, 0, start_position -1)
    let after = strcharpart(line, end_position)
    let inside = strcharpart(line, start_position -1, end_position - start_position + 1)

    call setline(linenum, before .opening_delimiter. inside .closing_delimiter. after)
endfunction

function! Ban_ToggleColorscheme()
    if g:colors_name == 'yellowonblack'
        colo whiteonblack
    elseif g:colors_name == 'whiteonblack'
        colo blackonwhite
    else
        colo yellowonblack
    endif
endfunction
