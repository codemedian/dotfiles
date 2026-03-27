#!/bin/zsh
# Idempotent LaunchAgent registration
PLIST_NAME="com.user.terminal-theme-sync.plist"
DEST_PLIST="$HOME/Library/LaunchAgents/$PLIST_NAME"

# Ensure the directory exists
mkdir -p "$HOME/Library/LaunchAgents"

# Check if stowed file exists
if [[ ! -f "$DEST_PLIST" ]]; then
    echo "❌ Error: $DEST_PLIST not found."
    exit 1
fi

# Reload service
launchctl unload "$DEST_PLIST" 2>/dev/null
launchctl load "$DEST_PLIST"
echo "✅ macOS Terminal theme-sync agent loaded."
