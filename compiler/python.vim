let b:current_compiler = "python"
let current_compiler = "python"

setlocal makeprg=pylint\ --output-format=text\ --msg-template=\"{path}:{line}:{column}:{C}:\ [{symbol}]\ {msg}\"\ --reports=no
setlocal errorformat=%A%f:%l:%c:%t:\ %m,%A%f:%l:\ %m,%A%f:(%l):\ %m,%-Z%p^%.%#,%-G%.%#
