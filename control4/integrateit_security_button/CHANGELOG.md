# Changelog — IntegrateIT Security Button

## [0.1.6] - 2026-08-26
- Request Only now credits a confirmation to the person who asked for it: Last Change reads 'Programming (Navigator request)' instead of attributing every homeowner press to automation. The credit expires after 2 minutes, so a panel arming itself later is not mistaken for a press
- new Clear Loop Guard command + action releases a tripped guard on demand, so a dealer who just fixed a feedback loop can prove it instead of reaching for a driver reload
- the commissioning guide no longer ships factory build instructions a dealer cannot act on

## [0.1.5] - 2026-08-26
- Composer device-tree tiles are 16x16 and 32x32, not 32 and 300 - a 300px tile made the tree row render as an oversized smear

## [0.1.4] - 2026-08-26
- P0: Set Armed / Set Disarmed / Toggle / Refresh are now Composer PROGRAMMING commands, not just Actions-tab buttons - Request Only mode was uncompletable without them
- P1: panel confirmations are treated as ground truth and bypass the loop-guard rate ceiling, so a storm can no longer strand the shield showing the wrong state with no way back
- P1: the update check now refuses a manifest pointing at a different driver's .c4z, which would otherwise stage a foreign package under this driver's filename
- one physical press is now de-duplicated by identity rather than a time window, so its SELECT+DO_CLICK pair can no longer double-toggle; Press Debounce minimum raised to 250 ms
- update checks report failures in the Update Available property instead of only the console, and Automatic Update Check now actually starts and stops the daily poll
- auto-updates now come from the relay read-through mirror; docs rewritten to the DOC-CONTRACT spine with a Safety boundary section, and the package is 46% smaller

## [0.1.3] - 2026-08-26
- premium shield rebuild: machined platinum band, radially-lit face, satin-steel padlock, and a wordmark FITTED to the face instead of clipped by it (the logo was being cut); small tiles get a crisp lock-only cut

## [0.1.2] - 2026-08-26
- describe the shipped art accurately: platinum band + state-aware padlock (docs/catalog only)

## [0.1.1] - 2026-08-26
- premium shield art: platinum band with shine sweeping all the way around, IntegrateIT-blue glossy face, open padlock when disarmed and closed when armed

## [0.1.0] - 2026-08-26
- Initial release: one Navigator experience button that arms/disarms the security
  system. Blue glossy IntegrateIT shield = Disarmed, red = Armed; the icon flips
  on every toggle (`ICON_CHANGED` icon states).
- Three press behaviors: Toggle Armed / Disarmed (default), Request Only
  (programming confirms from real panel feedback), and Disabled (status-only
  mirror).
- Events: Pressed, Arm Requested, Disarm Requested, Armed, Disarmed, Loop Guard
  Tripped. Variables: SECURITY_STATE, IS_ARMED, LAST_CHANGE_SOURCE. Actions:
  Set Armed / Set Disarmed / Toggle / Refresh Navigator State / Print Configuration.
- Safety rails ported from the Experience State Button: silent reboot restore,
  SELECT+DO_CLICK press debounce, three-layer loop guard, strict-boolean state
  inputs (fail-safe), non-finite property clamping.
- Branded icon set rendered by `gen_icons_shield.py` (chrome rim, glossy body,
  keyhole, alpha-cropped IntegrateIT wordmark plaque) at 70/90/300/512/1024 —
  static assets; deliberately no icons.spec.json.
