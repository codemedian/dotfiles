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

# 0. Patch the Plist with the current HOME path (launchd requires absolute paths)
# We do this on the stowed file in ~/Library/LaunchAgents
echo "🔧 Patching Plist with absolute paths..."
sed -i '' "s|/Users/[^/]*|$HOME|g" "$DEST_PLIST"

# 1. Compile the Swift listener into a binary
# We put it in ~/.local/bin so it doesn't clutter the stowed config directory
# and doesn't get deleted if you unstow the package.
mkdir -p "$HOME/.local/bin"
echo "🔨 Compiling Terminal Theme Switcher..."
swiftc "$HOME/.config/macos-theme-sync/listener.swift" -o "$HOME/.local/bin/terminal-theme-switcher"

# 2. Reload service
launchctl unload "$DEST_PLIST" 2>/dev/null
launchctl load "$DEST_PLIST"
echo "✅ macOS Terminal theme-sync agent loaded."

# 3. Trigger the permission prompt immediately so the user can 'Allow' it now
echo "🔔 Triggering macOS Automation permission prompt..."
echo "   (Please click 'OK' if a popup appears asking for permission to control Terminal)"
osascript -e 'tell application "Terminal" to get name of settings set "Basic"' >/dev/null 2>&1
