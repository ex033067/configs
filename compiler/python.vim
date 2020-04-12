let b:current_compiler = 'python'
let current_compiler = 'python'

if filereadable('Makefile')
	setlocal makeprg=TARGET=%\ make\ --no-print-directory\ --silent
elseif executable('pylint')
	setlocal makeprg=pylint\ %
elseif executable('flake8')
	setlocal makeprg=flake8\ %
endif
