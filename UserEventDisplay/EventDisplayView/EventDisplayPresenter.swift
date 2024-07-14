import Cocoa

struct EventViewData: Identifiable {
    let id: Double
    let title: String
    let detail: String?
    let time: String
    let eventType: NSEvent.EventType
}

class EventDisplayPresenter {
    func generateEventViewData(event: NSEvent) -> EventViewData {
        switch event.type {
        case .keyDown:
            let keyName = convertKeyCodeToString(keyCode: event.keyCode)
            return EventViewData(
                id: generateID(event: event),
                title: "\(getEventTypeText(type: event.type))[\(keyName)]",
                detail: nil,
                time: "\(getEventDate(timestamp: event.timestamp))",
                eventType: event.type
            )
        case .keyUp:
            let keyName = convertKeyCodeToString(keyCode: event.keyCode)
            return EventViewData(
                id: generateID(event: event),
                title: "\(getEventTypeText(type: event.type))[\(keyName)]",
                detail: nil,
                time: "\(getEventDate(timestamp: event.timestamp))",
                eventType: event.type
            )
        case .flagsChanged:
            var flags: String = ""
            if event.modifierFlags.contains(.command) {
                flags += "Command"
            }
            if event.modifierFlags.contains(.control) {
                flags += "Control"
            }
            if event.modifierFlags.contains(.option) {
                flags += "Option"
            }
            if event.modifierFlags.contains(.shift) {
                flags += "Shift"
            }
            if event.modifierFlags.contains(.capsLock) {
                flags += "CapsLock"
            }
            if event.modifierFlags.contains(.function) {
                flags += "Function"
            }
            if event.modifierFlags.contains(.numericPad) {
                flags += "NumericPad"
            }
            return EventViewData(
                id: generateID(event: event),
                title: "[\(flags)]",
                detail: nil,
                time: "\(getEventDate(timestamp: event.timestamp))",
                eventType: event.type
            )
        case .scrollWheel:
            return EventViewData(
                id: generateID(event: event),
                title: getEventTypeText(type: event.type),
                detail: String(format: "DeltaX: %.2f, DeltaY: %.2f", event.scrollingDeltaX, event.scrollingDeltaY),
                time: "\(getEventDate(timestamp: event.timestamp))",
                eventType: event.type
            )
        default:
            return EventViewData(
                id: generateID(event: event),
                title: getEventTypeText(type: event.type),
                detail: getMouseLocation(location: event.locationInWindow),
                time: "\(getEventDate(timestamp: event.timestamp))",
                eventType: event.type
            )
        }
    }

    func generateID(event: NSEvent) -> Double {
        event.timestamp
    }
}

extension EventDisplayPresenter {
    func getEventTypeText(type: NSEvent.EventType) -> String {
        type.displayText
    }

    func getEventDate(timestamp: TimeInterval) -> String {
        let systemUptime = ProcessInfo.processInfo.systemUptime
        let now = Date()
        let eventDate = now.addingTimeInterval(-systemUptime + timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss.SS"
        return dateFormatter.string(from: eventDate)
    }

    func getMouseLocation(location: CGPoint) -> String {
        String(
            format: "mouseX:%.2f, mouseY:%.2f",
            location.x,
            location.y
        )
    }

    func convertKeyCodeToString(keyCode: UInt16) -> String {
        switch keyCode {
        case 0x00:
            return "A"
        case 0x01:
            return "S"
        case 0x02:
            return "D"
        case 0x03:
            return "F"
        case 0x04:
            return "H"
        case 0x05:
            return "G"
        case 0x06:
            return "Z"
        case 0x07:
            return "X"
        case 0x08:
            return "C"
        case 0x09:
            return "V"
        case 0x0A:
            return "Section (ISO layout)"
        case 0x0B:
            return "B"
        case 0x0C:
            return "Q"
        case 0x0D:
            return "W"
        case 0x0E:
            return "E"
        case 0x0F:
            return "R"

        case 0x10:
            return "Y"
        case 0x11:
            return "T"
        case 0x12:
            return "1"
        case 0x13:
            return "2"
        case 0x14:
            return "3"
        case 0x15:
            return "4"
        case 0x16:
            return "6"
        case 0x17:
            return "5"
        case 0x18:
            return "="
        case 0x19:
            return "9"
        case 0x1A:
            return "7"
        case 0x1B:
            return "-"
        case 0x1C:
            return "8"
        case 0x1D:
            return "0"
        case 0x1E:
            return "]"
        case 0x1F:
            return "O"


        case 0x20:
            return "U"
        case 0x21:
            return "["
        case 0x22:
            return "I"
        case 0x23:
            return "P"
        case 0x24:
            return "Return"
        case 0x25:
            return "L"
        case 0x26:
            return "J"
        case 0x27:
            return "'"
        case 0x28:
            return "K"
        case 0x29:
            return ";"
        case 0x2A:
            return "\\"
        case 0x2B:
            return ","
        case 0x2C:
            return "/"
        case 0x2D:
            return "N"
        case 0x2E:
            return "M"
        case 0x2F:
            return "."

        case 0x30:
            return "Tab"
        case 0x31:
            return "Space"
        case 0x32:
            return "~"
        case 0x33:
            return "Delete"
        case 0x34:
            return "Enter (on Powerbook)"
        case 0x35:
            return "Esc"
        case 0x36:
            return "Right Cmd"
        case 0x37:
            return "Cmd (Apple)"
        case 0x38:
            return "Shift"
        case 0x39:
            return "Caps Lock"
        case 0x3A:
            return "Option"
        case 0x3B:
            return "Control"
        case 0x3C:
            return "Right Shift"
        case 0x3D:
            return "Right Option"
        case 0x3E:
            return "Right Control"
        case 0x3F:
            return "Fn/Globe"

        case 0x40:
            return "F17"
        case 0x41:
            return "Numeric Keypad ."
        case 0x43:
            return "Numeric Keypad *"
        case 0x45:
            return "Numeric Keypad +"
        case 0x47:
            return "Clear (or NumLock)"
        case 0x48:
            return "Volume Up"
        case 0x49:
            return "Volume Down"
        case 0x4A:
            return "Mute"
        case 0x4B:
            return "Numeric Keypad /"
        case 0x4C:
            return "Numeric Keypad Enter"
        case 0x4E:
            return "Numeric Keypad -"
        case 0x4F:
            return "F18"


        case 0x50:
            return "F19"
        case 0x51:
            return "Numeric Keypad ="
        case 0x52:
            return "Numeric Keypad 0"
        case 0x53:
            return "Numeric Keypad 1"
        case 0x54:
            return "Numeric Keypad 2"
        case 0x55:
            return "Numeric Keypad 3"
        case 0x56:
            return "Numeric Keypad 4"
        case 0x57:
            return "Numeric Keypad 5"
        case 0x58:
            return "Numeric Keypad 6"
        case 0x59:
            return "Numeric Keypad 7"
        case 0x5A:
            return "F20"
        case 0x5B:
            return "Numeric Keypad 8"
        case 0x5C:
            return "Numeric Keypad 9"
        case 0x5D:
            return "Yen (JIS layout)"
        case 0x5E:
            return "Underscore (JIS layout)"
        case 0x5F:
            return "Keypad Comma/Separator (JIS layout)"


        case 0x60:
            return "F5"
        case 0x61:
            return "F6"
        case 0x62:
            return "F7"
        case 0x63:
            return "F3"
        case 0x64:
            return "F8"
        case 0x65:
            return "F9"
        case 0x66:
            return "Eisu (JIS layout)"
        case 0x67:
            return "F11"
        case 0x68:
            return "Kana (JIS layout)"
        case 0x69:
            return "F13"
        case 0x6A:
            return "F16"
        case 0x6B:
            return "F14"
        case 0x6D:
            return "F10"
        case 0x6E:
            return "Menu (on PC)"
        case 0x6F:
            return "F12"

        case 0x71:
            return "F15"
        case 0x72:
            return "Help"
        case 0x73:
            return "Home"
        case 0x74:
            return "Page Up"
        case 0x75:
            return "Del (Below the Help Key)"
        case 0x76:
            return "F4"
        case 0x77:
            return "End"
        case 0x78:
            return "F2"
        case 0x79:
            return "Page Down"
        case 0x7A:
            return "F1"
        case 0x7B:
            return "Left Arrow"
        case 0x7C:
            return "Right Arrow"
        case 0x7D:
            return "Down Arrow"
        case 0x7E:
            return "Up Arrow"
        case 0x7F:
            return "Power (on PC)"
        default:
            return "Unknown"
        }
    }
}
