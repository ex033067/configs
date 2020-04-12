setlocal foldmethod=indent
setlocal foldlevel=5

setlocal tabstop=4
setlocal expandtab | " Spaces, not tabs

setlocal list number relativenumber

if filereadable('Makefile')
	setlocal equalprg=make\ --no-print-directory\ --silent\ pep8
else
	setlocal equalprg=~/.local/bin/binscripts/python-style
endif


" Python tools and helpers
" ------------------------

" Indent
map <silent> <buffer> == :write<CR>gg=G

" Linter
map <buffer> <localleader>m :update<CR>:make %<CR>

" Look for annotations (TODO/NOTE/FIXME) in project
map <buffer> <localleader>TO :grep '(\#\\|//) *(TODO\\|NOTE\\|FIXME)'

" Edit selected module name
xmap <localleader>f :<C-U>let @g = ban#python#TransformSelectedTextIntoFilename() <CR>

" Mappings for classes, functions and docstrings text-objects
xmap <buffer> ic <Plug>(textobj-python-class-i)
omap <buffer> ic <Plug>(textobj-python-class-i)
xmap <buffer> ac <Plug>(textobj-python-class-a)
omap <buffer> ac <Plug>(textobj-python-class-a)
xmap <buffer> if <Plug>(textobj-python-function-i)
omap <buffer> if <Plug>(textobj-python-function-i)
xmap <buffer> af <Plug>(textobj-python-function-a)
omap <buffer> af <Plug>(textobj-python-function-a)
xmap  <buffer> ad <Plug>(PythonsenseOuterDocStringTextObject)
omap  <buffer> ad <Plug>(PythonsenseOuterDocStringTextObject)
xmap  <buffer> id <Plug>(PythonsenseInnerDocStringTextObject)
omap  <buffer> id <Plug>(PythonsenseInnerDocStringTextObject)


" Mappings to help with tests
" ===========================
"
" This is a big section.
"
" All mappings are prefixed with \t.
"
" Read documentation for running Python from inside vim in python_test.vim.

if !exists('g:test_command')
	let g:test_command = $DEV_TEST_COMMAND
endif
if !exists('g:test_target')
	let g:test_target = ''
endif

" \tt runs tests.
map <localleader>tt :wall <CR>:execute Ban_Run('run-test '. ban#python#BuildTestCommand(g:test_command, g:test_target))<CR>
map t<CR> <localleader>tt

" \tC configure the test command (along with its arguments).
" Examples:
"   - pytest --pyargs
"   - python manage.py test -v 2
"   - python -m unittest
map <localleader>tC :let g:test_command='<c-r>=g:test_command<cr>'

" \tn Make a test name from current line contents
map <buffer> <localleader>tn :call ban#python#MakeValidPythonTestName() <CR>

" Mark the target and run tests
" -----------------------------

map <buffer> <localleader>ta :wall <CR>:call ban#python#RunAllTestSuite() <CR>
map <buffer> <localleader>tp :wall <CR>:call ban#python#RunCurrentTestPackage() <CR>
map <buffer> <localleader>t% :wall <CR>:call ban#python#RunCurrentTestModule() <CR>
map <buffer> <localleader>tc :wall <CR>:call ban#python#RunCurrentTestCase() <CR>
map <buffer> <localleader>tm :wall <CR>:call ban#python#RunCurrentTestMethod() <CR>
map <buffer> <localleader>tf :wall <CR>:call ban#python#RunCurrentTestFunction() <CR>


" Define some useful macros
" -------------------------

" copy current filename and function/method to register "z" in pytest format (JOE specific)

nmap <silent> <localleader>tr :let cursorpos = getcurpos() <CR>:call search('def test', 'besc') <CR>:execute 'normal bye' <CR>:let @z = substitute(expand('%'), '.*joe/tests/', '', '').'::'.getreg('"') <CR>:call setpos('.', cursorpos) <CR>:let test_cmd = "t " .trim(getreg('z'))<CR>:execute '!tmux send-keys -t JOE:src.1 -l "' .test_cmd. '"'<CR>:execute '!tmux send-keys -t JOE:src.1 Enter'<CR><CR>

