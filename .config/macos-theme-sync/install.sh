#!/bin/zsh
# Installation script for macOS Terminal theme-sync.
# Generates the LaunchAgent plist and loads it into launchctl.

PLIST_NAME="com.user.terminal-theme-sync.plist"
DEST_PLIST="$HOME/Library/LaunchAgents/$PLIST_NAME"
SYNC_SCRIPT="$HOME/.config/macos-theme-sync/sync.sh"

mkdir -p "$HOME/Library/LaunchAgents"

cat << PLIST_EOF > "$DEST_PLIST"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.user.terminal-theme-sync</string>
    <key>ProgramArguments</key>
    <array>
        <string>$SYNC_SCRIPT</string>
    </array>
    <key>WatchPaths</key>
    <array>
        <string>$HOME/Library/Preferences/.GlobalPreferences.plist</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
</dict>
</plist>
PLIST_EOF

# Unload if already loaded, then load
launchctl unload "$DEST_PLIST" 2>/dev/null
launchctl load "$DEST_PLIST"

echo "✅ macOS Terminal theme-sync installed and loaded."
