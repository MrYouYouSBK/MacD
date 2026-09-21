import Foundation

enum LidGesture: String, Equatable, Sendable {
    case quickClose
    case quickOpen
    case partialHold
    case nearClosedHold
}

struct LidGestureEvent: Equatable, Sendable {
    let gesture: LidGesture
    let angle: Double
    let angularVelocity: Double
    let timestamp: TimeInterval
}

struct LidGestureDetector {
    var quickVelocity: Double = 45
    var holdDuration: TimeInterval = 0.8
    var debounceDuration: TimeInterval = 0.9

    private var quickCloseLatched = false
    private var quickOpenLatched = false
    private var heldState: LidInteractionState?
    private var heldSince: TimeInterval?
    private var holdEmitted = false
    private var lastEventTime: TimeInterval = -.greatestFiniteMagnitude

    mutating func reset() {
        quickCloseLatched = false
        quickOpenLatched = false
        heldState = nil
        heldSince = nil
        holdEmitted = false
        lastEventTime = -.greatestFiniteMagnitude
    }

    mutating func update(
        state: LidInteractionState,
        angle: Double,
        angularVelocity: Double,
        at now: TimeInterval
    ) -> LidGestureEvent? {
        if state != .closing { quickCloseLatched = false }
        if state != .opening { quickOpenLatched = false }

        if state == .closing,
           angularVelocity <= -abs(quickVelocity),
           !quickCloseLatched {
            quickCloseLatched = true
            return emit(
                .quickClose,
                angle: angle,
                angularVelocity: angularVelocity,
                at: now
            )
        }

        if state == .opening,
           angularVelocity >= abs(quickVelocity),
           !quickOpenLatched {
            quickOpenLatched = true
            return emit(
                .quickOpen,
                angle: angle,
                angularVelocity: angularVelocity,
                at: now
            )
        }

        let isHoldState = state == .held || state == .nearClosed
        guard isHoldState else {
            heldState = nil
            heldSince = nil
            holdEmitted = false
            return nil
        }

        if heldState != state {
            heldState = state
            heldSince = now
            holdEmitted = false
            return nil
        }

        guard !holdEmitted,
              let heldSince,
              now - heldSince >= holdDuration else {
            return nil
        }

        holdEmitted = true
        return emit(
            state == .nearClosed ? .nearClosedHold : .partialHold,
            angle: angle,
            angularVelocity: angularVelocity,
            at: now
        )
    }

    private mutating func emit(
        _ gesture: LidGesture,
        angle: Double,
        angularVelocity: Double,
        at now: TimeInterval
    ) -> LidGestureEvent? {
        guard now - lastEventTime >= debounceDuration else { return nil }
        lastEventTime = now
        return LidGestureEvent(
            gesture: gesture,
            angle: angle,
            angularVelocity: angularVelocity,
            timestamp: now
        )
    }
}
