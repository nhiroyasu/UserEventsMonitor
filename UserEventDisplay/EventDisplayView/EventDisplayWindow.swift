import Cocoa
import SwiftUI
import Combine

class EventDisplayWindow: NSWindow {
    let preferenceStore: PreferenceStore
    let eventPublisher = PassthroughSubject<NSEvent, Never>()
    var globalEventMonitor: Any?
    var eventMonitorCancellable: AnyCancellable?

    init(preferenceStore: PreferenceStore) {
        self.preferenceStore = preferenceStore

        let initialHeight: CGFloat
        let initialWidth: CGFloat
        let initialOriginX: CGFloat
        let initialOriginY: CGFloat
        if let mainScreen = NSScreen.main {
            initialHeight = mainScreen.visibleFrame.height
            initialWidth = mainScreen.visibleFrame.width
            initialOriginX = mainScreen.frame.width - initialWidth
            initialOriginY = mainScreen.visibleFrame.origin.y
        } else {
            initialHeight = 0.0
            initialWidth = 0.0
            initialOriginX = 0.0
            initialOriginY = 0.0
        }
        super.init(
            contentRect: NSRect(
                x: initialOriginX,
                y: initialOriginY,
                width: initialWidth,
                height: initialHeight
            ),
            styleMask: [.borderless],
            backing: .buffered,
            defer: false
        )

        collectionBehavior = [.fullScreenAuxiliary, .ignoresCycle, .stationary, .canJoinAllSpaces]
        level = .floating
        contentViewController = NSHostingController(
            rootView: EventDisplayView(
                size: CGSize(width: initialWidth, height: initialHeight),
                presenter: EventDisplayPresenter(),
                eventPublisher: eventPublisher.eraseToAnyPublisher(),
                fontScalePublisher: preferenceStore.fontScale.publisher,
                isVisibilityOnPublisher: preferenceStore.isVisibilityOn.publisher
            )
        )
        backgroundColor = .clear
        ignoresMouseEvents = true
        observeMonitorEvents()
        observeUserEvent(eventType: NSEvent.EventTypeMask(rawValue: preferenceStore.monitorEvents.value))
    }

    func observeMonitorEvents() {
        eventMonitorCancellable = preferenceStore.monitorEvents.publisher
            .sink { [weak self] value in
                self?.observeUserEvent(eventType: NSEvent.EventTypeMask(rawValue: value))
            }
    }

    func observeUserEvent(eventType: NSEvent.EventTypeMask) {
        if let globalEventMonitor = globalEventMonitor {
            NSEvent.removeMonitor(globalEventMonitor)
        }
        globalEventMonitor = NSEvent.addGlobalMonitorForEvents(matching: eventType) { [weak self] event in
            guard let self = self else { return }
            self.eventPublisher.send(event)
        }
    }

    deinit {
        eventPublisher.send(completion: .finished)
        eventMonitorCancellable?.cancel()
    }
}
