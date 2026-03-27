#!/zsh
# Installation script for macOS Terminal theme-sync.
# Manages the LaunchAgent service idempotently.

PLIST_NAME="com.user.terminal-theme-sync.plist"
DEST_PLIST="$HOME/Library/LaunchAgents/$PLIST_NAME"

# 1. Ensure the directory exists
mkdir -p "$HOME/Library/LaunchAgents"

# 2. Verify the plist was correctly stowed
if [[ ! -f "$DEST_PLIST" ]]; then
    echo "❌ Error: $DEST_PLIST not found. Did stow fail?"
    exit 1
fi

# 3. Idempotently reload the service
# Unload if already loaded, then load from the stowed location
launchctl unload "$DEST_PLIST" 2>/dev/null
launchctl load "$DEST_PLIST"

echo "✅ macOS Terminal theme-sync agent loaded."
