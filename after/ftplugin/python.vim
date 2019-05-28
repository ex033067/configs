setlocal foldmethod=indent
setlocal foldlevel=5
setlocal nofoldenable

setlocal tabstop=4
setlocal expandtab " Spaces, not tabs

setlocal equalprg=~/.local/bin/binscripts/python-style
setlocal list


" Python tools and helpers
" ------------------------

" Indent
map <silent> <buffer> == :write<CR>gg=G

" Linter
map <buffer> <localleader>m :update<CR>:make %<CR>

" Look for annotations (TODO/NOTE/FIXME) in project
map <buffer> <localleader>TO :grep '(\#\\|//) *(TODO\\|NOTE\\|FIXME)'


" Mappings to help with tests
" ===========================
"
" This is a big section.
"
" All mappings are prefixed with \t.
"
" Read documentation for running Python from inside vim in python_test.vim.

if !exists("g:test_command")
	let g:test_command = $DEV_TEST_COMMAND
endif
if !exists("g:test_target")
	let g:test_target = ""
endif

" \tt runs tests.
map <localleader>tt :wall <CR>:execute Ban_Run('run-test '. g:test_command .' '. g:test_target)<CR>
map t<CR> <localleader>tt

" \tC configure the test command (along with its arguments).
" Examples:
"   - pytest --pyargs
"   - python manage.py test -v 2
"   - python -m unittest
map <localleader>tC :let g:test_command="<c-r>=g:test_command<cr>"

" \tnf, \tnm Make a test name from current line contents
map <silent> <buffer> <localleader>tnf :call ban#python#MakeValidPythonTestName("function") <CR>
map <silent> <buffer> <localleader>tnm :call ban#python#MakeValidPythonTestName("method") <CR>

" Mark the target of next test run
" --------------------------------
"
" You can set g:test_target by yourself with anything you want.
"
" These are just helpers.

" \ta marks all the project.
map <silent> <buffer> <localleader>ta :let g:test_target = "" \| echo "Test target: all project"<CR>

" \tp, \tD mark Python package or directory of current file.
map <silent> <buffer> <localleader>tp :let g:test_target = substitute(expand("%:.:h"), "/", ".", "g") \| echo "Test target: package ". g:test_target<CR>
map <silent> <buffer> <localleader>tD :let g:test_target = expand("%:.:h") . "/" \| echo "Test target: directory ". g:test_target<CR>

" \tM, \tF mark current Python module or current file.
map <silent> <buffer> <localleader>tM :let g:test_target = substitute(expand("%:.:r"), "/", ".", "g") \| echo "Test target: module ". g:test_target<CR>
map <silent> <buffer> <localleader>tF :let g:test_target = expand("%:.") \| echo "Test target: file ". g:test_target<CR>

" \tc marks current Python TestCase class
map <silent> <buffer> <localleader>tc :if g:test_command =~ "pytest" \| let b:sep="::" \| else \| let b:sep="." \| endif \| let g:test_target = substitute(expand("%:.:r") . b:sep . ban#python#GetCurrentPythonClassName(), "/", ".", "g") \| echo "Test target: class ". g:test_target<CR>

" \tm, \tf mark current Python method or current function (for pytest)
map <silent> <buffer> <localleader>tm :if g:test_command =~ "pytest" \| let b:sep="::" \| else \| let b:sep="." \| endif \| let g:test_target = substitute(expand("%:.:r") . b:sep . ban#python#GetCurrentPythonClassName() . b:sep . ban#python#GetCurrentPythonMethodName(), "/", ".", "g") \| echo "Test target: method ". g:test_target<CR>
map <silent> <buffer> <localleader>tf :let g:test_target = expand("%:.") . "::" . expand("<cword>") \| echo "Test target: function ". g:test_target<CR>
