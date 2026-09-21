# Project S Foundation Tasks — MacD

## P0
- [ ] Confirm Project S product name and bundle identifier.
- [ ] Define migration plan from current fork identity.
- [ ] Preserve Apache-2.0 attribution and NOTICE.
- [ ] Build model/macOS/sensor compatibility matrix.
- [~] Extract Physical Interaction Engine from rendering policy — normalized lid-state engine is now live; gesture/policy extraction remains.
- [x] Normalize lid states and transitions (open / opening / closing / held / nearClosed / unavailable).
- [ ] Verify ScreenCaptureKit permission-denied UX.
- [ ] Verify signed + notarized direct distribution under Project S credentials.

## P1
- [ ] Visual profile.
- [ ] Privacy profile.
- [ ] Presentation profile.
- [~] Opt-in gesture engine — safe quick-close/open and hold events with velocity/debounce implemented; user profile/action mapping remains.
- [ ] Profile switching.

## Exit gate
Foundation is complete only when hardware state, interaction policy and Metal rendering are cleanly separated and Project S owns release identity.
