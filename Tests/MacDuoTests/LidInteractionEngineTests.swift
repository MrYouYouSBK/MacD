import Testing
@testable import MacDuo

struct LidInteractionEngineTests {
    @Test
    func unavailableSensorProducesUnavailableState() {
        #expect(classify(available: false, angle: 100, velocity: 0) == .unavailable)
    }

    @Test
    func deliberateMotionTakesPriorityOverStaticZones() {
        #expect(classify(angle: 10, velocity: -3) == .closing)
        #expect(classify(angle: 10, velocity: 3) == .opening)
    }

    @Test
    func stationaryNearClosedLidProducesNearClosedState() {
        #expect(classify(angle: 15, velocity: 0) == .nearClosed)
    }

    @Test
    func stationaryLidAboveConfiguredThresholdIsOpen() {
        #expect(classify(angle: 100, velocity: 0, threshold: 90) == .open)
    }

    @Test
    func stationaryLidBelowThresholdButNotNearClosedIsHeld() {
        #expect(classify(angle: 60, velocity: 0, threshold: 90) == .held)
    }

    private func classify(
        available: Bool = true,
        angle: Double,
        velocity: Double,
        threshold: Double = 90
    ) -> LidInteractionState {
        LidInteractionEngine.classify(
            isSensorAvailable: available,
            angle: angle,
            angularVelocity: velocity,
            openThreshold: threshold,
            closingSpeed: 2,
            openingSpeed: 2
        )
    }
}
