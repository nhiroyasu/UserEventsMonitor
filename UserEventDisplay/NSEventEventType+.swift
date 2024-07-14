import AppKit

extension NSEvent.EventType {
    var displayText: String {
        switch self {
        case .leftMouseDown:
            return "LeftMouseDown"
        case .leftMouseUp:
            return "LeftMouseUp"
        case .rightMouseDown:
            return "RightMouseDown"
        case .rightMouseUp:
            return "RightMouseUp"
        case .mouseMoved:
            return "MouseMoved"
        case .leftMouseDragged:
            return "LeftMouseDragged"
        case .rightMouseDragged:
            return "RightMouseDragged"
        case .mouseEntered:
            return "MouseEntered"
        case .mouseExited:
            return "MouseExited"
        case .keyDown:
            return "KeyDown"
        case .keyUp:
            return "KeyUp"
        case .flagsChanged:
            return "FlagsChanged"
        case .appKitDefined:
            return "AppKitDefined"
        case .systemDefined:
            return "SystemDefined"
        case .applicationDefined:
            return "ApplicationDefined"
        case .periodic:
            return "Periodic"
        case .cursorUpdate:
            return "CursorUpdate"
        case .scrollWheel:
            return "ScrollWheel"
        case .tabletPoint:
            return "TabletPoint"
        case .tabletProximity:
            return "TabletProximity"
        case .otherMouseDown:
            return "OtherMouseDown"
        case .otherMouseUp:
            return "OtherMouseUp"
        case .otherMouseDragged:
            return "OtherMouseDragged"
        case .gesture:
            return "Gesture"
        case .magnify:
            return "Magnify"
        case .swipe:
            return "Swipe"
        case .rotate:
            return "Rotate"
        case .beginGesture:
            return "BeginGesture"
        case .endGesture:
            return "EndGesture"
        case .smartMagnify:
            return "SmartMagnify"
        case .quickLook:
            return "QuickLook"
        case .pressure:
            return "Pressure"
        case .directTouch:
            return "DirectTouch"
        case .changeMode:
            return "ChangeMode"
        default:
            return "Unknown"
        }
    }
}
