#!/bin/zsh

# Ensure ~/.config exists
mkdir -p "$HOME/.config"
mkdir -p "$HOME/Library/LaunchAgents"

# Get the directory of this script
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# List of packages to stow
packages=(
    git
    nvim
    tmux
    vim
    zsh
    macos-theme-sync
)

# Stow each package
for pkg in "${packages[@]}"; do
    echo "Stowing $pkg..."
    stow -R -d "$DOTFILES_DIR" -t "$HOME" "$pkg"
done

# Post-stow installation
if [ -x "$HOME/.config/macos-theme-sync/install.sh" ]; then
    echo "Configuring macOS theme sync..."
    "$HOME/.config/macos-theme-sync/install.sh"
fi

echo "✅ All dotfiles stowed and configured!"
