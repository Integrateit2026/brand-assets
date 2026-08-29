# Changelog — IntegrateIT PlayStation 5

## [0.1.1] - 2026-08-29
- Navigator tile is now the device itself: an original vector render of the PlayStation 5 tower — white flared fins, black core, blue light seam, round stand — replacing the 0.1.0 typographic PS5 mark. No manufacturer logo artwork; xml_version bump forces the Navigator icon refresh.

## [0.1.0] - 2026-08-29
- First release. Display-only AV source (branded-av-source template): satellite
  proxy named "PlayStation 5" + one HDMI OUT binding (HDMI + STEREO), so
  selecting the console in Watch switches the room's video input and audio path.
- Branded PS5 tile across the full Navigator AV icon ladder (driver-local
  generator; distinct from the Xbox sibling at every size).
- Deliberately NO power control: consoles have no reliable one-cable power
  protocol — wake from the DualSense / HDMI-CEC. Network wake-on-select is a
  roadmap item, append-only if it can be made reliable.
