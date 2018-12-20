# Vim as an IDE 
for `C/C++`and `rust`

## Installation

In your home directory:
```bash
git clone https://github.com/chsitter/dotfiles.git .config
ln -s ~/.config/vim ~/.vim && ln -s ~/.vim/.vimrc ~/.vimrc

cd ~/config
git submodule init && git submodule update --remote
vim +PluginInstall +qall
```

That's basically it, for the individual plugins that will throw errors when firing up vim please 
see the modules documentation.

## List of Modules
- General
 - Valloric/YouCompleteMe.git
 - kien/ctrlp.vim
 - tpope/vim-fugitive
 - scrooloose/nerdcommenter
 - mileszs/ack.vim.git
 - scrooloose/nerdtree.git
 - majutsushi/tagbar.git
 - bling/vim-airline
- Rust Dev
 - rust-lang/rust.vim
- Colorschemes
 - tomasr/molokai
 - chriskempson/vim-tomorrow-theme
 - endel/vim-github-colorscheme
- Make it look pretty
 - ryanoasis/vim-devicons
- Tmux integration
 - christoomey/vim-tmux-navigator
 - benmills/vimux



