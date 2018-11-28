"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

execute pathogen#infect()

" Required:
set runtimepath+=~/.vim/bundle/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state(expand('~/.vim/bundle/'))
  call dein#begin(expand('~/.vim/bundle/'))

" Let dein manage dein
" Required:
  "call dein#add(expand('~/.vim/bundle/repos/github.com/Shougo/dein.vim'))
  call dein#add('Shougo/dein.vim')

  " Let dein manage dein
  " Required:
  call dein#add('~/.vim/bundle/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('tpope/vim-pathogen')
  call dein#add('junegunn/fzf.vim')
  " Git diff symbols in the gutter
  call dein#add('airblade/vim-gitgutter')
  " call dein#add('Shougo/neosnippet.vim')
  " call dein#add('Shougo/neosnippet-snippets')
  call dein#add('Shougo/vimshell')
  call dein#add('ctrlpvim/ctrlp.vim')
  call dein#add('MarcWeber/vim-addon-mw-utils')
  " call dein#add('vim-scripts/Gundo')
  call dein#add('tpope/vim-fugitive')
  call dein#add('vim-airline/vim-airline')
  call dein#add('tmhedberg/matchit')
  " call dein#add('scrooloose/nerdcommenter')
  " call dein#add('scrooloose/nerdtree')
  " Support .editorconfig files.
  call dein#add('editorconfig/editorconfig-vim')
  " call dein#add('vim-syntastic/syntastic')
  call dein#add('mileszs/ack.vim')
  " call dein#add('eikenb/acp')
  " call dein#add('duythinht/vim-coffee')
  call dein#add('godlygeek/tabular')
  " Interpret Markdown
  call dein#add('plasticboy/vim-markdown')
  " Run pep8 and other checkers (McCabe, Frosted) on python code.
  call dein#add('andviro/flake8-vim')
  call dein#add('klen/python-mode')
  call dein#add('MarcWeber/vim-addon-mw-utils')
  " Add a nice dark theme.
  " call dein#add('joshdick/onedark.vim')
  " Oceanic/Next theme immitates Sublime's
  " call dein#add('mhartington/oceanic-next')
  call dein#add('stephpy/vim-yaml')
  if !has('nvim')
    " Dynamic Autocomplete - needs a newer neovim
    call dein#add('Shougo/deoplete.nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
    " call dein#add('zchee/deoplete-clang')
    " call dein#add('zchee/deoplete-jedi')
  endif
  " From Adir:
  " call dein#add('davidhalter/jedi-vim')
  " call dein#add('fatih/vim-go')
  " call dein#add('kien/ctrlp.vim')
  " call dein#add('mileszs/ack.vim')
  " call dein#add('morhetz/gruvbox')
  " call dein#add('tpope/vim-surround')
  " call dein#add('christoomey/vim-tmux-navigator')
  " call dein#add('ekalinin/Dockerfile.vim')
  " call dein#add('majutsushi/tagbar')
  " call dein#add('skywind3000/asyncrun.vim')
  " call dein#add('w0rp/ale')

  " You can specify revision/branch/tag.
  " call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

  " Required:
  call dein#end()
  if dein#check_install()
    call dein#install()
  endif
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

"End dein Scripts-------------------------


" If installed using Homebrew
" set rtp+=/usr/local/opt/fzf
" If installed using git
set rtp+=~/.fzf

let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" try loading powerline
"python3 from powerline.vim import setup as powerline_setup
"python3 powerline_setup()
"python3 del powerline_setup

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0

let g:PyFlakeDisabledMessages = 'E501'
let g:PyFlakeOnWrite = 0
let g:PyFlakeDefaultComplexity=10
let g:PyFlakeAggressive = 0
let g:PyFlakeCWindow = 6
let g:PyFlakeSigns = 1
let g:PyFlakeSignStart = 1
let g:PyFlakeMaxLineLength = 160
let g:PyFlakeRangeCommand = 'Q'
let g:PyFlakeForcePyVersion = 3
let g:PyFlakeCheckers = 'pep8,mccabe,frosted'

" ack
let g:ackprg = "ag --vimgrep"

" deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#clang#libclang_path = '/usr/lib/llvm-6.0/lib/libclang.so.1'
let g:deoplete#sources#clang#clang_header = '/usr/include/clang/6.0/include/'
let g:deoplete#sources#clang#clang_complete_database = '.'

" airline
let g:airline_extensions = []       " disable all extensions
let g:airline_section_x = ""        " hide file type
let g:airline_section_y = ""        " hide file encoding

" cscope
if has("cscope")
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
endif

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

" plugins
" minibufferexplorer
map <leader>mbt :MBEToggle<cr>
map <leader>mbf :MBEFocus<cr>

" syntastic
let g:syntastic_python_pep8_args = "--max-line-size=180" 
let g:syntastic_python_flake8_args = "--max-line-size=180" 

"End dein Scripts-------------------------

if has("unix")
  " Source the setup file for all users:
  let FILE=expand("~/.vim/rc.pythonide")
  if filereadable(FILE)
    exe "source " . FILE
  endif
  let FILE=expand("~/.vim/rc_hebrew")
  if filereadable(FILE)
    exe "source " . FILE
  endif
  let FILE=expand("~/.vim/rc_rl")
  if filereadable(FILE)
    exe "source " . FILE
  endif
endif

" ==========================================================
" Basic Settings
" ==========================================================
syntax on                     " syntax highlighing
filetype on                   " try to detect filetypes
filetype plugin indent on     " enable loading indent file for filetype
set number                    " Display line numbers
set numberwidth=1             " using only 1 column (and 1 space) while possible
set background=dark           " We are using dark background in vim
set title                     " show title in console title bar
set wildmenu                  " Menu completion in command mode on <Tab>
set wildmode=full             " <Tab> cycles between all matching choices.

" don't bell or blink
set noerrorbells
set vb t_vb=

" Ignore these files when completing
set wildignore+=*.o,*.obj,.git,*.pyc,*~
set wildignore+=eggs/**
set wildignore+=*.egg-info/**

set grepprg=ack         " replace the default grep program with ack

" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

" Disable the colorcolumn when switching modes.  Make sure this is the
" first autocmd for the filetype here
"autocmd FileType * setlocal colorcolumn=0

""" Insert completion
" don't select first item, follow typing in autocomplete
set completeopt=menuone,longest,preview
set pumheight=6             " Keep a small completion window


""" Moving Around/Editing
set cursorline              " have a line indicate the cursor location
set ruler                   " show the cursor position all the time
set nostartofline           " Avoid moving cursor to BOL when jumping around
set virtualedit=block       " Let cursor move past the last char in <C-v> mode
set scrolloff=3             " Keep 3 context lines above and below the cursor
set backspace=2             " Allow backspacing over autoindent, EOL, and BOL
set showmatch               " Briefly jump to a paren once it's balanced
set nowrap                  " don't wrap text
set linebreak               " don't wrap textin the middle of a word
set autoindent              " always set autoindenting on
set smartindent             " use smart indent if there is no indent file
set tabstop=4               " <tab> inserts 4 spaces
set shiftwidth=4            " but an indent level is 2 spaces wide.
set softtabstop=4           " <BS> over an autoindent deletes both spaces.
set expandtab               " Use spaces, not tabs, for autoindent/tab key.
set shiftround              " rounds indent to a multiple of shiftwidth
set matchpairs+=<:>         " show matching <> (html mainly) as well
set foldmethod=indent       " allow us to fold on indents
set foldlevel=99            " don't fold by default

" don't outdent hashes
inoremap # #

" close preview window automatically when we move around
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

"""" Reading/Writing
set noautowrite             " Never write a file unless I request it.
set noautowriteall          " NEVER.
set noautoread              " Don't automatically re-read changed files.
set modeline                " Allow vim options to be embedded in files;
set modelines=5             " they must be within the first or last 5 lines.
set ffs=unix,dos,mac        " Try recognizing dos, unix, and mac line endings.

"""" Messages, Info, Status
set ls=2                    " allways show status line
set vb t_vb=                " Disable all bells.  I hate ringing/flashing.
set confirm                 " Y-N-C prompt if closing with unsaved changes.
set showcmd                 " Show incomplete normal mode commands as I type.
set report=0                " : commands always print changed line count.
set shortmess+=a            " Use [+]/[RO]/[w] for modified/readonly/written.
set ruler                   " Show some info, even without statuslines.
set laststatus=2            " Always show statusline, even if only 1 window.
"set statusline=[%l,%v\ %P%M]\ %f\ %r%h%w\ (%{&ff})\ %{fugitive#statusline()}

" displays tabs with :set list & displays when a line runs off-screen
set showbreak=↪\ 
set listchars=tab:→\ ,nbsp:␣,trail:•,extends:⟩,precedes:⟨,eol:↲
set list

""" Searching and Patterns
set ignorecase              " Default to using case insensitive searches,
set smartcase               " unless uppercase letters are used in the regex.
set smarttab                " Handle tabs more intelligently
set hlsearch                " Highlight searches by default.
set incsearch               " Incrementally search while typing a /regex

" disable backup
set nobackup
set nowritebackup
"set noswapfile

"""" Display
if has("gui_running")
    colorscheme desert
    " Remove menu bar
    set guioptions-=m

    " Remove toolbar
    set guioptions-=T
else
    colorscheme torte
endif

"colorscheme molokai
"colorscheme gruvbox

" Paste from clipboard
"map <leader>p "+p
map <leader>p "+gP

" treat long lines as break lines
map j gj
map k gk

" Quit window on <leader>q
nnoremap <leader>q :q<CR>

" hide matches on <leader>space
nnoremap <leader><space> :nohlsearch<cr>

" Remove trailing whitespace on <leader>S
nnoremap <leader>S :%s/\s\+$//<cr>:let @/=''<CR>

" Select the item in the list with enter
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" ==========================================================
" Javascript
" ==========================================================
au BufRead *.js set makeprg=jslint\ %

" Don't allow snipmate to take over tab
autocmd VimEnter * ino <c-j> <c-r>=TriggerSnippet()<cr>
" Use tab to scroll through autocomplete menus
"autocmd VimEnter * imap <expr> <Tab> pumvisible() ? "<C-N>" : "<Tab>"
"autocmd VimEnter * imap <expr> <S-Tab> pumvisible() ? "<C-P>" : "<S-Tab>"
snor <c-j> <esc>i<right><c-r>=TriggerSnippet()<cr>
let g:acp_completeoptPreview=1

" ===========================================================
" FileType specific changes
" ============================================================
" Mako/HTML
autocmd BufNewFile,BufRead *.mako,*.mak,*.jinja2 setlocal ft=html
autocmd FileType html,xhtml,xml,css setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

" Python
"au BufRead *.py compiler nose
au FileType python set omnifunc=pythoncomplete#Complete
au FileType python setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4 smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
au FileType coffee setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4 smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
au BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
" Don't let pyflakes use the quickfix window
let g:pyflakes_use_quickfix = 0



" Add the virtualenv's site-packages to vim path
if has('python')
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF
endif

" Load up virtualenv's vimrc if it exists
if filereadable($VIRTUAL_ENV . '/.vimrc')
    source $VIRTUAL_ENV/.vimrc
endif

if exists("&colorcolumn")
   set colorcolumn=79
endif
