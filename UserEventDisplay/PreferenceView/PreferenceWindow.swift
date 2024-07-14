import Cocoa
import SwiftUI

class PreferenceWindow: NSWindow {
    init(
        preferenceStore: PreferenceStore,
        userDefaults: UserDefaults
    ) {
        let initialHeight: CGFloat = 400
        let initialWidth: CGFloat = 600
        super.init(
            contentRect: NSRect(
                x: 0,
                y: 0,
                width: initialWidth,
                height: initialHeight
            ),
            styleMask: [.titled, .closable, .miniaturizable, .resizable],
            backing: .buffered,
            defer: false
        )

        title = "Preferences"
        isReleasedWhenClosed = false
        contentViewController = NSHostingController(
            rootView: PreferenceView(
                size: CGSize(width: initialWidth, height: initialHeight),
                preferenceStore: preferenceStore,
                userDefaults: userDefaults
            )
        )
    }
}
