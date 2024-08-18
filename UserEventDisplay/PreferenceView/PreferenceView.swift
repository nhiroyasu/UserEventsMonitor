import SwiftUI
import Combine

struct PreferenceView: View {
    private let fontScaleMaxValue: CGFloat = 5.0
    private let fontScaleMinValue: CGFloat = 1.0
    private let size: CGSize
    private let preferenceStore: PreferenceStore
    private let userDefaults: UserDefaults

    @State private var fontScale: CGFloat
    @State private var monitorEvents: UInt64
    @State private var isVisibilityOn: Bool

    init(size: CGSize, preferenceStore: PreferenceStore, userDefaults: UserDefaults) {
        self.size = size
        self.preferenceStore = preferenceStore
        self.userDefaults = userDefaults
        self.fontScale = preferenceStore.fontScale.value
        self.monitorEvents = preferenceStore.monitorEvents.value
        self.isVisibilityOn = preferenceStore.isVisibilityOn.value
    }

    var body: some View {
        List {
            Section {
                Toggle(
                    isOn: $isVisibilityOn,
                    label: {
                        Text("Visibility")
                            .font(.body)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                )
                .toggleStyle(.checkbox)
            } header: {
                Text("Visibility")
                    .font(.title)
            }
            .listRowSeparator(.hidden)
            Section {
                Slider(
                    value: $fontScale,
                    in: fontScaleMinValue...fontScaleMaxValue,
                    step: 0.5
                ) {
                    EmptyView()
                } minimumValueLabel: {
                    Text(String(format: "%.1f", fontScaleMinValue))
                } maximumValueLabel: {
                    Text(String(format: "%.1f", fontScaleMaxValue))
                }
                .padding(.vertical, 16)
            } header: {
                Text("Font Scale")
                    .font(.title)
            }
            Section {
                ForEach(0..<eventMasks.count, id: \.self) { index in
                    Toggle(
                        isOn: .init(
                            get: {  monitorEvents & eventMasks[index].rawValue != 0 },
                            set: { isOn in
                                if isOn {
                                    monitorEvents |= eventMasks[index].rawValue
                                } else {
                                    monitorEvents &= ~eventMasks[index].rawValue
                                }
                                preferenceStore.monitorEvents.set(monitorEvents)
                                userDefaults.monitorEvents = monitorEvents
                            }
                        ),
                        label: {
                            Text(eventMasks[index].displayText)
                                .font(.body)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    )
                    .toggleStyle(.checkbox)
                }
            } header: {
                Text("Monitor Events")
                    .font(.title)
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.automatic)
        .frame(minWidth: size.width, minHeight: size.height)
        .onChange(of: fontScale, initial: false) { _, newValue in
            preferenceStore.fontScale.set(newValue)
            userDefaults.fontScale = newValue
        }
        .onChange(of: isVisibilityOn, initial: false) { _, newValue in
            preferenceStore.isVisibilityOn.set(newValue)
            userDefaults.isVisibilityOn = newValue
        }
    }
}

extension PreferenceView {
    var eventMasks: [NSEvent.EventTypeMask] {
        [
            .leftMouseDown,
            .leftMouseUp,
            .rightMouseDown,
            .rightMouseUp,
            .mouseMoved,
            .leftMouseDragged,
            .rightMouseDragged,
            .mouseEntered,
            .mouseExited,
            .keyDown,
            .keyUp,
            .flagsChanged,
            .appKitDefined,
            .systemDefined,
            .applicationDefined,
            .periodic,
            .cursorUpdate,
            .scrollWheel,
            .tabletPoint,
            .tabletProximity,
            .otherMouseDown,
            .otherMouseUp,
            .otherMouseDragged,
            .gesture,
            .magnify,
            .swipe,
            .rotate,
            .beginGesture,
            .endGesture,
            .smartMagnify,
            .pressure,
            .directTouch,
            .changeMode
        ]
    }
}
