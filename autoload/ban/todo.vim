function! ban#todo#MoveTodoItemUp()
	let l:saved = @s
	normal! $
	call search("^\\s*- [.\\] ", "b")
	normal! "sdip"_dd0
	call search("^\\s*- [.\\] ", "bW")
	put! s
	normal! o
	call search("^\\s*- [.\\] ", "b")
	let @s = l:saved
endfunction

function! ban#todo#MoveTodoItemDown()
	let l:saved = @s
	normal! $
	call search("^\\s*- [.\\] ", "b")
	normal! "sdip"_dd
	let l:next = search("^\\s*- [.\\] ", "W")
	if l:next > 0
		put! s
		normal! o
		call search("^\\s*- [.\\] ", "b")
	else
		normal! }
		if getline(".") == ""
			normal! o
			normal! k
			put s
		else
			normal! o
			put s
		endif
	endif
	let @s = l:saved
endfunction

function! ban#todo#GoToNextSiblingTodoItem()
	" Position cursor at the beginning of next sibling item.
	" It's "fenced" inside a foldlevel. I.e., don't extrapolate to next upper
	" level.
	" Don't move cursor and return -1 when there's no next sibling. I.e.,
	" when item is the last one in file or when file is empty.
	let start_line = line('.')
	let last_line = line('$')
	let next_empty = line("'}")
	if next_empty == last_line
		return -1
	endif

	let next_line = next_empty + 1
	while next_line <= last_line && foldlevel(next_line) >= foldlevel(start_line)
		if foldlevel(next_line) == foldlevel(start_line) && getline(next_line) != ''
			call cursor(next_line, 0)
			return next_line
		endif
		let next_line = next_line + 1
	endwhile
	call cursor(start_line, 0)
	return -1
endfunction

function! ban#todo#GoToPrevSiblingTodoItem()
	" Position cursor at the beginning of previous sibling item.
	" It's "fenced" inside a foldlevel. I.e., don't extrapolate to next upper
	" level.
	let start_line = line('.')
	let next_empty = search('^$', 'bW')
	if next_empty == 0
		return
	endif

	let next_line = next_empty - 1
	while foldlevel(next_line) >= foldlevel(start_line)
		if foldlevel(next_line) == foldlevel(start_line) && getline(next_line) != ''
			call cursor(next_line, 0)
			let next_line = line("'{")
			if getline(next_line) == ''
				let next_line = next_line + 1
			endif
			call cursor(next_line, 0)
			return
		endif
		let next_line = next_line - 1
	endwhile
	call cursor(start_line, 0)
endfunction

function! ban#todo#GoToParentTodoItem()
	" Position cursor at the beginning of parent item.
	let start_line = line('.')
	if foldlevel(start_line) < 1
		return
	endif

	let prev_empty = start_line

	while prev_empty > 1 && foldlevel(prev_empty) >= foldlevel(start_line)
		let prev_empty = line("'{")
		call cursor(prev_empty, 0)
	endwhile

	let prev_empty = line("'{")
	if prev_empty == 1
		call cursor(prev_empty, 0)
	else
		call cursor(prev_empty + 1, 0)
	endif
endfunction

function! ban#todo#MarkTodoItemAsDoing()
	normal $
	call search("^\\s*-[.\\] ", "bW")
	let x=substitute(getline("."), "^\\(\\s*-[\\).\\] ", "\\1*] ", "")
	let x=substitute(x, " done=\\d\\{4}\\(-\\d\\d\\)\\{2}", "" , "")
	let x=substitute(x, " cancelled=\\d\\{4}\\(-\\d\\d\\)\\{2}", "" , "")
	call setline(line("."), x)
endfunction

function! ban#todo#MarkTodoItemAsDone()
	normal $
	call search("^\\s*-[.\\] ", "bW")
	let x=substitute(getline("."), "^\\(\\s*-[\\).\\] ", "\\1x] ", "")
	let x=substitute(x, ')', ' done='.strftime('%Y-%m-%d') .')', '')
	call setline(line("."), x)
endfunction

function! ban#todo#MarkTodoItemAsCancelled()
	normal $
	call search("^\\s*-[.\\] ", "bW")
	let x=substitute(getline("."), "^\\(\\s*-[\\).\\] ", "\\1-] ", "")
	let x=substitute(x, ')', ' cancelled='.strftime('%Y-%m-%d') .')', '')
	call setline(line("."), x)
endfunction

function! ban#todo#GetTodoItemBoundaries()
	" Return first and last line numbers of an item including its children.
	"
	" If a group is the last one in file, the last line will be computed
	" to -2.
	let first = line(".")
	let last = ban#todo#GoToNextSiblingTodoItem() - 1
	return [first, last]
endfunction

function! ban#todo#AppendEmptyLine()
	" Append empty line if the last one is not already empty.
	if getline('$') != ''
		call append('$', '')
	endif
	return line('$')
endfunction

function! ban#todo#MoveTodoItemBlockToDone()
	" Write item block in done.todo file and remove it from todo.todo.
	let lines = ban#todo#GetTodoItemBoundaries()
	let first = lines[0]
	let last = lines[1]
	if last < first
		let last = ban#todo#AppendEmptyLine()
	endif
	call execute(first.",".last."w >> done.todo")
	call execute(first.",".last."del")
	return [first, last]
endfunction

function! ban#todo#GetTodoItemBlockBoundaries()
	" Return number of first and last lines of an item block.
	"
	" I don't change cursor position.
	"
	" You must called me with cursor in first line of context block.
	" I don't rewind looking for the beginning of item yet.
	"
	" I go forward looking for the next sibling or higher level item.
	" This is the "next block". I also stop on EOF.
	"
	" When I find "next block", I go backwards to find last line of the
	" context block.
	"
	" And finish.  Doing this way I handle empty lines nicely.
	"
	if getline('.') == ""
		" Ops! You called me from an empty line
		return [-1, -1]
	endif

	let first_line = line('.')
	let item_level = foldlevel(first_line)
	let next_empty_line = line("'}")

	while next_empty_line <= line('$')
		if next_empty_line == line('$') && getline(next_empty_line) != ""
			" Buffer ends with a non-empty line.
			" So, this is the end of the block.
			call cursor(first_line, 0)
			return [first_line, line('$')]
		endif

		call cursor(next_empty_line, 0)
		let next_non_empty_line = search("\\(^$\\)\\@!", "nW")

		if foldlevel(next_non_empty_line) > item_level
			" Reached a sub item. Skip it.
			let next_empty_line = line("'}")
			continue
		endif

		" Reached next block. Let's search back for last line of context.
		let prev_non_empty_line = search("\\(^$\\)\\@!", "bnW")
		call cursor(first_line, 0)
		return [first_line, prev_non_empty_line]
	endwhile
	" There should be no reason to the logic get here.
	" It's here only for safety.
	call cursor(first_line, 0)
	return [first_line, line('$')]
endfunction

function! ban#todo#MoveTodoItemBlockDown()
	" Move item block below next sibling.
	"
	"TODO
	" 1. Get boundaries of current block.
	" 2. Get boundaries of next block.
	" 3. Copy current block to after the next one.
	" 4. Remove current block.
	"
	" Remember to handle missing or leading empty lines.
	"
	return -1
endfunction

function! ban#todo#AddNewTodoItem()
	let l:mask = '-[ ] (+project #noticket added=yyyy-mm-dd) '
	let l:today = strftime('%Y-%m-%d')
	let l:x = substitute(l:mask, 'yyyy-mm-dd', strftime('%Y-%m-%d'), '')
	call setline('.', getline('.') . l:x)
endfunction

function! ban#todo#AddNewTodoSubitem()
	let l:mask = '-[ ] (added=yyyy-mm-dd) '
	let l:today = strftime('%Y-%m-%d')
	let l:x = substitute(l:mask, 'yyyy-mm-dd', strftime('%Y-%m-%d'), '')
	call setline('.', getline('.') . l:x)
endfunction

function! ban#todo#AddNewTodoNoteitem()
	let l:mask = '- NOTE (added=yyyy-mm-dd) '
	let l:today = strftime('%Y-%m-%d')
	let l:x = substitute(l:mask, 'yyyy-mm-dd', strftime('%Y-%m-%d'), '')
	call setline('.', getline('.') . l:x)
endfunction
