import Combine

final class PreferenceValue<T: Equatable> {
    private var _value: T
    private let _publisher: CurrentValueSubject<T, Never>

    init(initialValue: T) {
        self._value = initialValue
        self._publisher = CurrentValueSubject(initialValue)
    }
    
    func set(_ value: T) {
        self._value = value
        self._publisher.send(value)
    }

    var value: T {
        return _value
    }

    var publisher: AnyPublisher<T, Never> {
        return _publisher.eraseToAnyPublisher()
    }
}
