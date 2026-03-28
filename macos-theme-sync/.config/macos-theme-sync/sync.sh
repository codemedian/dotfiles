#!/bin/zsh
# Synchronize macOS Terminal theme with system appearance.
# Get current system appearance
MODE=$(defaults read -g AppleInterfaceStyle 2>/dev/null || echo "Light")

# Determine the theme to apply
THEME="gruvbox-light"
[[ "$MODE" == "Dark" ]] && THEME="gruvbox-dark"

# Save state for Neovim to watch
echo "$MODE" > "$HOME/.config/macos-theme-sync/theme_state"

# Apply theme to all open Terminal windows/tabs and set as default for new ones
osascript -e "tell application \"Terminal\"
    set current settings of tabs of windows to settings set \"$THEME\"
    set default settings to settings set \"$THEME\"
end tell"

# If inside tmux or tmux is running, tell vim/nvim to refresh and update tmux theme
if command -v tmux >/dev/null 2>&1 && tmux ls >/dev/null 2>&1; then
    # Update tmux's own theme (status bar, etc.)
    tmux source-file "$HOME/.config/tmux/${THEME}.conf"

    # Signal all Vim instances to refresh background (using SIGUSR1)
    # Neovim instances are already watching the 'theme_state' file
    pkill -USR1 -x vim 2>/dev/null
fi

