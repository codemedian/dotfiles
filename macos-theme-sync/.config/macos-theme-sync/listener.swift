import Foundation

// 1. We MUST hold a reference to the observer token, 
// otherwise ARC deallocates it and the listener stops immediately.
let observer = DistributedNotificationCenter.default().addObserver(
    forName: NSNotification.Name("AppleInterfaceThemeChangedNotification"),
    object: nil,
    queue: .main
) { _ in
    print("Notification received!")
    let homeDir = FileManager.default.homeDirectoryForCurrentUser.path
    let task = Process()
    task.executableURL = URL(fileURLWithPath: "/bin/zsh")
    task.arguments = ["\(homeDir)/.config/macos-theme-sync/sync.sh"]
    
    do {
        try task.run()
        task.waitUntilExit()
        print("sync.sh executed successfully.")
    } catch {
        print("Failed to run sync.sh: \(error)")
    }
}

// Keep the script alive and listening
RunLoop.main.run()
