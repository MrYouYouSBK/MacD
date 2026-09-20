import Foundation

enum LidInteractionState: String, Equatable, Sendable {
    case unavailable
    case open
    case opening
    case closing
    case held
    case nearClosed
}

struct LidInteractionEngine {
    static let defaultNearClosedAngle: Double = 20

    static func classify(
        isSensorAvailable: Bool,
        angle: Double,
        angularVelocity: Double,
        openThreshold: Double,
        closingSpeed: Double,
        openingSpeed: Double,
        nearClosedAngle: Double = defaultNearClosedAngle
    ) -> LidInteractionState {
        guard isSensorAvailable else { return .unavailable }

        if angularVelocity <= -abs(closingSpeed) {
            return .closing
        }
        if angularVelocity >= abs(openingSpeed) {
            return .opening
        }
        if angle <= max(0, nearClosedAngle) {
            return .nearClosed
        }
        if angle >= openThreshold {
            return .open
        }
        return .held
    }
}
