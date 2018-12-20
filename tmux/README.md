## Installation

In your home directory:
```bash
git clone https://github.com/chsitter/dotfiles.git .config
ln -s ~/.config/tmux ~/.tmux && ln -s ~/.tmux/.tmux.conf ~/.tmux.conf

cd .vim
git submodule init && git submodule update --remote
```

That's basically it, there is a problem with tpm at the moment, but that's for a rainy day
