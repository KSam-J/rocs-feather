:syntax on
" :colorscheme delek
:set number
:set tabstop=4
:set softtabstop=0
:set expandtab
:set shiftwidth=4
:set smarttab
:set ignorecase

" Paste/Copy/Cut using system clipboard
" TODO: Add if OSX, use SystemCopy()
noremap <leader>y  "+y
noremap <leader>yy "+yy
noremap <leader>Y  "+y$
noremap <leader>d  "+d
noremap <leader>dd "+dd
noremap <leader>D  "+D
" }}}

" Backups {{{
" Backup into an easy to find directory
set backupdir=$HOME/.vim_backups
set directory=$HOME/.vim_backups//,$TMP//,$TEMP// " Use full path to file as swap name

" Make backup dir if doesn't exist
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
" }}}

" Persistent Undo {{{
" Make undo persistant after file closed
set undodir=$HOME/.vim_undodir
set undofile
set undoreload=10000        " Save entire buffer for undo on reload if less than this size

" Make undo dir if doesn't exist
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
" }}}


" Allow saving of files as sudo when vim wasn't started with sudo
" (throw away the stdin part of tee)
cmap w!! w !sudo tee > /dev/null %

" highlight all search matches
set hlsearch

" Escape Mapping
:imap jk <Esc>

" Enable Hyprid line numbering
:set number relativenumber

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

set background=dark

" let g:badwolf_darkgutter = 1    " Make gutter darker than background
" let g:badwolf_tabline = 3       " Make tabline lighter than background
" colorscheme badwolf             " Badwolf colorscheme
"colorscheme mustang

syntax enable                   " Enable syntax highlighting

