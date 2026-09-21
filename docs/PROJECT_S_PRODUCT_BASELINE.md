# Project S Product Baseline — MacD REV.01

Status: Foundation
Owner: Project S
Product role: Mac physical-interaction layer

## Product statement

MacD turns the MacBook lid from passive hardware into an intentional interaction surface.

The current depth/tilt effect is the visual foundation, not the final product boundary.

## Current technical strengths

- Built-in lid-angle sensing through IOKit HID.
- ScreenCaptureKit live capture.
- Metal rendering.
- Perspective / homography processing.
- Blur and dimming.
- Native menu-bar controls.
- Signed/notarized release workflow foundation.

## Core product boundary

Keep:
- Native implementation.
- Low-latency lid sensing.
- GPU-driven visual effects.
- Explicit permission onboarding for screen capture.
- Safe, reversible interactions.

Avoid:
- Hidden destructive actions.
- Triggering important actions from ambiguous lid motion without opt-in.
- Broad system automation inside MacD itself.
- Turning MacD into a second general-purpose launcher.

## Product direction

### P0 — Product ownership migration
Before a Project S public release:
- Choose a Project S product name and bundle identifier.
- Build an upgrade/migration plan before changing the existing identity.
- Replace upstream author/UI links while preserving Apache-2.0 attribution and NOTICE.
- Own Developer ID, notarization and release metadata.
- Keep upstream license history intact.

### P0 — Compatibility Matrix
Build a runtime compatibility record:
- Mac model identifier.
- Apple Silicon / Intel.
- macOS version.
- Lid sensor available.
- Sensor report type/resolution.
- Built-in display behaviour.
- ScreenCaptureKit permission result.
- Effect performance.

Unsupported devices must fail gracefully and explain why.

### P0 — Physical Interaction Engine
Extract lid behaviour into an event model:

Lid Sensor -> Filtering -> Gesture/State Engine -> Policies -> Effects/Actions

Core states:
- Open.
- Moving closed.
- Moving open.
- Partially closed/held.
- Near closed.
- Sleep transition.

The visual renderer should subscribe to this engine rather than own interaction policy.

### P1 — Modes

#### Visual
Current perspective / blur / dim behaviour.

#### Privacy
Optional visual privacy behaviour as the lid closes.
All behaviour must be user-visible and reversible.

#### Presentation
Allow lid-angle zones to influence presentation/focus UI without destructive automation.

#### Gesture
Opt-in deliberate hinge gestures for simple actions.
Gesture recognition must include:
- Velocity threshold.
- Direction.
- Hysteresis.
- Timeout.
- Debounce.
- Confirmation for high-impact actions.

### P1 — Profiles
Profiles may define visual and interaction policies:
- Default.
- Focus.
- Presentation.
- Privacy.
- Custom.

### P2 — Project S Bridge
Expose only safe state/events to other Project S apps:
- Current lid angle.
- Opening/closing state.
- Current MacD mode.

External apps may request profile changes through an authenticated local bridge.
MacD must not expose raw unrestricted command execution.

## Performance gates

- Smooth 30fps+ visual effect on supported devices.
- No runaway screen-capture session.
- No retained overlay after intentional reopening.
- Sensor polling remains lightweight.
- Permission denial results in a usable settings UI.
- External display configurations do not corrupt the built-in-display effect.

## App Store strategy

Investigate a sandbox-compatible edition separately.
Do not assume private/low-level sensor access and ScreenCaptureKit behaviour will be accepted unchanged.

Direct distribution remains the primary baseline until Store feasibility is proven.

## Success criteria

MacD succeeds when:
- The effect remains visually impressive.
- Lid movement gains repeatable daily utility.
- Physical gestures are intentional rather than gimmicky.
- Unsupported hardware is handled cleanly.
- Project S owns the release identity without losing required upstream attribution.
