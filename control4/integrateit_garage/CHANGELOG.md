# Changelog: IntegrateIT Garage

## [0.9.4] - 2026-07-31
- Certification pass: this driver was read end to end against its own manifest and code — every command, action, event, variable and property name checked for a single spelling across the manifest, the code and this guide; every programming recipe rebuilt from names that actually exist; the commissioning path checked to end in something a dealer can observe; and every claim in the documentation verified against what the code does rather than what it intended.

## [0.9.3] - 2026-07-26
- Documentation rebuilt to the IntegrateIT commissioning-guide standard: uniform sections, honest contracts, verified claim-by-claim against the code.

## [0.9.2] - 2026-07-19
- Hardware-test-worthy polish: correctness, edge-case, timer-hygiene and hardware-readiness fixes with a regression test added per fix
- Shared runtime: a transient license-server error no longer de-licenses a paying controller; repeating-timer callbacks are crash-guarded

## [0.9.1] - 2026-07-16
- Navigator tap now always pulses a one-relay momentary opener when the door state is unknown (new default: Pulse Relay); relay-only installs are the assumed baseline (contacts default 0)
- Icons packed at both c4z roots so Composer device icons and Navigator buttons render; packaging gate verifies every XML asset reference resolves
- Init errors surface in the Status property instead of failing silently

## [0.9.0] - 2026-07-14

- Added an original IntegrateIT clean-room garage-door runtime for documented Control4 relay, contact-sensor, button-link, and UI-button contracts.
- Added one, two, and three relay topologies with Momentary, Trigger, Maintained, Press and Hold, inverted logic, and break-before-make direction handling.
- Added zero, one, and two contact modes with independent polarity, debounce, endpoint truth table, external-movement inference, conflict detection, and travel failures.
- Added close-warning delay with cancellation, bounded left-open repeats, strict command gates, safe unknown-state Toggle behavior, and relay-safe Test Mode simulations.
- Added persistent supervised state, nine programming variables, thirteen events, Composer actions, button links, diagnostics, and eight Navigator state icons.
- Added an IntegrateIT Commissioning Book documentation tab with safety boundary, setup sequence, binding map, programming reference, troubleshooting, and licensing guidance.
- Added 304 runtime assertions plus static, package, Lua 5.1, lifecycle, license, timer, and golden regression gates.
