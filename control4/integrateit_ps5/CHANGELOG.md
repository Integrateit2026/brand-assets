# Changelog — IntegrateIT PlayStation 5

## [0.1.0] - 2026-08-29
- First release. Display-only AV source (branded-av-source template): satellite
  proxy named "PlayStation 5" + one HDMI OUT binding (HDMI + STEREO), so
  selecting the console in Watch switches the room's video input and audio path.
- Branded PS5 tile across the full Navigator AV icon ladder (driver-local
  generator; distinct from the Xbox sibling at every size).
- Deliberately NO power control: consoles have no reliable one-cable power
  protocol — wake from the DualSense / HDMI-CEC. Network wake-on-select is a
  roadmap item, append-only if it can be made reliable.
