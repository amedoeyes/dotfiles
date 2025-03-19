if exists("current_compiler")
  finish
endif
let current_compiler = "xmake"

CompilerSet makeprg=xmake
CompilerSet shellpipe=2>&1\ \|\ sed\ \'0,/^error:\ /s/^error:\ //'\ \|\ tee
CompilerSet errorformat+=%-G%.%#
