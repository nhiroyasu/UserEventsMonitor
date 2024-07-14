import Foundation

class PreferenceStore {
    private let userDefaults: UserDefaults
    let fontScale: PreferenceValue<CGFloat>
    let monitorEvents: PreferenceValue<UInt64>

    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
        self.fontScale = PreferenceValue(initialValue: userDefaults.fontScale)
        self.monitorEvents = PreferenceValue(initialValue: userDefaults.monitorEvents)
    }
}
