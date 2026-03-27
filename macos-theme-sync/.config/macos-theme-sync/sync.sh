#!/bin/zsh
# Synchronize macOS Terminal theme with system appearance.
# Get current system appearance
MODE=$(defaults read -g AppleInterfaceStyle 2>/dev/null || echo "Light")

# Determine the theme to apply
THEME="gruvbox-light"
[[ "$MODE" == "Dark" ]] && THEME="gruvbox-dark"

# Apply theme to all open Terminal windows/tabs and set as default for new ones
osascript -e "tell application \"Terminal\"
    set current settings of tabs of windows to settings set \"$THEME\"
    set default settings to settings set \"$THEME\"
end tell"

# If inside tmux or tmux is running, tell vim/nvim to refresh
if command -v tmux >/dev/null 2>&1 && tmux ls >/dev/null 2>&1; then
    tmux list-panes -a -F '#{pane_id} #{pane_current_command}' | grep -E 'vim|nvim' | while read -r pane_id cmd; do
        tmux send-keys -t "$pane_id" "\e[I"
    done
fi
