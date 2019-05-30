function! ban#python#GetCurrentPythonClassName()
	execute "normal ms$?^class \<Enter>0w"
	nohls
	let class_name = expand("<cword>")
	execute "normal g`s"
	return l:class_name
endfunction

function! ban#python#GetCurrentPythonMethodName()
	execute "normal ms$?^ \\+def \\+test\\w\\+(\\_s\\{-}self?\<Enter>02w"
	nohls
	let method_name = expand("<cword>")
	execute "normal g`s"
	return l:method_name
endfunction

function! ban#python#MakeValidPythonTestName()
	" Transform a phrase into a test method name.
	"
	" Transform this:
	"   show user name
	" Into this:
	"   def test_show_user_name(self):
	"
	let x=getline(".")
	let x=substitute(x, "\\(\\w\\) ", "\\1_", "ge")
	let x=substitute(x, "-", "_", "ge")
	let x=substitute(x, "\\(\\S\\+\\)", "def test_\\1(self):", "")
	call setline(".", x)
endfunction

function! ban#python#GetTestSeparator()
	if g:test_command =~ "pytest"
		return "::"
	else
		return "."
	endif
endfunction

function! ban#python#RunCurrentTestMethod()
	let sep = ban#python#GetTestSeparator()
	let g:test_target = expand("%:.:r") . sep . ban#python#GetCurrentPythonClassName() . sep . ban#python#GetCurrentPythonMethodName()
	let g:test_target = substitute(g:test_target, "/", ".", "g")
	execute Ban_Run('run-test '. g:test_command .' '. g:test_target)
endfunction

function! ban#python#RunCurrentTestCase()
	let sep = ban#python#GetTestSeparator()
	let g:test_target = expand("%:.:r") . sep . ban#python#GetCurrentPythonClassName()
	let g:test_target = substitute(g:test_target, "/", ".", "g")
	execute Ban_Run('run-test '. g:test_command .' '. g:test_target)
endfunction

function! ban#python#RunCurrentTestModule()
	let g:test_target = expand("%:.:r")
	let g:test_target = substitute(g:test_target, "/", ".", "g")
	execute Ban_Run('run-test '. g:test_command .' '. g:test_target)
endfunction

function! ban#python#RunCurrentTestPackage()
	let g:test_target = expand("%:.:h")
	let g:test_target = substitute(g:test_target, "/", ".", "g")
	execute Ban_Run('run-test '. g:test_command .' '. g:test_target)
endfunction

function! ban#python#RunAllTestSuite()
	let g:test_target = ''
	execute Ban_Run('run-test '. g:test_command .' '. g:test_target)
endfunction
