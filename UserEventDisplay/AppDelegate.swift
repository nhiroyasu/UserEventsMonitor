import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    private let preferenceStore = PreferenceStore(userDefaults: UserDefaults.standard)
    private var eventDisplayWindow: EventDisplayWindow?
    private var preferenceWindow: PreferenceWindow?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if AXIsProcessTrusted() {
            eventDisplayWindow = .init(
                preferenceStore: preferenceStore
            )
            eventDisplayWindow?.orderFront(nil)

            preferenceWindow = .init(
                preferenceStore: preferenceStore,
                userDefaults: UserDefaults.standard
            )
            preferenceWindow?.makeKeyAndOrderFront(nil)
            preferenceWindow?.center()
        } else {
            requestAccessibility()
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationDidBecomeActive(_ notification: Notification) {
        preferenceWindow?.makeKeyAndOrderFront(nil)
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}
