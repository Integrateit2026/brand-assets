# Changelog — IntegrateIT UniFi NVR HDMI

## [3.0.1] - 2026-07-31
- Certification pass: this driver was read end to end against its own manifest and code — every name checked for a single spelling across the manifest, the code and this guide, and every claim in the documentation verified against what the code does rather than what it intended.
- The guide gained the Program the project section the documentation contract requires. It says plainly that there is nothing on this driver to program — a display-only source declares no commands, no device events and no variables, so any of those here would be fiction — and then shows where the automation actually lives: the room selects the source, the matrix routes the HDMI, and a doorbell-to-theater recipe demonstrates the shape. A stale reference to the package's internal version number was removed rather than left to go stale again.
- Two latent release blockers, both found by trying to release: a test pinned the running build's version to the literal 3.0.0, and the golden-artifact comparison rewrote this driver's minimum OS version because it happened to read the same as its driver version. Either one would have failed the first patch release. Both are fixed at the root, so this driver can be updated normally from here.

## [3.0.0] - 2026-07-26
- Factory integration of the field-proven hand-built driver, crediting the v1-v3 lineage: v2 was proven routing video on an AVPro Edge MX Pro matrix, and v2's blank icon was root-caused to the state-block-vs-flat-ladder Navigator bug and fixed in v3.
- Same display-only contract: a satellite source proxy exposing one HDMI OUT binding (classes HDMI + STEREO) for the UniFi NVR G2 live-view output, with the branded aperture-tile Navigator icon ladder rendered as a flat ladder (never state blocks).
- New over the hand-built lineage: self-update from the IntegrateIT channel, the packaged Documentation tab, and static + runtime + golden QA — plus the name-equals-filename controller:// URL validator this driver contributed to the whole fleet.
- xmlVersion bumped to 4 (Control4 fact #5 - a re-release must bump the integer version or Navigators keep the stale icon).
