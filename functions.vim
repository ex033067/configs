""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Functions for simplify running Python tests from inside vim.
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! Ban_GetCurrentPythonClassName()
	execute "normal ms$?^class \<Enter>0w"
	nohls
	let class_name = expand("<cword>")
	execute "normal g`s"
	return l:class_name
endfunction

function! Ban_GetCurrentPythonMethodName()
	execute "normal ms$?^ \\+def \\+\\w\\+(\\_s\\{-}self?\<Enter>02w"
	nohls
	let method_name = expand("<cword>")
	execute "normal g`s"
	return l:method_name
endfunction

function! Ban_MakeValidPythonTestName(type)
	" Transform a phrase into a test function/method name.
	"
	" Transform this:
	"   show user name
	" Into this:
	"   def test_show_user_name():
	"
	let x=getline(".")
	let x=substitute(x, "\\(\\w\\) ", "\\1_", "ge")
	let x=substitute(x, "-", "_", "ge")
	if a:type == "method"
		let x=substitute(x, "\\(\\S\\+\\)", "def test_\\1(self):", "")
	else
		let x=substitute(x, "\\(\\S\\+\\)", "def test_\\1():", "")
	endif
	call setline(".", x)
endfunction

function! Ban_Run(command)
	" Run a command inside vim or through external terminal

	if exists("g:ban_run_internal") && g:ban_run_internal == 1
		let prefix = 'terminal '. &shell .' -c "'
		let suffix = '"'
	else
		if has("gui_running")
			let prefix = 'terminal '. &shell .' -c "'
			let suffix = '"'
		else
			let prefix = '!'
			let suffix = ''
		endif
	endif

	return prefix . a:command . suffix
endfunction

" vi: set nofoldenable:
