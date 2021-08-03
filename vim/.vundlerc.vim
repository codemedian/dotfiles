set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'ycm-core/YouCompleteMe.git'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdcommenter'
Plugin 'mileszs/ack.vim.git'
Plugin 'scrooloose/nerdtree.git'
Plugin 'majutsushi/tagbar.git'
Plugin 'bling/vim-airline'

" YouCompleteMe unfortunately doesn't do python, syntastic does
" YCM disables syntastic for c etc, so this works just fine everything 
Plugin 'vim-syntastic/syntastic'

" ######## R U S T - D E V ########
Plugin 'rust-lang/rust.vim'
"Plugin 'racer-rust/vim-racer'


" ######## C O L O R S C H E M E S ########
Plugin 'tomasr/molokai'
Plugin 'chriskempson/vim-tomorrow-theme'
Plugin 'endel/vim-github-colorscheme'
Plugin 'altercation/vim-colors-solarized.git'
Plugin 'morhetz/gruvbox'
    

" ######## U S E L E S S - P R E T T Y ########
Plugin 'ryanoasis/vim-devicons'

" ######## T M U X - I N T E G R A T I O N ########
Bundle 'christoomey/vim-tmux-navigator'
Bundle 'benmills/vimux'

" ######## T E X - I N T E G R A T I O N ########
Plugin 'LaTeX-Box-Team/LaTeX-Box'

call vundle#end()            " required
filetype plugin indent on    " required
