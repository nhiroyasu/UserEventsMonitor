import SwiftUI
import Combine

extension AnyTransition {
    static var moveAndFade: AnyTransition {
        AnyTransition.move(edge: .leading)
    }
}

struct EventDisplayView: View {
    let size: CGSize
    let presenter: EventDisplayPresenter
    let eventPublisher: AnyPublisher<NSEvent, Never>
    let fontScalePublisher: AnyPublisher<CGFloat, Never>
    let isVisibilityOnPublisher: AnyPublisher<Bool, Never>

    private let bufferingEventCount = 50

    @State private var listData: [EventViewData] = []
    @State private var fontScale: CGFloat = 1.0
    @State private var isVisibilityOn = true

    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(listData) { data in
                        VStack(alignment: .trailing, spacing: 4) {
                            HStack(alignment: .firstTextBaseline, spacing: 0) {
                                Text(data.title)
                                    .font(.custom("SF Mono", size: 24 * fontScale))
                                    .bold()
                                Text(" - \(data.time)")
                                    .font(.custom("SF Mono", size: 24 * fontScale))
                                    .bold()
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            VStack(alignment: .trailing) {
                                if let detail = data.detail {
                                    Text(detail)
                                }
                            }
                            .font(.custom("SF Mono", size: 18 * fontScale))
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .multilineTextAlignment(.trailing)
                        }
                        .transition(.push(from: .top))
                    }
                }
            }
        }
        .padding(.horizontal, 32)
        .padding(.top, 16)
        .frame(width: size.width, height: size.height)
        .foregroundStyle(Color.white)
        .background(Color.clear)
        .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 5)
        .opacity(isVisibilityOn ? 1 : 0)
        .onReceive(eventPublisher) { event in
            let eventData = presenter.generateEventViewData(event: event)
            if listData.count == bufferingEventCount {
                withAnimation {
                    _ = listData.removeLast()
                }
            }
            if listData.first?.eventType == event.type {
                listData[0] = eventData
            } else {
                withAnimation {
                    listData.insert(eventData, at: 0)
                }
            }
        }
        .onReceive(eventPublisher.delay(for: .seconds(3), scheduler: RunLoop.main), perform: { event in
            let id = presenter.generateID(event: event)
            withAnimation {
                listData.removeAll(where: { $0.id == id })
            }
        })
        .onReceive(fontScalePublisher, perform: { fontScale in
            self.fontScale = fontScale
        })
        .onReceive(isVisibilityOnPublisher, perform: { isVisibilityOn in
            self.isVisibilityOn = isVisibilityOn
        })
    }
}
