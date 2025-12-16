call plug#begin('~/.config/vim/plugged')
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'junegunn/vim-easy-align'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdcommenter'
Plug 'mileszs/ack.vim'
Plug 'scrooloose/nerdtree'
" Plug 'majutsushi/tagbar'
Plug 'bling/vim-airline'

" ######## C O L O R S C H E M E S ########
Plug 'tomasr/molokai'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'endel/vim-github-colorscheme'
Plug 'altercation/vim-colors-solarized'
Plug 'morhetz/gruvbox'

" ######## U S E L E S S - P R E T T Y ########
Plug 'ryanoasis/vim-devicons'

" ######## L A N G U A G E S ########
" Plug 'TovarishFin/vim-solidity'
" Plug 'codemedian/cairo.vim'

" ######## T M U X - I N T E G R A T I O N ########
Plug 'christoomey/vim-tmux-navigator'
Plug 'benmills/vimux'

Plug 'scrooloose/nerdtree'

call plug#end()
