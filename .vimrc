set nocompatible

" figure out absolute path to vundlerc.vim and source it
let vimplugrc = fnamemodify(resolve(expand('$HOME/.vimrc')), ':h') . "/.vim/vimplugrc.vim"
exec "source " . vimplugrc

" load COC plugin config from file
let cocrc = fnamemodify(resolve(expand('$HOME/.vimrc')), ':h') . "/.vim/cocrc.vim"
exec "source " . cocrc

" change the mapleader from \ to ,
let mapleader  = ","

syntax on
" Use new regular expression engine
set re=0

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>
""

set hidden        " hide a buffer with unsaved changes when a new one is opened, access with :ls
set switchbuf=useopen  " reveal already opened files from quickfix buf rather than opening new buffers
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
set undolevels =1000  " use many levels of undo
set wildignore =*.swp,*.o,*.a,*.so
set title         " change the terminals title
set visualbell    " don't beep
set noerrorbells  " don't beep
set backspace=indent,eol,start  " make backspace behave normally


set wildmenu
set wildmode   =list:longest
set cursorline   " highlight the line of the cursor
" set mouse=a
set laststatus=2
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

" use jk to end modes etc
inoremap jk <ESC>

" clear search highlight with <leader>/
nmap <silent> <leader>/ :nohlsearch<CR>
" use w!! to sudo write a file (if not opened as sudo)
cmap w!! w !sudo tee % > /dev/null

" strip trailing whitespaces in current file with <leader>W
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

"" reselect previously pasted text
nnoremap <leader>v V`]

" ######## P L U G I N S ######## "
" NERDTree
nmap <silent> <leader>n :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.o$', '\.gcda$', '\.gcno$', '\.test$', '\.so$', '^__pycache__$', '\.pyc$', '\.aux$', '\.fls$', '\.fdb_latexmk$']

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

"" Airline
let g:airline_powerline_fonts = 1

"" Ack - search for word under cursor
nnoremap <leader>a :Ack! "<cword>"<CR>
" use ack! instead of Ack -- do not switch current buffer to first result
cnoreabbrev ack Ack!

" Easy Align - Start interactive EasyAlign visual (x) and normal mode (n)
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" CTRL-P
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

"" Man
runtime ftplugin/man.vim
nnoremap K :Man <cword><CR>
nnoremap <leader>K :!man <cword><CR>

" Nice wrapping for tex files
au BufRead,BufNewFile *.tex set wrap linebreak nolist textwidth=0 wrapmargin=0

" ############# Syntax Highlighting stuff #############
au BufRead,BufNewFile *.gradle setfiletype groovy


"" ######## C O L O R S C H E M E S ######## "
if &diff
    color github
    "" diff mode
    set diffopt+=iwhite
else
    set bg=dark
    color gruvbox
    hi Normal ctermbg=None
endif

