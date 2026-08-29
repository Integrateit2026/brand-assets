# Changelog — IntegrateIT Xbox

## [0.1.1] - 2026-08-29
- Navigator tile is now the device itself: an original vector render of the Xbox Series X monolith — green vent-dot glow on the top face, power dot, disc slot — replacing the 0.1.0 typographic XBOX mark. No manufacturer logo artwork; xml_version bump forces the Navigator icon refresh.

## [0.1.0] - 2026-08-29
- First release. Display-only AV source (branded-av-source template): satellite
  proxy named "Xbox" + one HDMI OUT binding (HDMI + STEREO), so selecting the
  console in Watch switches the room's video input and audio path.
- Branded Xbox tile across the full Navigator AV icon ladder (driver-local
  generator; distinct from the PlayStation sibling at every size).
- Deliberately NO power control: consoles have no reliable one-cable power
  protocol — wake from the controller / HDMI-CEC. Network wake-on-select is a
  roadmap item, append-only if it can be made reliable.
