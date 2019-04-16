function! ban#python#GetCurrentPythonClassName()
	execute "normal ms$?^class \<Enter>0w"
	nohls
	let class_name = expand("<cword>")
	execute "normal g`s"
	return l:class_name
endfunction

function! ban#python#GetCurrentPythonMethodName()
	execute "normal ms$?^ \\+def \\+\\w\\+(\\_s\\{-}self?\<Enter>02w"
	nohls
	let method_name = expand("<cword>")
	execute "normal g`s"
	return l:method_name
endfunction

function! ban#python#MakeValidPythonTestName(type)
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
