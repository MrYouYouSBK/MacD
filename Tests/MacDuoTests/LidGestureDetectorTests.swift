import Testing
@testable import MacDuo

struct LidGestureDetectorTests {
    @Test
    func quickCloseEmitsOnceUntilClosingStateResets() {
        var detector = LidGestureDetector(
            quickVelocity: 40,
            holdDuration: 0.8,
            debounceDuration: 0.5
        )

        let first = detector.update(
            state: .closing,
            angle: 70,
            angularVelocity: -60,
            at: 1.0
        )
        #expect(first?.gesture == .quickClose)

        let duplicate = detector.update(
            state: .closing,
            angle: 60,
            angularVelocity: -65,
            at: 1.2
        )
        #expect(duplicate == nil)

        _ = detector.update(
            state: .held,
            angle: 60,
            angularVelocity: 0,
            at: 2.0
        )

        let second = detector.update(
            state: .closing,
            angle: 50,
            angularVelocity: -55,
            at: 2.2
        )
        #expect(second?.gesture == .quickClose)
    }

    @Test
    func quickOpenUsesPositiveVelocity() {
        var detector = LidGestureDetector(
            quickVelocity: 40,
            holdDuration: 0.8,
            debounceDuration: 0.5
        )

        let event = detector.update(
            state: .opening,
            angle: 65,
            angularVelocity: 52,
            at: 1.0
        )
        #expect(event?.gesture == .quickOpen)
    }

    @Test
    func partialHoldRequiresStableDuration() {
        var detector = LidGestureDetector(
            quickVelocity: 40,
            holdDuration: 0.8,
            debounceDuration: 0.5
        )

        #expect(detector.update(
            state: .held,
            angle: 60,
            angularVelocity: 0,
            at: 1.0
        ) == nil)

        #expect(detector.update(
            state: .held,
            angle: 60,
            angularVelocity: 0,
            at: 1.6
        ) == nil)

        let event = detector.update(
            state: .held,
            angle: 60,
            angularVelocity: 0,
            at: 1.9
        )
        #expect(event?.gesture == .partialHold)

        #expect(detector.update(
            state: .held,
            angle: 60,
            angularVelocity: 0,
            at: 2.2
        ) == nil)
    }

    @Test
    func nearClosedHoldIsDistinct() {
        var detector = LidGestureDetector(
            quickVelocity: 40,
            holdDuration: 0.5,
            debounceDuration: 0.2
        )

        _ = detector.update(
            state: .nearClosed,
            angle: 12,
            angularVelocity: 0,
            at: 3.0
        )
        let event = detector.update(
            state: .nearClosed,
            angle: 12,
            angularVelocity: 0,
            at: 3.6
        )
        #expect(event?.gesture == .nearClosedHold)
    }

    @Test
    func debounceSuppressesDifferentGesturesTooCloseTogether() {
        var detector = LidGestureDetector(
            quickVelocity: 40,
            holdDuration: 0.8,
            debounceDuration: 1.0
        )

        #expect(detector.update(
            state: .closing,
            angle: 70,
            angularVelocity: -60,
            at: 1.0
        )?.gesture == .quickClose)

        _ = detector.update(
            state: .held,
            angle: 70,
            angularVelocity: 0,
            at: 1.1
        )

        #expect(detector.update(
            state: .opening,
            angle: 80,
            angularVelocity: 60,
            at: 1.4
        ) == nil)
    }
}
