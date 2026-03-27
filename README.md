# dotfiles 🛠️

My macOS development environment dotfiles, managed with **GNU Stow**.

## 🏗️ Structure

This repository uses a **package-based** structure. Each folder at the root (e.g., `git/`, `nvim/`, `zsh/`) is a "package" that mirrors the `$HOME` directory layout.

- **`git/`**: Git configuration (`~/.config/git/config`)
- **`nvim/`**: Neovim (v0.11+) with `lazy.nvim` (`~/.config/nvim/`)
- **`tmux/`**: Tmux with gruvbox-based theme sync (`~/.config/tmux/`)
- **`vim/`**: Legacy Vim configuration (`~/.config/vim/`)
- **`zsh/`**: Zsh configuration with `ZDOTDIR` set to `~/.config/zsh/`
- **`macos-theme-sync/`**: Automatic terminal theme switching based on macOS system appearance.

## 🚀 Installation

### Prerequisites

- [GNU Stow](https://www.gnu.org/software/stow/)
- [Homebrew](https://brew.sh/)
- [Neovim Nightly](https://github.com/neovim/neovim/releases) (for v0.11+ LSP support)

### Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/codemedian/dotfiles.git ~/Projects/dotfiles
   cd ~/Projects/dotfiles
   ```

2. Run the installation script:
   ```bash
   ./install.sh
   ```

The script will:
- Symlink all configuration files into your `$HOME`.
- Ensure required directories exist.
- Register and load the macOS theme-sync LaunchAgent.

## 🌓 macOS Theme Sync

The `macos-theme-sync` package provides:
- A **Swift listener** that osservas OS-level theme changes reactively.
- A **Shell script** that updates the Terminal app's default and current settings.
- Integration with **Tmux**, **Vim**, and **Neovim** to trigger theme refreshes in open editors.

## 🛠️ Maintenance

To add a new configuration, create a package folder following the same structure and run `./install.sh`. Stow will automatically manage the symlinks.
