function! ban#python#GetCurrentPythonClassName()
	execute "normal ms$?^class \<Enter>0w"
	nohls
	let class_name = expand('<cword>')
	execute 'normal g`s'
	return l:class_name
endfunction

function! ban#python#GetCurrentPythonMethodName()
	execute 'normal ms$?^ \+def \+test\w\+(\_s\{-}self?' . "\<Enter>" . '02w'
	nohls
	let method_name = expand('<cword>')
	execute 'normal g`s'
	return l:method_name
endfunction

function! ban#python#GetCurrentPythonFunctionName()
	execute 'normal ms$?^def \+test\w\+(\_s\{-}?' . "\<Enter>" . '0w'
	nohls
	let function_name = expand('<cword>')
	execute 'normal g`s'
	return l:function_name
endfunction

function! ban#python#MakeValidPythonTestName()
	" Transform a phrase into a test method name.
	"
	" Transform this:
	"   show user name
	" Into this:
	"   def test_show_user_name(self):
	"
	let x=getline('.')
	let x=substitute(x, '\(\w\) ', '\1_', 'ge')
	let x=substitute(x, '-', '_', 'ge')
	let x=substitute(x, '\(\S\+\)', 'def test_\1(self):', '')
	call setline('.', x)
endfunction

function! ban#python#GetTestSeparator()
	if g:test_command =~ 'pytest'
		return '::'
	else
		return '.'
	endif
endfunction

function! ban#python#RunCurrentTestMethod()
	let sep = ban#python#GetTestSeparator()
	let g:test_target = expand('%:.:r') . sep . ban#python#GetCurrentPythonClassName() . sep . ban#python#GetCurrentPythonMethodName()
	let g:test_target = substitute(g:test_target, '/', '.', 'g')
	let test_command = ban#python#BuildTestCommand(g:test_command, g:test_target)
	execute Ban_Run('run-test '. test_command)
endfunction

function! ban#python#RunCurrentTestFunction()
	let sep = ban#python#GetTestSeparator()
	let g:test_target = expand('%:.:r') . sep . ban#python#GetCurrentPythonFunctionName()
	let g:test_target = substitute(g:test_target, '/', '.', 'g')
	let test_command = ban#python#BuildTestCommand(g:test_command, g:test_target)
	execute Ban_Run('run-test '. test_command)
endfunction

function! ban#python#RunCurrentTestCase()
	let sep = ban#python#GetTestSeparator()
	let g:test_target = expand('%:.:r') . sep . ban#python#GetCurrentPythonClassName()
	let g:test_target = substitute(g:test_target, '/', '.', 'g')
	let test_command = ban#python#BuildTestCommand(g:test_command, g:test_target)
	execute Ban_Run('run-test '. test_command)
endfunction

function! ban#python#RunCurrentTestModule()
	let g:test_target = expand('%:.:r')
	let g:test_target = substitute(g:test_target, '/', '.', 'g')
	let test_command = ban#python#BuildTestCommand(g:test_command, g:test_target)
	execute Ban_Run('run-test '. test_command)
endfunction

function! ban#python#RunCurrentTestPackage()
	let g:test_target = expand('%:.:h')
	let g:test_target = substitute(g:test_target, '/', '.', 'g')
	let test_command = ban#python#BuildTestCommand(g:test_command, g:test_target)
	execute Ban_Run('run-test '. test_command)
endfunction

function! ban#python#RunAllTestSuite()
	let g:test_target = ''
	let test_command = ban#python#BuildTestCommand(g:test_command, '')
	execute Ban_Run('run-test '. test_command)
endfunction

function! ban#python#BuildTestCommand(command, target)
	" The {{ target }} part is used mainly with 'make test'.
	" As you know we can't pass arguments to 'make' as we do to shell scripts.
	" The easiest way is setting an environment variable and call 'make'.
	" So, we use the 'var=value command' syntax.
	"
	" Let's see an example.
	"
	" command: target='--pyargs {{ target }}' make test
	" target: some.package.module::Class::test_method
	"
	" Becomes
	"
	" target='--pyargs some.package.module::Class::test_method' make test
	"

	if a:command =~ '{{ target }}'
		let x = substitute(a:command, '{{ target }}', a:target, 'g')
		return 'eval "'. x .'"'
	endif
	return a:command .' '. a:target
endfunction

function! ban#python#TransformSelectedTextIntoFilename()
	let unnamed_register = @"
	execute 'normal gvy'
	let selected_text = @"
	let @" = unnamed_register
	let filename = substitute(selected_text, '\.', '/', 'ge') .'.py'
	return filename
endfunction
