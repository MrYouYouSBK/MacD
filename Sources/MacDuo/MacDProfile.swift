import Foundation

enum MacDProfile: String, CaseIterable, Identifiable, Equatable, Sendable {
    case defaultProfile = "default"
    case focus
    case presentation
    case privacy
    case custom

    var id: String { rawValue }

    var title: String {
        switch self {
        case .defaultProfile: "Default"
        case .focus: "Focus"
        case .presentation: "Presentation"
        case .privacy: "Privacy"
        case .custom: "Custom"
        }
    }

    var policy: MacDProfilePolicy {
        switch self {
        case .defaultProfile:
            MacDProfilePolicy(
                gestureRoutingEnabled: false,
                privacyIntentEnabled: false,
                presentationIntentEnabled: false
            )
        case .focus:
            MacDProfilePolicy(
                gestureRoutingEnabled: true,
                privacyIntentEnabled: false,
                presentationIntentEnabled: false
            )
        case .presentation:
            MacDProfilePolicy(
                gestureRoutingEnabled: true,
                privacyIntentEnabled: false,
                presentationIntentEnabled: true
            )
        case .privacy:
            MacDProfilePolicy(
                gestureRoutingEnabled: true,
                privacyIntentEnabled: true,
                presentationIntentEnabled: false
            )
        case .custom:
            MacDProfilePolicy(
                gestureRoutingEnabled: true,
                privacyIntentEnabled: false,
                presentationIntentEnabled: false
            )
        }
    }
}

struct MacDProfilePolicy: Equatable, Sendable {
    let gestureRoutingEnabled: Bool
    let privacyIntentEnabled: Bool
    let presentationIntentEnabled: Bool
}
