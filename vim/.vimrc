set nocompatible
filetype off

" figure out absolute path to vundlerc.vim and source it
let vundlerc = fnamemodify(resolve(expand('$HOME/.vimrc')), ':h') . "/.vundlerc.vim"
exec "source " . vundlerc

" change the mapleader from \ to ,
let mapleader  = ","

" YCM configuration
let g:ycm_extra_conf_globlist = ['~/Development/*','~/.ycm_extra_conf.py', '~/Documents/UCL/msc_thesis_adr/*', '!~/*']
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
"let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_always_populate_location_list = 1
let g:ycm_error_symbol = '✗'
let g:ycm_warning_symbol = '⚠'
let g:ycm_python_binary_path = '/usr/local/bin/python3'
let g:ycm_server_python_interpreter = '/usr/bin/python3'

let g:ycm_rust_src_path = '/usr/local/Cellar/rust/1.21.0/src'

let g:syntastic_python_python_exec = 'python3'

nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>

syntax on

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>
"
set hidden
set switchbuf=useopen     " reveal already opened files from quickfix buf rather than opening new buffers
set nowrap        " don't wrap lines
set tabstop    =4 " a tab is four spaces
set expandtab
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set number        " always show line numbers
set shiftwidth =4 " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     " set show matching parenthesis
set smartcase     " ignore case if search pattern is all lowercase, case sensitive otherwise
set smarttab      " insert tabs on the start of a line according to shiftwidth, not tabstop
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
set history    =1000  " rememmber more commands and search history
set undolevels =1000  " use many muchos levels of undo
set wildignore =*.swp,*.o,*.a,*.so
set title         " change the terminals title
set visualbell    " don't beep
set noerrorbells  " don't beep
set lazyredraw
set ttyfast
set backspace=indent,eol,start  " make backspace behave normally


set showcmd
set wildmenu
set wildmode   =list:longest
set cursorline
" set mouse=a
set laststatus=2
set grepprg=ack
set spelllang=en_gb

if v:version >= 703
    set relativenumber  " show line numbers relative to cursor
    set undofile        " creates a <FILENAME>.un~ file to undo even after file was closed/reopened
    set undodir=~/.vim/.undo,~/tmp,/tmp
endif

set termencoding=utf-8
set encoding=utf-8 nobomb
set list
set listchars=tab:▸\ ,trail:·,eol:¬,extends:#,nbsp:·

set nobackup
set noswapfile

" remove scrollbars vor macvim - might affect other gui versions as well
" set guioptions-=L
" set guioptions-=r
"
" if has("gui_running")
"    if has("gui_gtk2")
"       set guifont=Droid\ Sans\ Mono\ 11 linespace=0
"       "set guifont=Meslo\ 11 linespace=0
"    endif
" endif

set pastetoggle=<F2> " turns off auto indenting in vim

" ######## E F F I C I E N C Y  ######## "
nnoremap ; :

" <leader>i to toggle invisible characters
nnoremap <leader>i :set list!<CR>

" speed up viewport scrolling a bit
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>

" save when focus of a file is lost
au FocusLost * :wa

" add syntax highlighting for gradle
au BufRead,BufNewFile *.gradle setfiletype groovy

" use jk to end modes etc
inoremap jk <ESC>

" clear search highlight with <leader>/
nmap <silent> <leader>/ :nohlsearch<CR>
" use w!! to sudo write a file (if not opened as sudo)
cmap w!! w !sudo tee % > /dev/null

" strip trailing whitespaces in current file with <leader>W
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" reselect previously pasted text
nnoremap <leader>v V`]

" ######## P L U G I N S ######## "
" NERDTree
nmap <silent> <leader>n :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.o$', '\.gcda$', '\.gcno$', '\.test$', '\.so$', '^__pycache__$', '\.pyc$', '\.aux$', '\.fls$', '\.fdb_latexmk$']

" Open NERDTree automatically when Vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Airline
let g:airline_powerline_fonts = 1

" Ack - search for word under cursor
nnoremap <leader>a :Ack! "<cword>"<CR>
" use ack! instead of Ack -- do not switch current buffer to first result
cnoreabbrev ack Ack!

" TagBar
let g:tagbar_compact = 1
nnoremap <leader>l :TagbarToggle<CR>

" Man
runtime ftplugin/man.vim
nnoremap K :Man <cword><CR>
nnoremap <leader>K :!man <cword><CR>

" Docs
autocmd FileType python map <buffer> <leader>sd :YcmCompleter GetDoc <cword><CR>
autocmd FileType c,c++ map <buffer> <leader>sd :YcmCompleter GetDoc <cword><CR>

" for all files, but probably not a good idea?
"nnoremap <leader>sd :YcmCompleter GetDoc <cword><CR>  

" Nice wrapping for tex files
au BufRead,BufNewFile *.tex set wrap linebreak nolist textwidth=0 wrapmargin=0

" Cscope
if has('cscope')
" Make <C-]> use cscope DB
    set cscopetag
" Use cscope db before ctags
    set csto=0

    if has('quickfix')
        set cscopequickfix=s-,g-,d-,c-,t-,e-,f-,i-
    endif

    if filereadable("cscope.out")
        cs add cscope.out
    endif

    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

endif

" ######## C O L O R S C H E M E S ######## "

if &diff
    color github
    " diff mode
    set diffopt+=iwhite
else
    set bg=dark
    color gruvbox
    hi Normal ctermbg=None
endif
