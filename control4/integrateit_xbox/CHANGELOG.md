# Changelog — IntegrateIT Xbox

## [0.1.2] - 2026-08-29
- New Icon Set property (Composer > driver properties): Device Only (No Logo) — now the default, every tile is just the console — or IntegrateIT Branded (adds the IntegrateIT wordmark on the 300px+ tiles). The switch swaps the live tile files in place through Control4's File Interface (OS 3.3.0 C4Z alias), tells you the Navigator refresh order in Status, and re-asserts your choice after every driver update. Only the large tiles differ; watch-tile sizes are identical device-only art in both sets.

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
