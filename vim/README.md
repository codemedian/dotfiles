# Vim as an IDE 
for `C/C++`and `rust`

## Installation

In your home directory:
```bash
git clone https://github.com/chsitter/dotfiles.git .config
ln -s ~/.config/vim ~/.vim && ln -s ~/.vim/.vimrc ~/.vimrc

cd ~/config
vim +PlugInstall +qall
```

That's basically it, for the individual plugins that will throw errors when firing up vim please 
see the modules documentation.

