" re-wrap paragraph
map <F7>   gqap
" do it when in insert mode as well (and return to insert mode)
imap <F7> <Esc>gqapA

" emulate pine/pico's ctrl-k
map <C-k> dd
imap <C-k> <Esc>ddi

let g:syntastic_python_flake8_args = '--ignore=W191,E501,E128,W291,E126,E101'
let b:syntastic_checkers = ['flake8']
unlet! g:python_space_error_highlight
let g:pymode_syntax_indent_errors = 0
let g:pymode_syntax_space_errors = 0
