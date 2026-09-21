import Testing
@testable import MacDuo

struct MacDProfileTests {
    @Test
    func defaultProfileDoesNotRouteGestures() {
        let policy = MacDProfile.defaultProfile.policy
        #expect(policy.gestureRoutingEnabled == false)
        #expect(policy.privacyIntentEnabled == false)
        #expect(policy.presentationIntentEnabled == false)
    }

    @Test
    func privacyProfileEnablesOnlyPrivacyIntent() {
        let policy = MacDProfile.privacy.policy
        #expect(policy.gestureRoutingEnabled)
        #expect(policy.privacyIntentEnabled)
        #expect(policy.presentationIntentEnabled == false)
    }

    @Test
    func presentationProfileEnablesOnlyPresentationIntent() {
        let policy = MacDProfile.presentation.policy
        #expect(policy.gestureRoutingEnabled)
        #expect(policy.privacyIntentEnabled == false)
        #expect(policy.presentationIntentEnabled)
    }

    @Test
    func rawValuesAreStableForPreferences() {
        #expect(MacDProfile(rawValue: "default") == .defaultProfile)
        #expect(MacDProfile(rawValue: "focus") == .focus)
        #expect(MacDProfile(rawValue: "presentation") == .presentation)
        #expect(MacDProfile(rawValue: "privacy") == .privacy)
        #expect(MacDProfile(rawValue: "custom") == .custom)
    }
}
