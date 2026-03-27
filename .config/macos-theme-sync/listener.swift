import Foundation

let themeNotification = NSNotification.Name("AppleInterfaceThemeChangedNotification")

DistributedNotificationCenter.default().addObserver(
    forName: themeNotification,
    object: nil,
    queue: .main
) { _ in
    let task = Process()
    task.executableURL = URL(fileURLWithPath: "/bin/zsh")
    task.arguments = ["/Users/chris/.config/macos-theme-sync/sync-terminal-theme.sh"]
    try? task.run()
}

RunLoop.main.run()

