" vim: foldlevel=0 foldenable


augroup aug_viniciusban_journal
    " {{{1
    au!

    " Journal file v2 behaviour and functions
    " ---------------------------------------

    " As time goes by, journal becomes bigger. This block speeds up its load time.
    autocmd BufReadPre  *journal*.md let b:journal_loaded=0
    autocmd BufReadPre  *journal*.md syntax off
    autocmd BufReadPost *journal*.md setlocal foldmethod=manual foldenable foldlevel=1
    autocmd CursorHold  *journal*.md
        \  if b:journal_loaded == 0
        \ |    setlocal foldmethod=expr
        \ |    syntax on
        \ |    let b:journal_loaded=1
        \ |endif

    " help
    autocmd BufReadPost *journal*.md noremap  <buffer> <localleader>?  :call BanJournal_ShowMappings()<CR>

    " task items
    autocmd BufReadPost *journal*.md inoremap <buffer> <localleader>t  <C-o>:call BanJournal_CreateTask($JOURNAL_PROJECT)<CR>
    autocmd BufReadPost *journal*.md inoremap <buffer> <localleader>T  <C-o>:call BanJournal_CreateTask('<project>')
    autocmd BufReadPost *journal*.md nnoremap <buffer> <localleader>*  :call BanJournal_StartCurrentTask()<CR>
    autocmd BufReadPost *journal*.md nnoremap <buffer> <localleader>a  :call BanJournal_ArchiveCurrentTask()<CR>
    autocmd BufReadPost *journal*.md nnoremap <buffer> <localleader>x  :call BanJournal_EndCurrentTask()<CR>
    autocmd BufReadPost *journal*.md nnoremap <buffer> <localleader>.  :call BanJournal_PauseCurrentTask()<CR>
    autocmd BufReadPost *journal*.md nnoremap <buffer> <localleader>l  :let _=strftime('%Y-%m-%d')<CR>:call BanJournal_ListTasksTouchedOnDate('=_<CR>')
    autocmd BufReadPost *journal*.md nnoremap <silent> <buffer> <C-]> :normal! m'<CR>:execute 'keeppatterns /\m^#\+ '. expand('<cword>')<CR>:normal! zvw<CR>|" Go to task definition

    " timestamp notes
    autocmd BufReadPost *journal*.md inoremap <buffer> <localleader>n <C-o>:call BanJournal_AddTimestampNoteToCurrentLine('', 'without_task_code')<CR>
    autocmd BufReadPost *journal*.md inoremap <buffer> <localleader>N <C-o>:call BanJournal_AddTimestampNoteToCurrentLine()<CR>
    autocmd BufReadPost *journal*.md nnoremap <silent> <buffer> [n 0:call search('^\d\d\d\d-\d\d-\d\d \w\w\w \d\?\d:\d\d', 'bs')<CR>|" Go to prev timestamp note
    autocmd BufReadPost *journal*.md nnoremap <silent> <buffer> ]n :call search('^\d\d\d\d-\d\d-\d\d \w\w\w \d\?\d:\d\d', 's')<CR>|" Go to next timestamp note

    " daily records
    autocmd BufReadPost *journal*.md inoremap <buffer> <localleader>d <C-o>:call BanJournal_StartANewDay($JOURNAL_PROJECT)<CR><Esc>A
    autocmd BufReadPost *journal*.md inoremap <buffer> <localleader>s <C-o>:call BanJournal_CreateTheTimesheetTaskInCurrentLine('<project>')



    " New journal file support functions
    " ----------------------------------

    function! BanJournal_ShowMappings()
        " {{{2
        echom '      New:    task \t     day \d   timesheet \s'
        echom ' '
        echom '    Tasks:  create \t   start \*      finish \x'
        echom '           archive \a   pause \.     touched \l'
        echom ' '
        echom 'Timestamp:  create \n    prev [n        next ]n'
        echom '     Note: Set the $JOURNAL_PROJECT variable first'
    endfunction |" 2}}}

    function! BanJournal_CreateTask(project)
        " {{{2
        " Create a task in current line

        let lnum = line('.')
        call BanJournal_DoCreateTask(lnum, a:project, trim(getline(lnum)))
        call cursor(lnum, col('$'))
    endfunction |" 2}}}

    function! BanJournal_StartCurrentTask()
        " {{{2
        " Mark as doing. Create the task section in ACTIVE. Keep it in BACKLOG.

        let journal_task_patt = '^- \[.\] _\w\+_\>'
        let simple_task_patt = '^ *- \[.\] '
        let lnum = line('.')

        if match(getline(lnum), journal_task_patt) > -1
            " We must check if the task is a journal task first,
            " because the start of the search pattern is the same,
            " but the journal task has its code following the closing
            " bracket.
            call BanJournal_DoStartTaskAtLine(lnum)
            let task_code = BanJournal_GetTaskCodeForLine(lnum)
            let [_, last_lnum] = BanJournal_GetTaskSectionInterval(task_code)
            call cursor(last_lnum, 1000)
            normal zx
            return
        endif

        if match(getline(lnum), simple_task_patt) > -1
            call BanJournal_MarkTaskAtLineAsDoing(lnum)
            return
        endif

        echohl ErrorMsg | echom  'Error: Not a task' | echohl None
    endfunction |" 2}}}

    function! BanJournal_EndCurrentTask()
        " {{{2
        let journal_task_patt = '^- \[.\] _\w\+_\>'
        let simple_task_patt = '^ *- \[.\] '
        let lnum = line('.')

        if match(getline(lnum), journal_task_patt) == -1 && match(getline(lnum), simple_task_patt) > -1
            call BanJournal_MarkTaskAtLineAsDone(lnum)
            return
        endif

        let task_code = BanJournal_GetTaskCodeForLine(lnum)
        if task_code == ''
            echohl ErrorMsg | echom  'Error: Not a task' | echohl None
            return
        endif
        call BanJournal_DoEndTask(task_code)
        normal zv
    endfunction |" 2}}}

    function! BanJournal_ArchiveCurrentTask()
        " {{{2
        let lnum = line('.')
        let task_code = BanJournal_GetTaskCodeForLine(lnum)
        if task_code == ''
            echohl ErrorMsg | echom  'Error: Not a task' | echohl None
            return
        endif
        call BanJournal_DoArchiveTask(task_code)
        normal zv
    endfunction |" 2}}}

    function! BanJournal_PauseCurrentTask()
        " {{{2
        let lnum = line('.')
        let task_code = BanJournal_GetTaskCodeForLine(lnum)
        if task_code == ''
            echom 'Error: Not a task'
            return
        endif
        call BanJournal_DoPauseTask(task_code)
    endfunction |" 2}}}

    function! BanJournal_AddTimestampNoteToCurrentLine(description = '', option = '')
        " {{{2
        let lnum = line('.')
        call BanJournal_AddTimestampNoteToLine(lnum, a:description, a:option)
        call cursor(lnum, col('$'))
    endfunction |" 2}}}

    function! BanJournal_CreateTheDailyTaskInCurrentLine()
        " {{{2
        let lnum = line('.')
        let task_description = 'daily '. strftime('%Y-%m-%d %a')
        let day_of_week = strftime('%a')
        call BanJournal_DoCreateTask(lnum, 'daily', task_description, day_of_week)
        call BanJournal_MarkTaskAtLineAsDoing(lnum)
        call BanJournal_CopyTaskAtLineToActive(lnum)
        let task_code = BanJournal_GetTaskCodeForLine(lnum)
        let [_, last_lnum] = BanJournal_GetTaskSectionInterval(task_code)
        call append(last_lnum, '')
        call cursor(last_lnum + 2, 1)
    endfunction |" 2}}}

    function! BanJournal_CreateTheTimesheetTaskInCurrentLine(project)
        " {{{2
        let lnum = line('.')
        let task_description = a:project . ' timesheet '. strftime('%Y-%m-%d %a')
        let task_suffix = 'timesheet_'. strftime('%a')
        call BanJournal_DoCreateTask(lnum, a:project, task_description, task_suffix)
        call BanJournal_MarkTaskAtLineAsDoing(lnum)
        call BanJournal_CopyTaskAtLineToActive(lnum)
        call BanJournal_AddTimestampNoteWhenStartingTimesheetAtLine(lnum)
        let task_code = BanJournal_GetTaskCodeForLine(lnum)
        let [_, last_lnum] = BanJournal_GetTaskSectionInterval(task_code)
        call append(last_lnum, '')
        call cursor(last_lnum, 1000)
        normal zx
    endfunction |" 2}}}

    function! BanJournal_StartANewDay(project)
        " {{{2
        let lnum = line('.')
        call BanJournal_CreateTheDailyTaskInCurrentLine()
        call append(lnum, '')
        call cursor(lnum + 1, 1)
        call BanJournal_CreateTheTimesheetTaskInCurrentLine(a:project)
    endfunction |" 2}}}

    function! BanJournal_DoCreateTask(lnum, project, description, task_suffix='')
        " {{{2
        " Create a task in line `lnum`.
        "
        " Format: _{project}_{date}_{suffix}_

        let template = '- [ ] {task_code} {description}'
        let task_code = BanJournal_BuildTaskCode(a:project, a:task_suffix)
        let new_line = template

        let new_line = substitute(new_line, '{task_code}', task_code, '')
        let new_line = substitute(new_line, '{description}', a:description, '')

        call setline(a:lnum, new_line)
    endfunction |" 2}}}

    function! BanJournal_DoStartTaskAtLine(lnum)
        " {{{2
        " Start the task at `lnum` line.

        let lnum = line('.')
        let task_code = BanJournal_GetTaskCodeForLine(lnum)
        let [first_line, _] = BanJournal_GetTaskSectionInterval(task_code)

        call BanJournal_AddStartDateToTaskTitleAtLine(lnum)
        call BanJournal_MarkTaskAtLineAsDoing(lnum)
        if first_line == 0
            call BanJournal_CopyTaskAtLineToActive(lnum)
        endif
        call BanJournal_AddTimestampNoteWhenStartingTaskAtLine(lnum)
        normal zx
    endfunction |" 2}}}

    function! BanJournal_DoEndTask(task_code)
        " {{{2
        " Mark task as ended and register the timestamp

        let task_item_lnum = BanJournal_FindTaskItemWithTaskCode(a:task_code)
        call BanJournal_MarkTaskAtLineAsDone(task_item_lnum)
        call BanJournal_AddEndDateToTaskTitle(a:task_code)
        call BanJournal_AddTimestampNoteWhenFinishingTask(a:task_code)
    endfunction |" 2}}}

    function! BanJournal_DoArchiveTask(task_code)
        " {{{2
        " Remove from BACKLOG. Move from ACTIVE to ARCHIVE.

        let task_item_lnum = BanJournal_FindTaskItemWithTaskCode(a:task_code)
        execute task_item_lnum . 'delete _'
        call BanJournal_MoveTaskToArchive(a:task_code)
    endfunction |" 2}}}

    function! BanJournal_DoPauseTask(task_code)
        " {{{2
        " Mark task as paused.

        let task_item_lnum = BanJournal_FindTaskItemWithTaskCode(a:task_code)
        call BanJournal_MarkTaskAtLineAsPaused(task_item_lnum)
        call BanJournal_AddTimestampNoteWhenPausingTask(a:task_code)
    endfunction |" 2}}}

    function! BanJournal_AddTimestampNoteToLine(lnum, description = '', ...)
        " {{{2
        if count(a:000, 'without_task_code') == 0
            let template = '{today} {weekday} {now} {task_code}{description}'
            let task_code = BanJournal_GetTaskCodeForLine(a:lnum)
        else
            let template = '{today} {weekday} {now}{description}'
            let task_code = ''
        endif
        let new_line = template

        if empty(a:description)
            let description = ''
        else
            let description = ' '. a:description
        endif

        let new_line = substitute(new_line, '{today}', strftime("%Y-%m-%d"), '')
        let new_line = substitute(new_line, '{weekday}', strftime("%a"), '')
        let new_line = substitute(new_line, '{now}', strftime("%H:%M"), '')
        let new_line = substitute(new_line, '{task_code}', task_code, '')
        let new_line = substitute(new_line, '{description}', description, '')

        call setline(a:lnum, new_line)
    endfunction |" 2}}}

    function! BanJournal_BuildTaskCode(project, suffix='')
        " {{{2
        " Assemble different pieces to build a task code.
        let template = '_{project}_{today}_{suffix}_'
        if a:suffix == ''
            let suffix = BanJournal_CreateRandomCodeWithLength(2)
        else
            let suffix = a:suffix
        endif

        let task_code = template
        let task_code = substitute(task_code, '{project}', a:project, '')
        let task_code = substitute(task_code, '{today}', strftime("%y%m%d"), '')
        let task_code = substitute(task_code, '{suffix}', suffix, '')
        return task_code
    endfunction |" 2}}}

    function! BanJournal_CreateRandomCodeWithLength(length)
        " {{{2
        " Create a random code with `length` chars.
        let chars = 'abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'
        let len_chars = len(chars)
        let result = []
        for _ in range(a:length)
            let i = rand() % len_chars
            call add(result, chars[i])
        endfor
        return join(result, '')
    endfunction |" 2}}}

    function! BanJournal_FindTaskItemWithTaskCode(task_code)
        let item_lnum = search('^- \[.\] '. a:task_code, 'n')
        return item_lnum
    endfunction

    function! BanJournal_GetTaskCodeForLine(lnum)
        " {{{2
        let task_code = BanJournal_GetTaskCodeFromItemList(a:lnum)
        if task_code == ''
            let task_code = BanJournal_GetTaskCodeFromInsideTaskSection(a:lnum)
        endif

        return task_code
    endfunction |" 2}}}

    function! BanJournal_GetTaskCodeFromItemList(lnum)
        " {{{2
        let pattern = '^- \[.\] \(_\w\+_\)\W'
        let matches = matchlist(getline(a:lnum), pattern)
        if empty(matches)
            return ''
        endif
        return matches[1]
    endfunction |" 2}}}

    function! BanJournal_GetTaskCodeFromInsideTaskSection(lnum)
        " {{{2
        " Task codes are in level 2 heading
        let pattern = '^## \(_\w\+_\)\W'
        let initial_lnum = line('.')

        call cursor(a:lnum, 1)
        let task_first_lnum = search(pattern, 'bcnW')
        call cursor(initial_lnum, 1)

        if task_first_lnum == 0
            return ''
        endif

        let matches = matchlist(getline(task_first_lnum), pattern)
        if empty(matches)
            return ''
        endif
        return matches[1]
    endfunction |" 2}}}

    function! BanJournal_AddStartDateToTaskTitleAtLine(lnum)
        " {{{2
        " Add note in task about when started doing: (#start:YYYY-MM-DD)
        let line_template = '{previous_contents} {note}'
        let note_template = '(#start:{today})'

        let note = note_template
        let note = substitute(note, '{today}', strftime('%Y-%m-%d'), '')

        let new_line = line_template
        let new_line = substitute(new_line, '{previous_contents}', getline(a:lnum), '')
        let new_line = substitute(new_line, '{note}', note, '')

        call setline(a:lnum, new_line)

        " Add start date to task title if it already exists in ACTIVE
        let task_code = BanJournal_GetTaskCodeForLine(a:lnum)
        let [title_lnum, _] = BanJournal_GetTaskSectionInterval(task_code)
        if title_lnum == 0
            return
        endif

        let new_title = line_template
        let new_title = substitute(new_title, '{previous_contents}', getline(title_lnum), '')
        let new_title = substitute(new_title, '{note}', note, '')
        call setline(title_lnum, new_title)
    endfunction |" 2}}}

    function! BanJournal_MarkTaskAtLineAsDoing(lnum)
        " {{{2
        let contents = getline(a:lnum)
        let new_line= substitute(contents, '\[.\] ', '\[*\] ', '')
        call setline(a:lnum, new_line)
    endfunction |" 2}}}

    function! BanJournal_MarkTaskAtLineAsDone(lnum)
        let new_line= substitute(getline(a:lnum), '\[.\] ', '\[x\] ', '')
        call setline(a:lnum, new_line)
    endfunction

    function! BanJournal_MarkTaskAtLineAsPaused(lnum)
        " {{{2
        let contents = getline(a:lnum)
        let new_line= substitute(contents, '\[.\] ', '\[.\] ', '')
        call setline(a:lnum, new_line)
    endfunction |" 2}}}

    function! BanJournal_CopyTaskAtLineToActive(lnum)
        " {{{2
        let task_item = getline(a:lnum)
        let task_section_heading = substitute(task_item, '^- \[.\]', '##', '')

        let active_section_lnum = search('^# ACTIVE', 'n')
        call append(active_section_lnum, ['', task_section_heading, ''])
    endfunction |" 2}}}

    function! BanJournal_AddTimestampNoteWhenStartingTaskAtLine(lnum)
        " {{{2
        let task_code = BanJournal_GetTaskCodeForLine(a:lnum)
        let [_, last_lnum] = BanJournal_GetTaskSectionInterval(task_code)
        let timestamp_lnum = last_lnum + 2
        call BanJournal_AddTimestampNoteToLine(timestamp_lnum, '#start', 'without_task_code')
        call append(timestamp_lnum, ['', ''])
    endfunction |" 2}}}

    function! BanJournal_AddTimestampNoteWhenStartingTimesheetAtLine(lnum)
        " {{{2
        let task_code = BanJournal_GetTaskCodeForLine(a:lnum)
        let [first_lnum, _] = BanJournal_GetTaskSectionInterval(task_code)
        let timestamp_lnum = first_lnum + 2
        call BanJournal_AddTimestampNoteToLine(timestamp_lnum, '-', 'without_task_code')
    endfunction |" 2}}}

    function! BanJournal_MoveTaskToArchive(task_code)
        " {{{2
        let initial_lnum = line('.')
        let archive_section_lnum = search('^# ARCHIVE', 'nw')
        let [first_lnum, last_lnum] = BanJournal_GetTaskSectionInterval(a:task_code)

        if first_lnum > archive_section_lnum
            " for some reason, the task is already in ARCHIVE
            return
        endif

        execute first_lnum .','. last_lnum .'move '. (archive_section_lnum + 1)
        call cursor(initial_lnum, 1)
    endfunction |" 2}}}

    function! BanJournal_AddEndDateToTaskTitle(task_code)
        " {{{2
        " Add note in task about when finished it doing: #end:YYYY-MM-DD
        let template = ' #end:{today}'

        let [first_lnum, _] = BanJournal_GetTaskSectionInterval(a:task_code)

        let note = template
        let note = substitute(note, '{today}', strftime('%Y-%m-%d'), '')
        let title_with_note = substitute(getline(first_lnum), '\()\)$', note.'\1', '')
        call setline(first_lnum, title_with_note)
    endfunction |" 2}}}

    function! BanJournal_AddTimestampNoteWhenFinishingTask(task_code)
        " {{{2
        let [_, last_lnum] = BanJournal_GetTaskSectionInterval(a:task_code)
        call append(last_lnum, ['', '', '', ''])
        call BanJournal_AddTimestampNoteToLine(last_lnum + 2, '#end', 'without_task_code')
    endfunction |" 2}}}

    function! BanJournal_AddTimestampNoteWhenPausingTask(task_code)
        " {{{2
        let [_, last_lnum] = BanJournal_GetTaskSectionInterval(a:task_code)
        let note_lnum = last_lnum + 2
        call append(note_lnum, ['', ''])
        call BanJournal_AddTimestampNoteToLine(note_lnum, '#paused', 'without_task_code')
        call cursor(note_lnum, 1)
        normal zv
    endfunction |" 2}}}

    function! BanJournal_GetTaskSectionInterval(task_code)
        " {{{2
        let initial_lnum = line('.')

        let task_first_lnum = search('^## '. a:task_code, 'nw')
        call cursor(task_first_lnum, 1)

        let next_section_lnum = search('^##\? ', 'nW')
        if next_section_lnum == 0
            call cursor(line('$'), 1000)
        else
            call cursor(next_section_lnum, 1)
        endif

        let task_last_lnum = search('^.', 'bnW')
        call cursor(initial_lnum, 1)

        return [task_first_lnum, task_last_lnum]
    endfunction |" 2}}}

    function! BanJournal_ListTasksTouchedOnDate(date_arg)
        " {{{2
        " Use location list to show all the tasks I have worked on that date.
        let v:errmsg = ''
        silent! execute 'lvimgrep '. a:date_arg . ' '. expand('%')

        if v:errmsg != ''
            echohl ErrorMsg | echom 'Nothing found for ' . a:date_arg | echohl None
            return
        endif

        let tasks_touched = {}

        for item in getloclist(0)
            let [lnum, text] = [item['lnum'], item['text']]

            if match(text, '^- \[.\] ') > -1
                " line is a task item
                let matches = matchlist(text, ' \(_\w\{-\}_\)\>.\(.*\)')
                let task_code = matches[1]
                let description = matches[2]
            elseif match(text, '^## ') > -1
                " line is the start of a task session
                let matches = matchlist(text, ' \(_\w\{-\}_\)\>.\(.*\)')
                let task_code = matches[1]
                let description = matches[2]
            elseif match(text, '^\d\d\d\d-\d\d-\d\d \w\w\w \d\d:\d\d') > -1
                " line is a timestamp note
                let notes = ''

                let matches = matchlist(text, '^\d\d\d\d-\d\d-\d\d \w\w\w \d\d:\d\d\(.*\)')
                if matches[1] != ''
                    let notes = ' ' . trim(matches[1])
                endif

                let task_code = BanJournal_GetTaskCodeFromInsideTaskSection(lnum)

                let [first_lnum, _] = BanJournal_GetTaskSectionInterval(task_code)
                let matches = matchlist(getline(first_lnum), ' _\w\{-\}_\>.\(.*\)')
                let task_description = trim(matches[1])

                " Get subsection title to show in location list
                let initial_lnum = line('.')
                call cursor(lnum, 1)
                let subsection_lnum = search('^#', 'bnW', first_lnum)
                call cursor(initial_lnum, 1)
                if subsection_lnum <= first_lnum
                    let subsection_title = ''
                else
                    let matches = matchlist(getline(subsection_lnum), '^#\+ \(.\+\)')
                    let subsection_title = ' (' . matches[1] . ')'
                endif

                if subsection_title == ''
                    let description = task_description . notes
                else
                    let description = task_description . subsection_title . notes
                endif
            else
                continue
            endif

            if match(task_code, '_daily_\|_timesheet_') > -1
                " ignore daily and timesheet tasks
                continue
            endif

            let tasks_touched[task_code] = {'lnum': lnum, 'text': description, 'task_code': task_code}
        endfor

        let sorted_list = sort(values(tasks_touched), 'BanJournal_SortListOfTasksTouchedOnDateByLnum')
        let new_items = []
        let filename = expand('%')

        for item in sorted_list
            call add(new_items, {
                \ 'filename': filename,
                \ 'module': item['task_code'],
                \ 'lnum': item['lnum'],
                \ 'text': item['text']
                \})
        endfor
        call setloclist(0, [], 'r', {'title': 'Tasks for '. a:date_arg, 'items': new_items})
        lopen
    endfunction |" 2}}}

    function! BanJournal_SortListOfTasksTouchedOnDateByLnum(first, second)
        " {{{2
        if a:first['lnum'] < a:second['lnum']
            return -1
        endif
        return 1
    endfunction |" 2}}}

augroup END |" 1}}}

