" Vim/Neovim compiler plugin for pytest
" Reads pytest traceback output and populates the quickfix list.
"
" Usage (interactive):
"   :compiler pytest       " activate this plugin
"   :make                  " run tests; quickfix list is populated automatically
"   :make tests/test_foo.py  " run a single file
"
" Usage (from saved output file):
"   :compiler pytest       " set errorformat
"   :cfile quickfix.txt    " load saved pytest output into quickfix
"
" In both cases, navigate with:
"   :copen    open quickfix window
"   :cn / ]q  next error
"   :cp / [q  previous error
"   :cc N     jump to error N

if exists("current_compiler")
  finish
endif
let current_compiler = "pytest"

" Run tests and tee output to quickfix.txt so :cfile always works too
CompilerSet makeprg=uv\ run\ pytest\ 2>&1\ \|\ tee\ quickfix.txt

" errorformat — patterns evaluated top-to-bottom, first match wins.
"
" Multi-line error block:
"
"   E       TypeError: can't subtract offset-naive and offset-aware datetimes
"                                           <- blank line (continuation)
"   timeblob.py:37: TypeError               <- file/line that ends the block
"
" %E   starts multi-line match, captures message from the 'E   ...' line
" %-G  suppresses 'file:line: in funcname' traceback frames before %Z sees them
" %Z   ends the block, captures file and line number
" %C   absorbs all other continuation lines (blank lines, source context, etc.)
" %-G  suppresses everything else

CompilerSet errorformat=
      \%EE%*\\s%m,
      \%-G%f:%l:\ in\ %.%#,
      \%Z%f:%l:\ ,
      \%C%.%#,
      \%-G%.%#
