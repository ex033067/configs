if exists("g:did_ban_functions")
	finish
endif
let g:did_ban_functions = 1

function! Ban_Run(command)
	" Run an external command using internal or external terminal

	if !exists("g:ban_run_internal")
		if has("gui_running")
			let g:ban_run_internal = 1
		elseif has("nvim")
			let g:ban_run_internal = 1
		else
			let g:ban_run_internal = 0
		endif
	endif

	if g:ban_run_internal == 1
		let prefix = "terminal ". &shell ." -c '"
		let suffix = "'"
	else
		let prefix = '!'
		let suffix = ''
	endif

	return prefix . a:command . suffix
endfunction

" vi: set nofoldenable:
