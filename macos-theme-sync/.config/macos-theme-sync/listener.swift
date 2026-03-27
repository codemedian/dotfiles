import Foundation

DistributedNotificationCenter.default().addObserver(
    forName: NSNotification.Name("AppleInterfaceThemeChangedNotification"),
    object: nil,
    queue: .main
) { _ in
    let task = Process()
    task.executableURL = URL(fileURLWithPath: "/bin/zsh")
    task.arguments = ["/Users/chris/.config/macos-theme-sync/sync.sh"]
    try? task.run()
}

RunLoop.main.run()
