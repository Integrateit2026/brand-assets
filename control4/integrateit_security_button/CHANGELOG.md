# Changelog — IntegrateIT Security Button

## [0.1.2] - 2026-08-26
- describe the shipped art accurately: platinum band + state-aware padlock (docs/catalog only)

## [0.1.1] - 2026-08-26
- premium shield art: platinum band with shine sweeping all the way around, IntegrateIT-blue glossy face, open padlock when disarmed and closed when armed

## [0.1.0] - 2026-08-26
- Initial release: one Navigator experience button that arms/disarms the security
  system. Blue glossy IntegrateIT shield = Disarmed, red = Armed; the icon flips
  on every toggle (`ICON_CHANGED` icon states).
- Three press behaviors: Toggle Armed / Disarmed (default), Request Only
  (programming confirms from real panel feedback — the shield never lies), and
  Disabled (status-only mirror).
- Events: Pressed, Arm Requested, Disarm Requested, Armed, Disarmed, Loop Guard
  Tripped. Variables: SECURITY_STATE, IS_ARMED, LAST_CHANGE_SOURCE. Actions:
  Set Armed / Set Disarmed / Toggle / Refresh Navigator State / Print Configuration.
- Safety rails ported from the Experience State Button: silent reboot restore,
  SELECT+DO_CLICK press debounce, three-layer loop guard, strict-boolean state
  inputs (fail-safe), non-finite property clamping.
- Branded icon set rendered by `gen_icons_shield.py` (chrome rim, glossy body,
  keyhole, alpha-cropped IntegrateIT wordmark plaque) at 70/90/300/512/1024 —
  static assets; deliberately no icons.spec.json.
