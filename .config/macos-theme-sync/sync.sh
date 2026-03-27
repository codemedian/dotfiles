#!/bin/zsh
# Synchronize macOS Terminal theme with system appearance.
# Triggered by a LaunchAgent watching GlobalPreferences.

# Get current system appearance
MODE=$(defaults read -g AppleInterfaceStyle 2>/dev/null || echo "Light")
STATE_FILE="/tmp/terminal_theme_last_mode"
LAST_MODE=$(cat "$STATE_FILE" 2>/dev/null)

# If the mode hasn't changed, nothing to do
[[ "$MODE" == "$LAST_MODE" ]] && exit 0

# Record the new state
echo "$MODE" > "$STATE_FILE"

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
    # For regular Vim: trigger FocusGained to run our SyncBackground()
    # \1b[I is the escape sequence for FocusGained
    tmux list-panes -a -F '#{pane_id} #{pane_current_command}' | grep -E 'vim|nvim' | while read -r pane_id cmd; do
        tmux send-keys -t "$pane_id" "\e[I"
    done
fi
