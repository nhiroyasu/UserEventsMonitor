import Foundation

extension UserDefaults {
    enum Keys {
        static let fontScale = "fontScale"
        static let monitorEvents = "monitorEvents"
        static let isVisibilityOn = "isVisibilityOn"
    }

    var fontScale: CGFloat {
        get {
            if object(forKey: Keys.fontScale) == nil {
                return Constants.defaultFontScale
            } else {
                return CGFloat(float(forKey: Keys.fontScale))
            }
        }
        set {
            set(Float(newValue), forKey: Keys.fontScale)
        }
    }

    var monitorEvents: UInt64 {
        get {
            if let data = object(forKey: Keys.monitorEvents) {
                return (data as? UInt64) ?? Constants.defaultMonitorEvents.rawValue
            } else {
                return Constants.defaultMonitorEvents.rawValue
            }
        }
        set {
            set(newValue, forKey: Keys.monitorEvents)
        }
    }

    var isVisibilityOn: Bool {
        get {
            if object(forKey: Keys.isVisibilityOn) == nil {
                return true
            } else {
                return bool(forKey: Keys.isVisibilityOn)
            }
        }
        set {
            set(newValue, forKey: Keys.isVisibilityOn)
        }
    }
}
